# About

Octoprint installer for:
* Armbian systems based on Debian Buster
* Ubuntu based (tested on 18.04)

# How-to install

## Base armbian setup

1. Get Armbian for your board on https://www.armbian.com/download/
1. Install on your sd card - Example: https://www.albertogonzalez.net/how-to-install-armbian-debian-on-an-orange-pi-zero/
1. Boot and login as root
1. Run armbian-config and configure wifi

## Run octoprint installer

Download && run
```shell
su -
wget https://raw.githubusercontent.com/Etherlord/octoprint_installer/master/octoprint_install.sh
chmod +x octoprint_install.sh
./octoprint_install.sh
```

Script enter password for octoprint system user and wait.
Open http://<SERVER_IP>:5000 after script finish work

Enjoy!

# Useful commands

## Show octoprint logs

```shell
journalctl --no-pager -b -u octoprint
```

## Show webcam logs

```shell
journalctl --no-pager -b -u octoprint
```

## Restart octoprint

```shell
sudo systemctl restart octoprint.service
```

### Restart webcam

```shell
systemctl restart webcam.service
```
