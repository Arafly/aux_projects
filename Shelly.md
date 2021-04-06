### A few gotchas/pointers while working on this script

- Ensure you leave a shebang at the beginning of your script (#!/bin/bash) this would automatically set the shell to bash, so you don't get unexpected surprises.
- Due to the empty variable that we set to our IFS (Internal File Separator). You should leave an empty line at the end of your names.csv file. So the iteration can start from top to bottom and settle on the last empty line. If not, the IFS would be expecting more entries after the last name.
- Line 55 was to test if the user creation was successful and to update the user with a feedback (if it was successful or not).
- Ensure that in the ssh client system-wide configuration file in /etc/ssh/. *PasswordAuthentication* is set to yes
- Make sure you create create a file to hold the private key, specifically name *id_rsa* and copy the content of the authorized_keys into *id_rsa.pub*

>I have excluded both the id_rsa and id_rsa.pub from by placing them in my .gitignore
