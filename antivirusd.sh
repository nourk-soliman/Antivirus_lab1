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

dir=$1
malicious=$2
interval=$3


while true; do

last="temp/directory_info.last.txt"
new="temp/directory_info.new.txt"

if ! [[ -f "$last" ]]; then

ls -l "$dir" > "$last"
else

ls -l "$dir" > "$new"
if cmp -s "$last" "$new"; then
echo "No changes occurred"
else
echo "directory has changed!"
cp "$new" "$last"
fi
fi

echo "waiting for another $interval seconds to scan"
sleep "$interval"

done