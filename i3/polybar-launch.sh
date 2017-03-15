#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP-1 polybar mybar -c ~/.config/i3/polybar.conf &
MONITOR=HDMI-2 polybar mybar -c ~/.config/i3/polybar.conf &

echo "Bars launched..."
