#!/bin/bash
 
## Works best when using Thunar > View > Location Selector > Toolbar Style
## Requirements: xdotool, xclip
 
# Todo:
# *) [Sort of Done] Support for other terminal other xfce4-terminal?
# *) [Done] Open terminal when viewing remote desktop
#   Was having problem in opening to the correct directory if opened via
#   gsshfs. However fixed in version 0.4.
# *) [Done] Check for dependencies
# *) [Done] Write installation and HelpText
# *) Bug: Doesn't always close the "Open Location" window when Thunar has
#       "Pathbar Style" location. In other words, inconsistence behaviour
#       for "Pathbar Style".
# *) [Done] Bug: Opening terminal to $HOME even when thunar not active
#       -> Typo was removed.
# *) [Done] Activate terminal window after opening
#       -> Ugly hack



TerminalEmulator="urxvtc" #"xfce4-terminal"
ExtraParameters="" #"--drop-down"
WorkingDirParameter="--working-directory="


ScriptName=$(basename $0)
Author="Anjishnu Sarkar"
Version="0.5"
Requirements="xdotool xclip $TerminalEmulator"
HelpText="$ScriptName: Script to open a terminal in the same directory as
thunar file manager via shortcut key. Written specifically for openbox.
Can be configured to use in other windows managers as well.
 
The script has support for opening remote folders too.
If thunar is viewing remote desktop and has the location bar in the format
sftp://username@server/remote/home/some/folder
then pressing the binded key in that directory opens a terminal via ssh.
 
Requirements are $Requirements.
Author: $Author, Version: $Version
 
Installation:
Set the \$TerminalEmulator variable
Make the script executable
   chmod +x ${ScriptName}
Copy it in your \$PATH
   cp thunar-terminal.sh ~/bin/
Add a global keyboard shortcut to this script
   xfce4-keyboard-settings > \"Application shortcuts\" tab > Add

Thunar configuration:
Works if \"Location Selector\" of thunar is in \"Toolbar Style\".
Thunar menu: View > Location Selector > Toolbar Style.
 
Restart X (Logout and login). Now open thunar, move to any directory and
press \"F4\" to open a terminal in the same directory.
"
ErrMsg="$ScriptName: Unspecified option. Aborting."
 
while test -n "$1"
do
    case "$1" in
        -h|--help)  echo -n "$HelpText"
                    exit 0 ;;
 
        *)          echo "$ErrMsg"
                    exit 1 ;;
    esac
    shift
done
 
for Software in $Requirements
do
    if ! which ${Software} >/dev/null;then
        echo "The software \"${Software}\" is not installed. Aborting."
        exit 1
    fi
done
 
## Get current active window
ActiveWinID=$(xdotool getactivewindow)
 
## Get all thunar windows ids
# WindowIDS=$(xdotool search --class --name ".*File Manager")
WindowIDS=$(xdotool search --class "Thunar")
 
## Check whether the active window id actually belongs to a thunar window
## or not
for WinID in $WindowIDS
do
    ## If activewindow is same as thunar window, then
    if [ "$WinID" == "$ActiveWinID" ];then
        echo "Found active thunar window."
        ## Get thunar pathbar
        xdotool key --window "$ActiveWinID" --clearmodifiers "Ctrl+l"
 
        ## Select all
#         xdotool key --window "$ActiveWinID" --clearmodifiers "Ctrl+a"
 
        ## Save old clipboard value
        OldClip=$(xclip -o)
 
        ## Copy thunar directory path to clipboard
        xdotool key --window "$ActiveWinID" --clearmodifiers "Ctrl+c"
 
        ## Should remove the pathbar if selected
        xdotool key --window "$ActiveWinID" --clearmodifiers "Return"
#         xdotool search --name "Open Location" windowkill
 
        ## Copy the path to variable
        Location=$(xclip -o)
 
        ## Restore old clipboad value
        echo "$OldClip" | xclip -i
 
        ## If connected to remote server, grab user name and server
        User_Server=$(echo "$Location" | sed 's/\//\n/g' | grep '@' \
            | cut -d: -f1)
 
        if [ -z "$User_Server" ];then
            ## Open terminal in location
            $TerminalEmulator $ExtraParameters $WorkingDirParameter$Location &
            PID=$(echo "$!")
        else
            WorkingDir="$(echo "$Location" | sed 's/^.*@//' \
               | sed 's/::/\//' | sed 's/:/\//g' \
               | sed 's/\//@/' \
               | sed 's/^.*@/\//' | sed 's/ /\\ /g')"
            $TerminalEmulator -x ssh -tX "$User_Server" "cd ${WorkingDir} 2>/dev/null; bash" &
            PID=$(echo "$!")
        fi
 
        ## Wait before searching for the latest window
        sleep 0.5s
        XtermID=$(xdotool search --pid "$PID" --class "$TerminalEmulator" \
            | tail -n 1)
 
        ## Activate latest window
        xdotool windowactivate "$XtermID"
        exit 0
    fi
done
 
echo "Thunar window was not active. Aborting."
exit 1
