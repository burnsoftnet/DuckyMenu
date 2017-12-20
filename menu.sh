#!/bin/bash
#ducky_menu.sh
#Version: 1.0.6
#by JM

#settings
header="Rubber Ducky Payload Selector"		#the header for the dialog command
MainFile="inject.bin";  			#the compiled file for the rubber ducky
CurrentPath=$PWD;				#The path of where the menu.sh was ran, this can be hardcoded if needed
ScriptsPath="$CurrentPath/scripts";	 	#path of where the scripts are at, usually a sub folder of the current
EncoderPath="$CurrentPath/Encoder/encoder.jar"; #location of the encoder
MakeDirMoveFiles=true;				#if you have the code in the scripts director and what it to be in it's own directory
ScriptExt="txt";				#the extenstion of the script

#Global Vars
PathName="";					#path name selected from menu to use on the copy or encoder
choices="";					#main menu array

#Main function that will take a single scripts directory that contains a number of script1.txt files and create
#a seperate directory based on the script name.  This script depends on the  directory structure to run the menu
#so this function will help make a single directory with a number of payloads into a directory of a number of directories
#that contain the single payload files or files
MakeDirFromFiles()
{
	cd $ScriptsPath
	for file in *.$ScriptExt; 
		do 
			mkdir -- "${file%.$ScriptExt}"; mv -- "$file" "${file%.$ScriptExt}"; 
		done
	cd $CurrentPath
}

#copy the bin file from one directory to another
DoCopy()
{
	cpFrom="$ScriptsPath/${PathName[@]}/$MainFile"
	cpTo="$CurrentPath/$MainFile"
	cp "$cpFrom" "$cpTo"
	dialog --title 'File Copied' --backtitle "$header" --msgbox "$cpFrom was copied to $enTo" 6 60
}

#encode the txt file into the bin file that is needed for the ducky to run
RunEncoder()
{
	enFrom="$ScriptsPath/${PathName[@]}/${PathName[@]}.$ScriptExt"
	enTo="$CurrentPath/$MainFile"
	java -jar $EncoderPath -i "$enFrom" -o $enTo
	dialog --title 'File Compiled' --backtitle "$header" --msgbox "$cpFrom was comiled to $enTo" 8 60
}

#main menu that will allow you to select which payload you want to dump in the root directory for the
#rubber ducky to use.
DoMenu()
{
	i=0
	x=1
	options=""
	while read line
	do
		array[ $i ]="$line" 
		if [[ -n "$options" ]]; then
			options=("${options[@]}" "$x" "\"$line\"" "on")
		else
			options=("$x" "\"$line\"" "off")
		fi
		(( i++ ))
		(( x++ ))
	done < <(ls $ScriptsPath)
	cmd=(dialog --clear --title "My Payloads" --backtitle "$header" --radiolist "Select options:" 22 76 16)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	if [ -z "$choices"] ; then
		choices=0
	fi
	if (($choices > 0)) ; then
		arrayID=`expr $choices - 1`
		PathName="${array[$arrayID]}"
		if [ -f "$ScriptsPath/$PathName/$MainFile" ]; then
			DoCopy $PathName
			DoMenu;
		else
			RunEncoder $PathName
			DoMenu;
		fi
		clear
		echo "Good Bye Happy Ducking!"
	else
		clear
		echo "No Options selected..Good Bye!"
	fi
}

if $MakeDirMoveFiles ; then
	MakeDirFromFiles;
fi

DoMenu;
