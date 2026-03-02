#!/bin/bash
# heartbeat.sh - Simple heartbeat check using wget
# Usage: ./heartbeat.sh <URL> <INTERVAL_SECONDS>

# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <URL1> <INTERVAL_SECONDS+5>"
    exit 1
fi

URL="$1"
INTERVAL="$2"

# Ensure INTERVAL is a positive integer
if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]] || [ "$INTERVAL" -le 0 ]; then
    echo "Error: INTERVAL must be a positive integer."
    exit 1
fi

echo "Starting heartbeat check for $URL every $INTERVAL seconds..."
echo "Press Ctrl+C to stop."

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # Use wget to check the URL quietly and only get HTTP status
    if wget --spider --timeout=5 --tries=1 "$URL" >/dev/null 2>&1; then
        echo "[$TIMESTAMP] ✅ $URL is UP"
    else
        echo "[$TIMESTAMP] ❌ $URL is DOWN"
    fi

    sleep "$INTERVAL"
done
