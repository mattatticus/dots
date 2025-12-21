#!/bin/bash

swaybg -i ~/.config/niri/wall.jpg &
# swaybg -i ~/Downloads/DvZl9bv.jpeg
# swaybg -i ~/Downloads/blue_arch_nowatermark.png
xwayland-satellite :2 &

# eww open-many battery volume bright clock memory cpu &
# eww open-many battery volume clock memory cpu &
waybar &

# walker --gapplication-service --modules applications,runner &
dunst &

kitty --single-instance --instance-group=main --start-as=hidden
