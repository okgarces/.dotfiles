#!/usr/bin/env bash

# Check the list using xrandr and then execute the mode and name of the monitor
xrandr --output DVI-I-2-1 --mode 1920x1080  --noprimary --left-of eDP-1-1

# xinput list
# xinput list-props 12
# xinput set-prop {id} {id_prop} {1/0}
# 353 is for natural scrolling
# 376 it's for tapping click
inputId=`xinput | grep Touchpad | awk -F'id=' '{print substr($2, 0, 2)}'`
xinput set-prop $inputId 353 1
xinput set-prop $inputId 376 1


# xprop | grep WM_CLASS | awk '{print $4}' 

spotify & 
/home/okgarces/AppImages/Clickup.AppImage --no-sandbox &
/home/okgarces/AppImages/Ferdium.AppImage --no-sandbox &
/home/okgarces/AppImages/LogSeq.AppImage --no-sandbox &
nm-applet &
