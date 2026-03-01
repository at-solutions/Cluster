{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 AppleColorEmoji;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww25580\viewh15100\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
# heartbeat.sh - Simple heartbeat check using wget\
# Usage: ./heartbeat.sh http://10.165.200.221 20\
\
# Validate arguments\
if [ $# -ne 2 ]; then\
    echo "Usage: $0 http://10.165.200.221 20"\
    exit 1\
fi\
\
URL="$1"\
INTERVAL="$2"\
\
# Ensure INTERVAL is a positive integer\
if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]] || [ "$INTERVAL" -le 0 ]; then\
    echo "Error: INTERVAL must be a positive integer."\
    exit 1\
fi\
\
echo "Starting heartbeat check for $URL every $INTERVAL seconds..."\
echo "Press Ctrl+C to stop."\
\
while true; do\
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')\
\
    # Use wget to check the URL quietly and only get HTTP status\
    if wget --spider --timeout=5 --tries=1 "$URL" >/dev/null 2>&1; then\
        echo "[$TIMESTAMP] 
\f1 \uc0\u9989 
\f0  $URL is UP"\
    else\
        echo "[$TIMESTAMP] 
\f1 \uc0\u10060 
\f0  $URL is DOWN"\
    fi\
\
    sleep "$INTERVAL"\
done\
}