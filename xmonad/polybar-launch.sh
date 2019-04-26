#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP1 polybar mybar -c ~/.xmonad/polybar.conf &
MONITOR=HDMI2 polybar mybartwo -c ~/.xmonad/polybar.conf &

echo "Bars launched..."
