# On box and rsync

## box

* Community, https://community.box.com/
* Sync, https://app.box.com/settings/sync
* Account, https://app.box.com/folder/50333212285

## rsync

https://everythinglinux.org/rsync/

**syntax** rsync -options --otherOptions sourceDir targetDir

where Dir could be username@remote_host:destination_directory.

OPtions | Description
-v | Turn on verbose mode
-a | This turns on archive mode to recurse the directory copying all the files and directories and perserving things like case, permissions, and ownership on the target (Note: Ownership may not be preserved if you are not logged in as the root user)
-z | Turns on compression during the transfer. This option compresses the data as it is copied over the network
-r | --recursive: recurse into directories
-h | human-readable: output numbers in a human-readable format
-u | --update: skip files that are newer on the receiver
-n | --dry-run: show what would have been transferred
-e | option with protocol name you want to use, e.g., -avzhe ssh
--bwlimit | e.g., bandwidth=100
--existing | only update files that already exist on receiver
--exclude | To exclude certain files and directories from the copy process similar to .gitignore
--include | opposite of --exclude
-P | Combination of --progress which gives you a progress bar for the transfers and --partial allows you to resume interrupted transfers
-ssh | --rsh="ssh -l username" to copy over network
