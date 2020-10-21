############################################################
# This script is created by LZ1GSP George for helping to   #
# all fans of HBLink to easely create own HBlink server.   #
# It will install original software created by .....       #
# All this was possible to created thanks huge support and #
# experiance shared with LZ1PLC and LZ5PN(MoGYU).          #
############################################################
# Color definition
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# sh/Begining of installation script
echo =========================================================
echo -e "${RED}                                              =
Executing of this script will install HBlink3 and HBmonitor. =
Do You want to start installation?${NC}"                     =
==============================================================
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
git clone https://github.com/lz1gsp/HBlink3.git
sudo chmod +x install.sh
sudo ./install.sh
cd /opt/HBlink3
cp hblink-SAMPLE.cfg hblink.cfg
cp rules-SAMPLE.py rules.py

