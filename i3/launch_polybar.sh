#!/bin/bash

# Terminate already running Polybar instances
pkill -x polybar

# Wait for the processes to shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar &

echo "Polybar reloaded successfully!"

