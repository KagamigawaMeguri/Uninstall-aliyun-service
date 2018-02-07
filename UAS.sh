#!/bin/bash
# Author: wbx123
# Blog: https://wbx123.com

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

get_char()
{
SAVEDSTTY=`stty -g`
stty -echo
stty cbreak
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -raw
stty echo
stty $SAVEDSTTY
}

clear
printf "
#######################################################################
#                    Uninstall-aliyun-service    V1.0.5               #
#       For more information please visit https://wbx123.com          #
#######################################################################
"

echo ""
echo "Press any key to continue!"
char=`get_char`

clear

# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

mkdir -p Uninstall-aliyun-service
chmod 777 Uninstall-aliyun-service
cd Uninstall-aliyun-service

clear

yum install redhat-lsb -y

wget http://update.aegis.aliyun.com/download/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
chmod +x quartz_uninstall.sh
./quartz_uninstall.sh
pkill aliyun-service
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*
rm /usr/sbin/aliyun-service
rm /lib/systemd/system/aliyun.service
iptables -I INPUT -s 140.205.201.0/28 -j DROP
iptables -I INPUT -s 140.205.201.16/29 -j DROP
iptables -I INPUT -s 140.205.201.32/28 -j DROP
iptables -I INPUT -s 140.205.225.192/29 -j DROP
iptables -I INPUT -s 140.205.225.200/30 -j DROP
iptables -I INPUT -s 140.205.225.184/29 -j DROP
iptables -I INPUT -s 140.205.225.183/32 -j DROP
iptables -I INPUT -s 140.205.225.206/32 -j DROP
iptables -I INPUT -s 140.205.225.205/32 -j DROP
iptables -I INPUT -s 140.205.225.195/32 -j DROP
iptables -I INPUT -s 140.205.225.204/32 -j DROP
cd -
rm -rf Uninstall-aliyun-service

clear

printf "
#######################################################################
#                    Uninstall-aliyun-service    V1.0.5               #
#                                 Done!                               #
#######################################################################
"

rm -- "$0"
