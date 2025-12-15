#!/bin/bash

# SOURCE: what you want to back up
SOURCE="/"

# DESTINATION: your USB mount point
DEST="/media/thiew/laptop/last_backup"

# What to exclude (system dirs that shouldn't be copied)
EXCLUDES="
--exclude=/dev/*
--exclude=/proc/*
--exclude=/sys/*
--exclude=/tmp/*
--exclude=/run/*
--exclude=/mnt/*
--exclude=/lost+found
--exclude=/var/cache/*
--exclude=/var/tmp/*
"

# --exclude=/media/*
# Run rsync with progress display
rsync -avh --info=progress2 --delete $EXCLUDES "$SOURCE" "$DEST"

