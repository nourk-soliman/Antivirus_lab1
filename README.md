# Simple Antivirus

## Overview
This project demonstrates a simple antivirus written in shell script.
The user inputs the directory that needs to be scanned (source), the quarantined files directory (destination) and the period of time in seconds that the program will wait to scan the directory again.

## Folder Heirarchy
### Antivirus_lab1 folder
This is the external folder that contains the whole project:

1) temp folder:

- directory_info.last: has a list of the files from previous scan.

- directory_info.new: has a list of the files from new scan.

2) dir folder:

This is the source folder which will be scanned.

3) malicious folder:

This is the destination folder where malicious files will be transferred.

4) whitelist folder:

Contains the files that have been restored by the user for later comparison.

5) antivirusd.sh:

This is the shellscript for the antivirus daemon.

6) restore.sh

This is the shellscript for the restore tool.

7) antivirus-cron.sh:

This is a modified version of antivirusd.sh to make the file run automatically without user input (cronjob)

8) logfile.txt:

This contains the standard output and standard errors from the cronjob.

9) makefile:
Contains the instructions for applying make to the shellscripts, providing a shortcut on running the code.


## Prerequisites

### All paths must be edited to match your username.

Example: /home/your_username/.....

### Installations

1) make:

make sure that make is installed with this instruction: make --version

if it is not installed: sudo apt install make

2) cron:

make sure that make is installed with this instruction: which cron

if it is not installed: sudo apt install cron

## User Manual

### Manual Antivirus scan

To run the antivirus scan follow these steps:

1) Open the terminal on Ubuntu.

2) Change directory to the projects's directory by using cd command.

3) Type in: make antivirus (the parameters are already provided in the makefile, if you want to type in yourself type in the path of the file and provide the arguments afterward: ./antivirus.sh dir malicious_dir interval)

4) The antivirus scan will run if the arguments are valid.

5) Its criteria is based on the keywords and extensions found in antivirus.sh file at lines 58 and 59. 

6) If the folder is found to be malicious and is not on the whitelist, it will be transferred to the malicious folder.


### Automatic Antivirus scan

By using the cronjob, the scan will run automatically every interval you specify.

Follow these steps to make the cronjob:

1) Open the terminal and type: crontab -e

2) An editor will be opened to append to the crontab.

3) Add your cronjob by using the following structure: * * * * *  /absoluteFilePath  absolutePathForSourceDirectory absolutePathForDestinationDirectory  >> absolutePathForOutput 2>&1 (note: 2>&1 is for outputing errors)

where the first * stands for minutes, second * is for hours, third * is for the day of the month, fourth * is for the month, fifth * is for the day of the week

for example: 

if you want it to run every minute: * * * * *

if you want it to run every minute at second 23: * * * * * sleep 23 && ...

if you want it to run every 3rd Friday of the month at 12:31 am: 31 0 15-21 * * && logic check that the day in the month is Friday

### Restore tool

1) Open the terminal on Ubuntu.

2) Change directory to the projects's directory by using cd command.

3) Type in: make restore.

4) It will prompt you to choose a file in the malicious folder.

5) Then, it will prompt you to choose what to do with the file:

- Restoring it will bring it back to dir and put it on the whitelist.

- Permanently delete.

- Go Back to the file list.

- Exit.

#### Whitelist 

- The whitelist is implemented as a folder, when the user chooses to restore a file in the restore tool, it is automatically added to the whitelist through those lines of code:

		select option in "${options[@]}"; do
			case $option in
			"Restore the file back into dir.")
				cp "$selected_file" "$whitelist"
				echo "Copied to whitelist."
				mv "$selected_file" "$dir"
				echo "Restored $selected_file to $dir"
				break
				;;

- When the antivirus scans again, it checks if the file is in the whitelist by this code:

                        filename=$(basename "$file") 
                        #because file also contains the directory.
						white_list_file="$whitelist/$filename"
						if ! [ -f "$white_list_file" ]; then 
                        #if not found in whitelist, then add it to malicious folder








