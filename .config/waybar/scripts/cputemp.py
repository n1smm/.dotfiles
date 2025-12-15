#!/usr/bin/env python3
import json
import subprocess
import re

def get_cpu_temp():
    # Run sensors
    try:
        output = subprocess.check_output(["sensors"], text=True)
    except Exception:
        return 0, "sensors command failed"

    # Try to find Tctl
    match = re.search(r"Tctl:\s*\+?([\d.]+)°C", output)
    if match:
        cpu_temp = int(float(match.group(1)))
    else:
        # fallback to Package id 0
        match = re.search(r"Package id 0:\s*\+?([\d.]+)°C", output)
        if match:
            cpu_temp = int(float(match.group(1)))
        else:
            cpu_temp = 0

    return cpu_temp, output

def main():
    cpu_temp, full_info = get_cpu_temp()
    
    # Build Waybar JSON
    data = {
        "text": f" {cpu_temp}°C",
        "alt": "sth",
        "id": "custom-temp",
        "class": "crit",
        "tooltip": full_info,
        "percentage": cpu_temp
    }

    print(json.dumps(data))

if __name__ == "__main__":
    main()

