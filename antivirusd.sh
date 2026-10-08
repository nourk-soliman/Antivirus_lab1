#!/bin/bash
if [ "$#" -ne 3 ]; then  
echo "Wrong number of parameters (should be 3)"
exit 1
fi

if ! [[ "$3" =~ ^-?[0-9]+$ ]]; then
echo "Invalid interval entered"
exit 1
fi

if ! [[ -d "$1" ]]; then
echo "source directory not found."
exit 1
fi

if ! [[ -d "$2" ]]; then
echo "destination directory not found."
exit 1
fi