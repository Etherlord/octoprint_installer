#!/bin/bash

set -e

export HOMEDIR="/home/octo"

if [ "$EUID" -ne 0 ]; then
  echo "# Please run as root"
  exit 1
fi

function echo_yellow {
  TEXT="${@}"
  echo -e "\e[33m${TEXT}\e[0m"
}

function echo_green {
  TEXT="${@}"
  echo -e "\e[32m${TEXT}\e[0m"
}

function echo_red {
  TEXT="${@}"
  echo -e "\e[31m${TEXT}\e[0m"
}

function setup_venv {
  set -e
  mkdir ${HOMEDIR}/OctoPrint
  cd ${HOMEDIR}/OctoPrint
  virtualenv -p /usr/bin/python2.7 --quiet venv
  source venv/bin/activate
  pip install pip --upgrade
  pip install octoprint
}

export -f setup_venv

echo_yellow "# Create octo user"
useradd -m -s /bin/bash -G tty,dialout,video octo

echo_yellow "# Please password for octo user"
passwd octo

echo_yellow "# Install package dependencies"
apt-get update
# Python dependencies
apt-get -y install \
  build-essential \
  curl \
  git \
  libyaml-dev \
  python-dev \
  python-pip \
  python-setuptools \
  python-virtualenv \
  virtualenv
# ffmpeg && mjpg-streamer build dependencies
apt-get -y install \
  cmake \
  ffmpeg \
  git \
  imagemagick \
  libjpeg62-turbo-dev \
  libv4l-dev \
  sudo

echo_yellow "# Configure OctoPrint VirtualEnv"
su octo -c "setup_venv"

echo_yellow "# Configure OctoPrint autostart"
curl -fsvL \
  -o /etc/systemd/system/octoprint.service \
  https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/octoprint.service
curl -fsvL \
  -o /etc/default/octoprint \
  https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/octoprint.default

echo_yellow "# Build mjpg-streamer"
git clone https://github.com/jacksonliam/mjpg-streamer.git /home/octo/mjpg-streamer
cd /home/octo/mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make
cp -v /home/octo/mjpg-streamer/mjpg-streamer-experimental/_build/mjpg_streamer /usr/local/bin/mjpg_streamer

echo_yellow "# Configure scripts"
echo "octo ALL=NOPASSWD: /sbin/shutdown,/usr/bin/systemctl restart octoprint.service" >> /etc/sudoers
curl -fsvL \
  -o /etc/systemd/system/webcam.service \
  https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/webcam.service
curl -fsvL \
  -o /usr/local/bin/webcamDaemon\
  https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/webcamDaemon
chmod +x /usr/local/bin/webcamDaemon

systemctl daemon-reload

for SERVICE in $(echo octoprint webcam); do
  set +e
  systemctl enable ${SERVICE}.service
  systemctl start ${SERVICE}.service
  sleep 10
  systemctl is-active --quiet ${SERVICE}.service
  if [ $? -ne 0 ]; then
    echo_red "# Service ${SERVICE} not running! Check it:"
    echo_red "# Run for logs: journalctl --no-pager -b -u ${SERVICE}.service"
  else
    echo_green "# Service ${SERVICE} OK."
  fi
done

echo_green "# All done! Try to open web interface with this link:"
for IP in $(hostname --all-ip-addresses | grep -v '127.0.0.1'); do
  echo_green "# Listen http://${IP}:5000"
done
