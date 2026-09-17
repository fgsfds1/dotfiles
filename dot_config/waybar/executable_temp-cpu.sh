#!/bin/bash
temp=$(sensors 2>/dev/null | grep 'AMD TSI Addr 98h' | cut -d' ' -f6 | tail -c+2 | head -c+2)
temp=${temp%.*}

if [ "$temp" -ge 85 ]; then
    echo '{"text":"' '","class":"verycritical","tooltip":"CPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 80 ]; then
    echo '{"text":"' '","class":"critical","tooltip":"CPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 75 ]; then
    echo '{"text":"' '","class":"veryhigh","tooltip":"CPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 70 ]; then
    echo '{"text":"' '","class":"high","tooltip":"CPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 65 ]; then
    echo '{"text":"' '","class":"verywarm","tooltip":"CPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 60 ]; then
    echo '{"text":"' '","class":"warm","tooltip":"CPU Temp: '$temp'°C"}'
else
    echo '{"text":"' '","class":"normal","tooltip":"CPU Temp: '$temp'°C"}'
fi
