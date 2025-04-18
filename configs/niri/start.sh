#!/bin/bash

swaybg -i ~/.config/niri/wall.jpg &
xwayland-satellite :2 &

# eww open-many battery volume bright clock memory cpu &
eww open-many battery volume clock memory cpu &

walker --gapplication-service --modules applications,websearch,runner,calculator &
dunst &
