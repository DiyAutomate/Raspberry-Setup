#!/bin/bash

#step one update /etc/rc.local to change the user name
    #delete the exit code so we can move it to the end.
sudo sed -i /'exit 0'/d /etc/rc.local
    #write out needed lines
    # 1 - change the user name (copies user profile)
sudo echo "usermod -l haadmin -d /home/haadmin -m pi" >> /etc/rc.local
    # 2 - update sudoers so that sudo works the way we want (does not ask for password)
sudo echo "mv /etc/sudoers.d/010_pi-nopasswd /etc/sudoers.d/010_haadmin-nopasswd" >> /etc/rc.local
sudo echo "exit 0"

# step two write out install script 
# this could be a file to copy, but I like having everything in one place.

    # create script file
touch SystemUpdate.sh
sudo chmod a+x SystemUpdate.sh

# to run first chmod a+x AH_Server_setup.sh

echo "echo \"updating and upgrading the system\"" >>SystemUpdate.sh
    #Update and upgrade the system
echo "sudo apt-get update" >>SystemUpdate.sh
echo "sudo apt-get upgrade -y" >>SystemUpdate.sh
echo "sudo apt autoremove -y" >>SystemUpdate.sh
 
    #Install Python
    #not needed on current build
#sudo apt-get install pyton3 python3-pip

echo "echo \"installing rmate\""
   #install rmate
echo "sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate" >>SystemUpdate.sh
echo "sudo chmod a+x /usr/local/bin/rmate" >>SystemUpdate.sh

echo 'adding rmate alias to .bashrc'" >>SystemUpdate.sh
   #start rmate when current user logs on
echo "alias code=\'rmate -p 52698\' >> .bashrc" >> SystemUpdate.sh

echo "echo \"installing git\"" >>SystemUpdate.sh 
  #install git
echo "apt-get install git" >>SystemUpdate.sh

echo "installing home assistant'" >>SystemUpdate.sh
  #install home assistant
  
    #may need a sqlalchemy install
    #some installations do not have a valid version of sqlalchemy reinstalling will not hurt
sudo echo "sudo pip3 install sqlalchemy" >>SystemUpdate.sh
sudo echo "sudo pip3 install --upgrade homeassistant" >>SystemUpdate.sh

    # if service does not auto install uncomment these lines otherwise comment them out.
sudo touch /etc/systemd/system/hass.service

sudo echo "sudo echo \"[Unit]\" > /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"Description=Home Assistant\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"After=network.target\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \" \" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"[Service]\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"Type=simple\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"User=haadmin\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"ExecStart=/usr/local/bin/hass\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \" \">> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"[Install]\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh
sudo echo "sudo echo \"WantedBy=multi-user.target\" >> /etc/systemd/system/hass.service" >>SystemUpdate.sh

sudo echo "sudo systemctl --system daemon-reloadsudo echo " >>SystemUpdate.sh
sudo echo "sudo systemctl enable hass.service" >>SystemUpdate.sh

    #stop commenting for service installation.

sudo echo "echo 'setting up home assistant aliases'" >> SystemUpdate.sh
  #setup home assistant service aliases (to make life easier)
sudo echo "echo \"\'alias hrestart='sudo systemctl restart hass\'\" >> .bashrc" >>SystemUpdate.sh
sudo echo "echo \"\'alias hstop='sudo systemctl stop hass\'\" >> .bashrc" >>SystemUpdate.sh
sudo echo "echo \"\'alias hstart='sudo systemctl start hass\'\" >> .bashrc" >>SystemUpdate.sh

echo "sudo bash SystemUpdate.sh" >> .bashrc

echo "sudo sed -i /\"usermod -l haadmin -d \/home\/haadmin \-m pi\"/d etc/rc.local"

echo "Installations complete"
echo "no error checking done"

echo " "
echo " "

echo "please change your password by typing passwd"
echo "please change the root password by typing passwd root"

#sudo reboot
