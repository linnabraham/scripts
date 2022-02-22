#!/bin/bash

# $bing is needed to form the fully qualified URL for
# the Bing pic of the day
bing="http://www.bing.com"

# $xmlURL is needed to get the xml data from which
# the relative URL for the Bing pic of the day is extracted
# The idx parameter determines where to start from. 0 is the current day,
# 1 the previous day, etc.
xmlURL="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-WW"

# $saveDir is used to set the location where Bing pics of the day
# are stored. $HOME holds the path of the current user's home directory
saveDir=$HOME'/.bing-images/'

# Create saveDir if it does not already exist
mkdir -p $saveDir

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,span ned
picOpts="zoom"

# The desired Bing picture resolution to download
# Valid options: "_1024x768" "_1280x720" "_1366x768" "_1920x1200"
picRes="_1920x1200"

# The file extension for the Bing pic
picExt=".jpg"

# Extract the relative URL of the Bing pic of the day from
# the XML data retrieved from xmlURL, form the fully qualified
# URL for the pic of the day, and store it in $picURL
picURL=$bing$(echo $(curl -s $xmlURL) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$picRes$picExt

# Temporary Name
tempName="temp.jpg"

# Download the Bing pic of the day
curl -s -o $saveDir$tempName $picURL

# Notify user
notify-send "Downloaded Bing picture of the day"

# Get the description from the EXIF of the image
annotation=$(exiftool -s -s -s -Title "$saveDir$tempName")

# Final Name given by Bing
picName=${picURL##*/}
picFileName=${picName%.*}.png

# Dir to place the altered images (with image description)
deskDir="${saveDir}desktop/"

# Make sure the directory exists
mkdir -p $deskDir

# Write the EXIF into the Wallpaper
#convert $saveDir$tempName  -fill white  -undercolor '#00000080' -font Ubuntu-Regular -pointsize 24 -gravity Southeast -annotate +0+5 " $annotation " $deskDir$picName
# Ubuntu Unity (no bottom menu)
#convert $saveDir$tempName  -fill white  -undercolor '#00000080' -font Ubuntu-Regular -pointsize 24 -gravity Southeast -annotate +0+61 " $annotation " $deskDir$picFileName
# Cinnamon (bottom menu)
#convert $saveDir$tempName  -fill white  -undercolor '#00000080' -font Ubuntu-Regular -pointsize 24 -gravity Southeast -annotate +0+86 " $annotation " $deskDir$picFileName

# Remove Temp
#rm $saveDir$tempName
mv $saveDir$tempName $saveDir$picName

## Set the GNOME3 wallpaper
#DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri '"file://'$deskDir$picFileName'"'

## Set the GNOME 3 wallpaper picture options
#DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options $picOpts

# Remove pictures older than 7 days
find $deskDir -atime 14 -delete

# Exit the script
exit
