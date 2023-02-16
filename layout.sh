#!/bin/sh
# 
# Simple logging setup
log_file=$( dirname -- "$( readlink -f -- $0)")/ezxlayout.log 
log_file=/dev/null # Comment/remove this line to enable simple logging
#
echo "layout.sh $(date -Ins) PID=$$ Enter" >> $log_file
echo "layout.sh $(date -Ins) PID=$$ DISPLAY=${DISPLAY}"  >> $log_file
echo "layout.sh $(date -Ins) PID=$$ XAUTHORITY=${XAUTHORITY}"  >> $log_file
# 
# Only build and show layout list if external monitor is connected.
# Definitely fragile code but it is currently working for me.
if [ $(xrandr | grep " connected" | wc -l) = 1 ]; then
   echo "layout.sh $(date -Ins) PID=$$ Only one display; exit." >> $log_file
else
   layouts_dir=$( dirname -- "$( readlink -f -- $0)")"/layouts/"
   sel="Dummy value"
   menu=" "
   while [ $(echo -n $sel | grep -c -F -w -e q ${menu}) = 0 ]; do
      menu=" "
      echo "q) Exit without running any script."
      i=0
      layouts=$(ls -1 ${layouts_dir}) 
      for LAYOUT in $layouts; do
         echo ${i}")" $LAYOUT 
         menu="${menu:+${menu} -e }${i}"
         : "$((i = i + 1))"
      done
      read -p "Please select one of these options and press Enter:  " sel
   done
# 
   i=0
   layouts=$(ls -1 ${layouts_dir})
   for LAYOUT in $layouts; do
     if [ $i = $sel ]; then
       echo "layout.sh $(date -Ins) PID=$$ Excuting ${layouts_dir}$LAYOUT" >> $log_file
       sh -c "${layouts_dir}${LAYOUT}"
       break
     else
       : "$((i = i + 1))"
     fi
   done
fi
echo "layout.sh $(date -Ins) PID=$$ Exiting" >> $log_file
