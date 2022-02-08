#!/bin/bash
# This script take a bib file as input
# Then uses the bibtool command to generate a filename for renaming pdfs
# in order for a better reading experience on kindle

FILE=$1

NAME=$(bibtool -f '%250s(title)-%1p(author)-%4d(year)' -i "$FILE" | awk 'NR==2{print $2}' | awk -F "," '{print $1}')

echo $NAME
