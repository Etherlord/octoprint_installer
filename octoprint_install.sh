#!/bin/bash
useradd -m octo
usermod -a -G tty octo
usermod -a -G dialout octo
passwd octo
cd /home/octo
apt-get update
apt-get -y install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential virtualenv
su octo -c whoami
su octo -c 'mkdir OctoPrint'
cd OctoPrint
pwd
su octo -c 'virtualenv -p /usr/bin/python2.7 --quiet venv && /bin/bash -c "source venv/bin/activate && pip install pip --upgrade && pip install octoprint"'
wget https://github.com/foosel/OctoPrint/raw/master/scripts/octoprint.init && mv octoprint.init /etc/init.d/octoprint
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/octoprint.default && mv octoprint.default /etc/default/octoprint
chmod +x /etc/init.d/octoprint
update-rc.d octoprint defaults
cd /home/octo
apt-get -y install subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake
git clone https://github.com/jacksonliam/mjpg-streamer.git
cd mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make
apt-get -y install sudo
echo "octo ALL=NOPASSWD: /sbin/shutdown" >> /etc/sudoers
cd /home/octo
mkdir scripts
cd scripts
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/webcam
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/webcamDaemon
chmod +x webcam
chmod +x webcamDaemon
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/rc.local && mv rc.local /etc/rc.local