# DuckyMenu

I created a shell script to help manage my ducky scripts and to copy what i wanted to use to the root of the drive.  After creating it, i wanted to post it just incase anyone else might find it useful.

This shell script on a mac, and also tested it out on another linux based box and didn’t have any problems.  The only thing I had to do on the mac was download the “dialog” command via brew.

Currently my SD card contains the following directory structure:

![](https://github.com/burnsoftnet/DuckyMenu/blob/GitHubDuckMenu/dirStructure.png?raw=true)

As you can see, some of these scripts are from the repository.  The Directories are the same name as the script, each directory has the script and the compiled version of the script ready for the duck.

When i put in the SD card, i run the menu.sh to bring up the “script manager”
what is does is just read the contents of the directory structure and puts it in a menu.

![](https://github.com/burnsoftnet/DuckyMenu/blob/GitHubDuckMenu/menu.png?raw=true)

![](https://github.com/burnsoftnet/DuckyMenu/blob/GitHubDuckMenu/menu1.png?raw=true)

I find the one i want and hit enter and it will copy it to the root drive

![](https://github.com/burnsoftnet/DuckyMenu/blob/GitHubDuckMenu/file_copied.png?raw=true)

and the script exits.

if the inject.bin does not exist where the script is located at, then it will compile it.
A lot of the top vars can be changed if you need to.  I mostly created it based on how i run and manage the scripts.


[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JSW8XEMQVH4BE)]
