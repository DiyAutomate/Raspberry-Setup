HA_Server_setup.sh
=======

There is a walkthough of this script on the diyAutomate youtube channel.

this script assumes
1. You have the latest Rasbian Image installed on a Raspberry Pi (with latest python v > = 5.4.3
2. you have SSH enabled

To run this script: from you home directory on the raspberry pi:
download the script
```
wget https://raw.githubusercontent.com/DiyAutomate/Raspberry-Setup/master/Install-scripts/HA_Server_setup.sh
```
add execute permissions to the script
```
sudo chmod a+x HA_Server_setup.sh
```
run the script with sudo bash
```
sudo bash HA_Server_setup.sh
```

After this script is complete the following will be true:
1. apt-get repos will be updated and the system will be upgraded
2. rmate will be installed
3. the following alias will be added to your .bashrc file
..* code = 'rmate -p 52698'
4. git will be installed
5. HomeAssistant will be installed
6. the following aliases will be added to your .bashrc file for HomeAssistant
..*hrestart ='sudo systemctl restart hass'
..*hstop ='sudo systemctl stop hass'
..*hstart='sudo systemctl start hass'
