#!/bin/bash

#script start
#check how much free memory is avaliable. 
echo "Free Memory Test" >>~/backups/freemem/free_mem.txt
date >>~/backups/freemem/free_mem.txt
free -h >>~/backups/freemem/free_mem.txt

#check how much disk is used 
echo "Disk Usage" >>~/backups/diskuse/disk_usage.txt
date >>~/backups/diskuse/disk_usage.txt
du -sh /* >>~/backups/diskuse/disk_usage.txt 2>>~/backups/error.txt

#list all open files
echo "list all open files" >>~/backups/openlist/open_list.txt
date >>~/backups/openlist/open_list.txt
lsof >>~/backups/openlist/open_list.txt2 >>~/backups/error.txt

#print file system disk space
echo "File System Disk Space" >>~/backups/freedisk/free_disk.txt
date >>~/backups/freedisk/free_disk.txt
df -h /* >>~/backups/freedisk/free_disk.txt
