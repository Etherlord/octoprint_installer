# About
Octoprint installer for Armbian systems

# How-to install

## Base armbian setup

1. Get Armbian for your board on https://www.armbian.com/download/
1. Install on your sd card - Example: https://www.albertogonzalez.net/how-to-install-armbian-debian-on-an-orange-pi-zero/
1. Boot and login as root
1. Run armbian-config and configure wifi

## Run octoprint installer

Download && run
```shell
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/octoprint_install.sh
chmod +x octoprint_install.sh
./octoprint_install.sh
```

After run the script enter password for octoprint system user and wait
after finishing the script, enter `reboot`.

Enjoy!
