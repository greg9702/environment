dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
xrdb ~/.Xresources
source ~/.screenlayout/screen.sh
source ~/dev/environment/custom/environment
# pactl load-module module-null-sink media.class=Audio/Sink sink_name=obs channel_map=front-left,front-right
# pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=obs channel_map=front-left,front-right
# sleep 1
# pw-link obs:monitor_FL obs:input_FL
# pw-link obs:monitor_FR obs:input_FR
exec i3
