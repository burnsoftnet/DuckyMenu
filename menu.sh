#!/bin/bash
#ducky_menu.sh
#Version: 1.0.5
#by JM
MainFile="inject.bin";  #the compiled file for the rubber ducky
CurrentPath=$PWD;		#The path of were the menu.sh was ran, this can be hardcoded if needed
ScriptsPath="$CurrentPath/scripts";	 #path of where the scripts are at, usually a sub folder of the current
EncoderPath="$CurrentPath/Encoder/encoder.jar"; #location of the encoder
MakeDirMoveFiles=true;	#if you have the code in the scripts director and what it to be in it's own directory
ScriptExt="txt";		#the extenstion of the script
PathName="";			#global var, leave blank
choices="";				#global var, leave blank

MakeDirFromFiles()
{
	cd $ScriptsPath
	for file in *.$ScriptExt; 
		do 
			mkdir -- "${file%.$ScriptExt}"; mv -- "$file" "${file%.$ScriptExt}"; 
		done
	cd $CurrentPath
}
DoCopy()
{
	cpFrom="$ScriptsPath/${PathName[@]}/$MainFile"
	cpTo="$CurrentPath/$MainFile"
	cp "$cpFrom" "$cpTo"
	dialog --title 'File Copied' --msgbox "$cpFrom was copied to $enTo" 6 60
}
RunEncoder()
{
	enFrom="$ScriptsPath/${PathName[@]}/${PathName[@]}.$ScriptExt"
	enTo="$CurrentPath/$MainFile"
	java -jar $EncoderPath -i "$enFrom" -o $enTo
	dialog --title 'File Compiled' --msgbox "$cpFrom was comiled to $enTo" 8 60
}
DoMenu()
{
	i=0
	x=1
	while read line
	do
		array[ $i ]="$line" 
		if [[ -n "$options" ]]; then
			options=("${options[@]}" "$x" "\"$line\"" "off")
		else
			options=("$x" "\"$line\"" "off")
		fi
		(( i++ ))
		(( x++ ))
	done < <(ls $ScriptsPath)
	cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	if [ -z "$choices"] ; then
		choices=0
	fi
	if (($choices > 0)) ; then
		arrayID=`expr $choices - 1`
		PathName="${array[$arrayID]}"
		if [ -f "$ScriptsPath/$PathName/$MainFile" ]; then
			DoCopy $PathName
		else
			RunEncoder $PathName
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
