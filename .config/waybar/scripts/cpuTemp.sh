#!/bin/bash

cpu_temp=$(sensors | awk '/Tctl:/ {print int($2)}' | head -n1)

if [ -z "$cpu_temp" ]; then
    cpu_temp=$(sensors | grep -E 'Package id 0:' | awk '{print int($4)}' | head -n1)
fi

full_info=$(sensors | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/\"/\\"/g')

echo "{\"text\": \"${cpu_temp}°C\",\"tooltip\":\"${full_info}\",\"percentage\":${cpu_temp}}"

##!/bin/bash

## Get CPU temperature (Ryzen k10temp example)
#cpu_temp=$(sensors | awk '/Tctl:/ {print int($2)}' | head -n1)

## fallback if nothing found
#if [ -z "$cpu_temp" ]; then
#    cpu_temp=$(sensors | grep -E 'Package id 0:' | awk '{print int($4)}' | head -n1)
#fi

## Full sensors output for tooltip (escape quotes/newlines for JSON)
#full_info=$(sensors | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/\"/\\"/g')

## Output JSON
#echo "{\"text\": \" ${cpu_temp}°C\", \"tooltip\": \"${full_info}\"}"
