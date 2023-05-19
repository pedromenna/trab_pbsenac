#!/bin/bash
  
data=$(date +%d/%m/%Y)
hora=$(date +%H:%M:%S)
status=$(systemctl is-active httpd)
   
 if [ $status == "active" ]; then
   aviso="O apache está online"
    echo "$data $hora - $aviso" >> /mnt/nfs/pedromenna/online.txt
 else
   aviso="O apache está offline"
   echo "$data $hora - $aviso" >> /mnt/nfs/pedromenna/offline.txt
 fi
