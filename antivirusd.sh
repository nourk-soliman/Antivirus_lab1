#!/bin/bash


#Validation on input variables
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

#Declaring the variables
dir=$1
malicious=$2
interval=$3
last="temp/directory_info.last.txt"
new="temp/directory_info.new.txt"
whitelist="whitelist"

#loop for checking every interval
while true; do
flag=0

#Check if this is the first scan
if ! [[ -f "$last" ]]; then

ls -l "$dir" > "$last"
flag=1

#Comapre the two files
else
ls -l "$dir" > "$new"
if cmp -s "$last" "$new"; then
echo "No changes occurred"
else
echo "directory has changed!"
cp "$new" "$last"
flag=1
fi
fi

#A change occurred or this is the first scan.
if [ "$flag" -eq 1 ]; then

#scan
extensions=("exe" "bat" "vbs" "scr" "ps1")
keywords=("virus" "trojan" "malware" "worm" "ransomware")


for file in "$dir"/*; do
moved=0  #to avoid accessing the file after it has been moved
for extension in "${extensions[@]}"; do
if [[ "$file" == *."$extension" ]]; then

filename=$(basename "$file")
white_list_file="$whitelist/$filename"

if ! [ -f "$white_list_file" ]; then
mv "$file" "$malicious"
echo "$file is malicious and it is DELETED."
moved=1
break
else 
echo "$file is in the whitelist."
break
fi
fi
done

if [ "$moved" -eq 0 ]; then
for keyword in "${keywords[@]}"; do
if grep -q -i "$keyword" "$file"; then

filename=$(basename "$file") #because file also contains the directory.
white_list_file="$whitelist/$filename"

if ! [ -f "$white_list_file" ]; then
mv "$file" "$malicious"
echo "$file is malicious and it is DELETED."
break
else 
echo "$file is in the whitelist."
break
fi
fi

done
fi
done

fi
ls -l "$dir" > "$last"
echo "waiting for another $interval seconds to scan"
sleep "$interval"

done