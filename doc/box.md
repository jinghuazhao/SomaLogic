# On box, FileZilla, ftp/lftp, and rsync

## box

* Community, https://community.box.com/
* Sync, https://app.box.com/settings/sync
* Account, https://app.box.com/folder/50333212285

## FileZilla

https://filezilla-project.org/index.php

It is very unwieldy to install for ordinary users.

## ftp/lftp

plain FTP is not allowed at the clusters, so we turned to lftp. This script downloads from remote directory at the FTP site to local direcory,
```bash
#!/bin/bash

HOST="ftp.box.com"
USER="USER"
PASS="PASS"
FTPURL="ftp://$USER:$PASS@$HOST"
LCD="Local directory"
RCD="Remove directory"

lftp $HOST <<END
set ftp:list-options -a;
open '$FTPURL'
lcd $LCD;
cd $RCD;
mirror --parallel=15 --log=$HOME/box.log --verbose
bye
END
```
A verbose log file is request. One can use additional options such as --exclude-glob a-dir-to-exclude --exclude-glob a-file-to-exclude --exclude-glob a-file-group-to-exclude* --exclude-glob other-files-to-exclude.

## rsync

https://everythinglinux.org/rsync/

**syntax**: rsync -options --otherOptions sourceDir targetDir

where Dir could be username@remote_host:destination_directory.

OPtions | Description
--------|----------------------------------------------------
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


**GUI**: https://sourceforge.net/projects/grsync/

However, rsync was not designed for FTP.
