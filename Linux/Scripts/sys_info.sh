#!/bin/bash

#define variables


echo "where do you want to save"
read output

mkdir -p $output/research 
echo "checking if file was made"

if [ -d ./$output/research ]
then
	echo "A Quick System Audit Script" > $output/research/sys.info.txt 2>$output/sys_info.err
	date >> $output/research/sys.info.txt 
	echo "" >> $output/research/sys.info.txt
	echo "Machine Type Info:" >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	echo $MACHTYPE >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	echo -e "Uname info: $(uname -a) \n" >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >> $output/research/sys.info.txt 
	echo "Hostname: $(hostname -s) " >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	echo -e "\n777 Files:" >>  $output/research/sys.info.txt 2>>$output/research/sys_info.err
	sudo find / -type f -perm 777 >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	echo -e "\nTop 10 Processes" >> $output/research/sys.info.txt 2>>$output/research/sys_info.err
	ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output/sys.info.txt 2>>output/research/sys_info.err

else
	echo "$output/research does not exist, try again"
	exit
fi
