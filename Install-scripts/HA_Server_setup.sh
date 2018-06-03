#!/bin/bash

# to run first chmod a+x AH_Server_setup.sh

echo "updating and upgrading the system"
    #Update and upgrade the system
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove -y

sudo 
    #Install Python
    #not needed on current build
#sudo apt-get install pyton3 python3-pip

echo "installing rmate"
   #install rmate
sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
chmod a+x /usr/local/bin/rmate

echo "adding rmate alias to .bashrc"
   #start rmate when current user logs on
echo "alias code='rmate -p 52698'" >> .bashrc

echo "installing git" 
  #install git
apt-get install git

echo "installing home assistant"
  #install home assistant
  
    #may need a sqlalchemy install
    #some installations do not have a valid version of sqlalchemy reinstalling will not hurt
sudo pip3 install sqlalchemy
sudo pip3 install --upgrade homeassistant

    # if service does not auto install uncomment these lines otherwise comment them out.
sudo touch /etc/systemd/system/home-assistant@hass.service

sudo echo "[Unit]" > /etc/systemd/system/home-assistant@hass.service
sudo echo "Description=Home Assistant" >> /etc/systemd/system/home-assistant@hass.service
sudo echo "After=network.target" >> /etc/systemd/system/home-assistant@hass.service
sudo echo " " >> /etc/systemd/system/home-assistant@hass.service
sudo echo "[Service]" >> /etc/systemd/system/home-assistant@hass.service
sudo echo "Type=simple" >> /etc/systemd/system/home-assistant@hass.service
sudo echo "User=pi" >> /etc/systemd/system/home-assistant@hass.service
sudo echo "ExecStart=/usr/local/bin/hass" >> /etc/systemd/system/home-assistant@hass.service
sudo echo " ">> /etc/systemd/system/home-assistant@hass.service
sudo echo "[Install]" >> /etc/systemd/system/home-assistant@hass.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/home-assistant@hass.service

sudo systemctl --system daemon-reload
sudo systemctl enable hass.service

    #stop commenting for service installation.

echo "setting up home assistant aliases"
  #setup home assistant service aliases (to make life easier)
echo "alias hrestart='sudo systemctl restart hass'" >> .bashrc
echo "alias hstop='sudo systemctl stop hass'" >> .bashrc
echo "alias hstart='sudo systemctl start hass'" >> .bashrc



echo "Installations complete"
echo "no error checking done"

echo " "
echo " "

echo "please change your password by typing passwd"
echo "please change the root password by typing passwd root"

sudo reboot
