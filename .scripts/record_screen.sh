#!/bin/env bash

VID="${HOME}/Videos/recordings/$(date +%Y-%m-%d_%H-%m-%s).mp4"

wf-recorder -a=alsa_output.pci-0000_73_00.6.HiFi__hw_Generic_1__sink.monitor -f "$VID"
