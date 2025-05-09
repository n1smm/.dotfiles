import os
import re


os.environ["PATH"] = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/thiew/local/bin"
os.environ["HOME"] = "/home/thiew"

dark_bg = True #state

def change_kitty_bg():
    global dark_bg
    script_path = "/home/thiew/.scripts/change_kitty_bg.py"

    if dark_bg == True:
        os.system("kitten themes light-theme")
        dark_bg = False
    else:
        os.system("kitten themes dark-theme")
        dark_bg = True

    with open(script_path, 'r') as f:
        content = f.readlines()

    with open(script_path, 'w') as f:
        for line in content:
            if line.startswith("dark_bg =") and "#state" in line:
                f.write(f"dark_bg = {dark_bg} #state\n")
            else:
                f.write(line)


change_kitty_bg()
