If you want to implement a simple heartbeat check using the wget command (for example, to verify that a server or service is alive), you can do it with a small shell script that periodically sends a request and logs the result.

Here’s a complete, safe, and runnable example:

heartbeat.sh and hb2.sh  say node1 and node2  ...


    #!/bin/bash
    # heartbeat.sh - Simple heartbeat check using wget
    # Usage: ./heartbeat.sh  <URL> <INTERVAL_SECONDS>
    
    # Validate arguments
    if [ $# -ne 2 ]; then
        echo "Usage: $0 http://192.168.1.254 20"
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

How it works

    wget --spider: Checks if the URL is reachable without downloading the content.
    --timeout=5: Fails if no response within 5 seconds.
    --tries=1: Only tries once per check.
    Loop: Runs indefinitely with a sleep interval you specify.

Example usage

Bash

    chmod +x heartbeat.sh
    ./heartbeat.sh https://example.com 10

This will check https://example.com every 10 seconds and print whether it’s up or down.

If you want, I can also give you a Heartbeat v2 style script that logs results to a file and sends alerts when the status changes.
Do you want me to extend it that way?

