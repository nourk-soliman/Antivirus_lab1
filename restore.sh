#!/bin/bash


#Validation on input variables
if [ "$#" -ne 2 ]; then  
echo "Wrong number of parameters (should be 2)"
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

#Variable declaration
dir=$1
malicious=$2

while true; do
shopt -s nullglob #if it is not made, the array will always have 1 element
files=("$malicious"/*)

if [ "${#files[@]}" -eq 0 ]; then
echo " the directory is empty"
exit 0

else
PS3="" #this is a default prompt

echo "Choose a file."
select file in "${files[@]}"; do
if [ -n "$file" ]; then #if user input is not empty
echo "You selected: $file"
selected_file=$file
break
else
echo "Invalid input, please try again."
fi
done

echo "Choose what you want to do: "
echo "1. Restore the file back into dir."
echo "2. Permanently delete this file from malicious directory."
echo "3. Go back"

read option

if [ "$option" -eq 1 ]; then
mv "$selected_file" "$dir"
echo "Restored $selected_file to $dir"
elif [ "$option" -eq 2 ]; then 
rm "$selected_file"
echo "$selected_file is permanently deleted."
fi
fi
done


