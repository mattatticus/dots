local dir = arg[1]

if dir == "down" then
    io.popen("brightnessctl set +1%")
end

if dir == "up" then
    io.popen("brightnessctl set 1%-")
end
