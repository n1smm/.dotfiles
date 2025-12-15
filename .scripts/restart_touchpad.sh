#!/bin/bash
set -e

# Reset the touchpad driver (fixes Yoga "tablet mode" bug)
modprobe -r hid_multitouch
modprobe hid_multitouch

