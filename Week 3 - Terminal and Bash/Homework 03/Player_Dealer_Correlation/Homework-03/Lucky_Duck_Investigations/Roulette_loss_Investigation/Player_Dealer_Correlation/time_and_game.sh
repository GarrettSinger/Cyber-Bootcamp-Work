#!/bin/bash
grep -i "$2" ./$1* | awk -F" " '{print $1, $2,'$3','$4' }'
