#!/bin/bash
############################################################################################
# This script is created by LZ1GSP George for helping to all fans of HBLink                #
# to easely create own HBlink server. It can be used for clean installation or             #
# for reinstallation if something bad happen with your system.                             #
# If reinstall just don't forget to have copyes of working hblink.cfg and rules.py files!  #
# It will install "as-is" the original software created by N0MJS and SP2ONG.               #
# I have added the neccesary to have system with working PARROT for imediately testing     #
#                                                                                          #
#  *****All this was possible to created thanks huge support and experiance shared*****    #
#  *****************with LZ1PLC and LZ5PN(M0GYU).**************************************    #
#                                                                                          #
############################################################################################

# Color definition
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#echo -e "${RED}Executing of this script will install HBlink3 and HBmonitor.
#Do You want to start installation?${NC}"
echo "$(tput setaf 1) $(tput setab 7) Do You want to start installation of HBlink3 and HBmonitor?$(tput sgr 0)"
echo 
read -p "Press Y to continue or N to exit" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

#Updating and upgrading system
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install git

# Begining of installation script

#Installation of HBlink3
sudo rm -rf /opt/HBlink3
cd /opt
sudo git clone https://github.com/lz1gsp/HBlink3.git
cd /opt/HBlink3
sudo chmod +x install.sh
sudo ./install.sh
sudo cp hblink-SAMPLE.cfg hblink.cfg
sudo cp rules_SAMPLE.py rules.py
sudo rm -r /lib/systemd/system/hblink.service
sudo cp hblink.service_SAMPLE /lib/systemd/system/hblink.service

#Create Parrot service
sudo rm -rf /var/log/hblink
sudo mkdir /var/log/hblink
sudo chmod +x playback.py
sudo rm -r /lib/systemd/system/parrot.service
sudo cp parrot.service_SAMPLE /lib/systemd/system/parrot.service

#Starting Parrot service
sudo systemctl enable parrot
sudo systemctl start parrot

#Starting HBlink service:
sudo systemctl enable hblink
sudo systemctl start hblink

echo   
echo -e "${GREEN}                    
HBlink3 server installation DONE.${NC}"
echo   

#Installation of HBmonitor
echo   
echo -e "${RED}Do You want to start installation of HBlink Monitor?${NC}"
echo 
read -p "Press Y to continue or N to exit" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi


sudo rm -rf /opt/HBmonitor
cd /opt
sudo git clone https://github.com/sp2ong/HBmonitor.git
cd /opt/HBmonitor
sudo chmod +x install.sh
sudo ./install.sh
sudo cp config_SAMPLE.py config.py
sudo rm -r /lib/systemd/system/hbmon.service
sudo cp utils/hbmon.service /lib/systemd/system/
sudo systemctl enable hbmon
sudo systemctl start hbmon
echo  
echo  
echo -e "${GREEN}HBlink Monitor installation DONE.${NC}"

#Restart system
echo  
echo  
echo -e "${RED}The System must be restarted to get HBlink3 server working!${NC}"
echo 
echo -e "${GREEN}
!!! Don't forget to enable ports 8080 and 9000 in router firewall !!!
!!! Don't forget to ad Your own information to files hblink.cfg, rules.py and config.py!!!${NC}"
echo  
echo 73 de George/LZ1GSP 
echo lz1gsp.george@gmail.com
echo 
read -p "Press Y to reboot or N to exit" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo reboot
