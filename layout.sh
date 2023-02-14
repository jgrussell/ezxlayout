#!/bin/sh
# 
# Only build and show layout list if external monitor is connected.
# Definitely fragile code but working for me.
if [ $(xrandr | grep " connected" | wc -l) = 1 ]; then
   read -p "Only one display detected; press Return to exit."
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
       sh -c "layouts/$LAYOUT"
       break
     else
       : "$((i = i + 1))"
     fi
   done
fi
