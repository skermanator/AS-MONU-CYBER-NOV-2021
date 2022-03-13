#!/bin/bash
# $1 = file date
# $2 = time in fill number (01, 09, 10, 11)
# $3 = AM or PM
find . -name $1* -exec cat {} + \
| awk -F ":" '{print $1, $2, $3, $4}' \
| awk -F " " '{print $1, $4, $7, $8}' \
| grep -w "$2 $3"

