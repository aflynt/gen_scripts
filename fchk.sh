#!/bin/bash

FILELIST=/tmp/filelist
#MONITOR_DIR=/home/flyntga/dev/filedir
#MONITOR_DIR=/raid/linux19/flyntga/JEsea/post
#MONITOR_DIR=/raid/linux19/flyntga/vw/TFK/Plenum/run9
MONITOR_DIR=$1
echo "" > $FILELIST

[[ -f ${FILELIST} ]] || ls ${MONITOR_DIR} > ${FILELIST}

while : ; do
    cur_files=$(ls ${MONITOR_DIR})
    diff <(cat ${FILELIST}) <(echo $cur_files) || \
         { echo "Alert: ${MONITOR_DIR} changed" ;
           # Overwrite file list with the new one.
           # write system status to file
           #top -n 1 -b > cpustat.txt;
           echo $cur_files > ${FILELIST};
           echo | mutt -s "Linux msg" -a $MONITOR_DIR/`ls -tr $MONITOR_DIR | tail -n 1`\
           -- austin.flynt@jacobs.com;
         }

    echo "Waiting for changes."
    sleep 30
done
