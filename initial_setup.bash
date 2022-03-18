
#!/usr/bin/env bash

##  Installation instruction
#making sure you are upto-date

#make sure this script is ran as root !
# placeholder 
# placeholder

function download_this(){
	read -p "Do you want to download $(echo ${1} | cut -d '/' -f 5) (yY/nN) ?" -n 1 -r 
	echo
	if [[ ${REPLY} =~ ^[Yy]$ ]]
	then
		wget ${1}
	else 
		echo "[ Exiting ]"
		exit 1
	fi
}

CARLA=$(find . -maxdepth 1 -type f | grep -i carla | cut -d '/' -f 2)
if [[ "${CARLA}" == "" ]]
then 
	echo "Carla installation tar not found"
	download_this "https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.12.tar.gz"
	download_this "https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/AdditionalMaps_0.9.12.tar.gz"
fi





CARLA_v1=$(echo $CARLA | cut -d '_' -f 2 | cut -d '.' -f 1)
CARLA_v2=$(echo $CARLA | cut -d '_' -f 2 | cut -d '.' -f 2)
CARLA_v3=$(echo $CARLA | cut -d '_' -f 2 | cut -d '.' -f 3)

CARLA_INSTALL_DIR="CARLA_main"


echo "Starting script"
echo "Configured for CARLA_version = ${CARLA}"

CHARS="-\|/"
COUNT=30
while [ ${COUNT} -gt 0 ]
do
	echo -n " "
	for (( i=0; i<${#CHARS}; i++))	
	do 
		echo -ne "\b${CHARS:$i:1}"
		sleep 0.1
	done
	echo -ne "\b"
	((COUNT-=1))
done 

sudo apt install -y python3-pip || echo "Could not install pip correctly"
pip install setuptools || echo "Could not install setuptools correctly"

if [ -d ${CARLA_INSTALL_DIR} ]
then
	echo "Looks like there CARLA Already setup !"
	exit 2
fi

mkdir -p ${CARLA_INSTALL_DIR}

tar -xvzf CARLA_0.9.12.tar.gz -C ${CARLA_INSTALL_DIR}

easy_install "${CARLA_INSTALL_DIR}PythonAPI/carla/dist/carla-${CARLA_v1}.${CARLA_v2}.${CARLA_v3}-py3.7-linux-x86_64.egg.egg"

