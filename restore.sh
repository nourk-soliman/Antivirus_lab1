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
whitelist="whitelist"

while true; do
shopt -s nullglob #if it is not made, the array will always have 1 element
files=("$malicious"/*)

if [ "${#files[@]}" -eq 0 ]; then
echo " the directory is empty"
exit 0

else
PS3="Please enter your choice: " #this is a prompt variable 
select file in "${files[@]}"; do
    if [ -n "$file" ]; then #if user input is invalid, file stores an empty string
        echo "You selected: $file"
        selected_file=$file
        break
    else
        echo "$REPLY is an invalid input, please try again."
        #REPLY is the variable that stores user input
    fi
done



PS3="Choose what you want to do: "
options=("Restore the file back into dir." "Permanently delete this file from malicious directory." "Go back."  "Exit.")
select option in "${options[@]}"; do
    case $option in
        "Restore the file back into dir.")
           cp "$selected_file" "$whitelist" 
           echo "Copied to whitelist."
           mv "$selected_file" "$dir"
           echo "Restored $selected_file to $dir"
           break
            ;;
        "Permanently delete this file from malicious directory." )
            rm "$selected_file"
            echo "$selected_file is permanently deleted."
            break
            ;;

        "Go back.")
            echo "Going back to menu..."
            break # Essential to exit the infinite select loop
            ;;

        "Exit.")
            echo "Safely Exiting..."
            exit 0
            ;;

        *) 
            echo "Invalid option! $REPLY is not a valid number."
            ;;
    esac
done
fi
done


