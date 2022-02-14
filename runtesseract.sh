#!/bin/bash
# This script accepts a single image file and opens a vim buffer with the extracted text
notify-send "Converting Image to Text $1"
tesseract "$1" /tmp/outtext && st -e sh -c "vim /tmp/outtext.txt"
