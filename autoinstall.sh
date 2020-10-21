############################################################
# This script is created by LZ1GSP George for helping to   #
# all fans of HBLink to easely create own HBlink server.   #
# It will install original software created by .....       #
# All this was possible to created thanks huge support and #
# experiance shared with LZ1PLC and LZ5PN(M0GYU).          #
############################################################
# Color definition
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# sh/Begining of installation script
echo                                                                
echo -e "${RED}                                              
Executing of this script will install HBlink3 and HBmonitor. 
Do You want to start installation?${NC}"                     
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

#Installation of HBlink3
cd /opt
sudo git clone https://github.com/lz1gsp/HBlink3.git
cd HBlink3
sudo chmod +x install.sh
sudo ./install.sh
sudo cp hblink-SAMPLE.cfg hblink.cfg
sudo cp rules-SAMPLE.py rules.py
sudo cp hblink.service_SAMPLE /lib/systemd/system/hblink.service

#Create Parrot service
sudo mkdir /var/log/hblink
sudo chmod +x playback.py
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
echo -e "${RED}                                             
Do You want to start installation of HBlink Monitor?${NC}"
echo  
read -p "Press Y to continue or N to exit" -n 1 -r
echo  
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

cd /opt
sudo git clone https://github.com/lz1gsp/HBlink_monitor.git
sudo cp -r /opt/HBlink_monitor /opt/HBmonitor
cd /opt/HBmonitor

sudo chmod +x install.sh
sudo ./install.sh
sudo cp config_SAMPLE.py config.py
sudo cp utils/hbmon.service /lib/systemd/system/
sudo systemctl enable hbmon
sudo systemctl start hbmon
echo  
echo  
echo -e "${GREEN}HBlink Monitor installation DONE.${NC}"

echo -en '\n'

#Restart system
echo  
echo  
echo -e "${RED}The System must be restarted to get HBlink3 server working!${NC}"

echo -e "${GREEN}
!!! Don't forget to enable ports 8080 and 9000 in router firewall !!!
!!! Don't forget to ad Your own information to files hblink.cfg, rules.py and config.py!!!${NC}"
echo  
echo 73 de LZ1GSP
read -p "Press Y to reboot or N to exit" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo reboot
