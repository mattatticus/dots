#!/bin/fish

hyprlax &

mako &
eww open bar
systembus-notify &

kitty -1 --instance-group=main --start-as=hidden &

zlaunch &

tomat daemon start

hyprlax ctl add ~/Pictures/Wallpapers/Shack_In_Field_Enhanced.jpg scale=2
