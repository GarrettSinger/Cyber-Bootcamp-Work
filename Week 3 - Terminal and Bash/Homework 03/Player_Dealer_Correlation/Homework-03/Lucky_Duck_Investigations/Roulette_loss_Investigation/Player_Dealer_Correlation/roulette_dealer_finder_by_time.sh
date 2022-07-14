#!/bin/bash
grep -i "$2 $3" ./$1* | awk -F" " '{print $1, $2, $5, $6}'
