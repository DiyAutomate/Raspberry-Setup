#!/bin/bash

# to run first chmod a+x AH_Server_setup.sh

echo "updating and upgrading the system"
    #Update and upgrade the system
sudo apt-get update -qq
sudo apt-get upgrade -y -qq

    #Install Python
    #not needed on current build
#sudo apt-get install pyton3 python3-pip

echo "installing rmate"
   #install rmate
sudo wget -O /usr/local/bin/rmate https:raw.github.com/aurora/rmate/master/rmate
sudo chmod a+x /usr/local/bin/rmate

echo "adding rmate alias to .bashrc"
   #start rmate when current user logs on
echo "alias code='rmate - 52698'" >> .bashrc

echo "installing git" 
  #install git
sudo apt-get install git -qq

echo "installing home assistant"
  #install home assistant
pip3 install homeassistant

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
