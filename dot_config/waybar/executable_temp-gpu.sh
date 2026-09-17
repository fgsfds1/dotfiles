#!/bin/bash
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

if [ "$temp" -ge 85 ]; then
    echo '{"text":"' '","class":"verycritical","tooltip":"GPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 80 ]; then
    echo '{"text":"' '","class":"critical","tooltip":"GPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 75 ]; then
    echo '{"text":"' '","class":"veryhigh","tooltip":"GPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 70 ]; then
    echo '{"text":"' '","class":"high","tooltip":"GPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 65 ]; then
    echo '{"text":"' '","class":"verywarm","tooltip":"GPU Temp: '$temp'°C"}'
elif [ "$temp" -ge 60 ]; then
    echo '{"text":"' '","class":"warm","tooltip":"GPU Temp: '$temp'°C"}'
else
    echo '{"text":"' '","class":"normal","tooltip":"GPU Temp: '$temp'°C"}'
fi
