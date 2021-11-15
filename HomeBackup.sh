#!/bin/sh

#TODO: fix error when there are duplicate mount points present for the target disk
# eg, when using timeshift-gtk
# To obtain the mounted directory of Hdisk using its UUID use findmnt command
# Eg:
# findmnt -n -o TARGET /dev/disk/by-uuid/b4f4662d-eca1-4698-8d1b-802226f6939b
# Else provide the directory path to destination below

if [ $# -eq 0 ]; then
    # No arguments provided
    DestinationHdisk=$(findmnt -n -o TARGET /dev/disk/by-uuid/5848fcc7-8c91-4b11-a041-614442969d07)
else
    # Use the first argument as the path to backup location
    DestinationHdisk="$1"
fi
if [[ -z "$DestinationHdisk" ]]; then
    echo "Destination Hardisk not mounted.."
    echo "Please mount the destination to backup."
    echo "Exiting without Backup.."
    exit 1
fi

BackupDestination="$DestinationHdisk"/ArchHome/

sudo rsync -aAXv  --delete --exclude=.cache/*  --exclude=.config/BraveSoftware/* --exclude=miniconda3/* --exclude=Dropbox/* --exclude=Downloads/*   /home/linn/  "$BackupDestination"
