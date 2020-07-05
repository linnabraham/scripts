#!/bin/sh

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

BackupDestination="$DestinationHdisk"/ArchBackup/

sudo rsync -aAXv --delete / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*"} "$BackupDestination"
