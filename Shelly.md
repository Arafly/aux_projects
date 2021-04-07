## Automate the creation of new users on linux from a CSV file

1. For speed (because my VS Code and other utilies), I carried out the exercise on local which is a Windows, and used a tool called *winscp* to transfer the files to a client Ubuntu in my VirtualBox, named *Shelly*

![](https://github.com/Arafly/aux_projects/blob/master/assets/winscp.PNG)

![](https://github.com/Arafly/aux_projects/blob/master/assets/wisnc.PNG)

2. After the successful transfer of the file to Shelly. I connected Shelly to a cloned Ubuntu machine named *remoteful*. SSH'd from Shelly to Remoteful using password authentication, then transfered the folder containing the script file, scv and authorized keys

![](https://github.com/Arafly/aux_projects/blob/master/assets/Scp.PNG)

3. I ran the script of Remoteful. Where each of the users were successfully created.

![](https://github.com/Arafly/aux_projects/blob/master/assets/usercreation.PNG)

4. Verified the creation of the group and the aformentioned users by checking the group and /etc/passwd

`tail /etc/passwd`

![](https://github.com/Arafly/aux_projects/blob/master/assets/Names.PNG)

`getent group developers`

![](https://github.com/Arafly/aux_projects/blob/master/assets/groupie.PNG)

1. Finally, I logged in some of the created users to test if the creation was really succesful. As seen in the screenshot, I used the user "Osas".

![](https://github.com/Arafly/aux_projects/blob/master/assets/newuser.PNG)


### A few gotchas/pointers while working on this script

- Ensure you leave a shebang at the beginning of your script (#!/bin/bash) this would automatically set the shell to bash, so you don't get unexpected surprises.
- Due to the empty variable that we set to our IFS (Internal File Separator). You should leave an empty line at the end of your names.csv file. So the iteration can start from top to bottom and settle on the last empty line. If not, the IFS would be expecting more entries after the last name.
- Line 55 was to test if the user creation was successful and to update the user with a feedback (if it was successful or not).
- Ensure that in the ssh client system-wide configuration file in /etc/ssh/. *PasswordAuthentication* is set to yes
- Make sure you create create a file to hold the private key, specifically name *id_rsa* and copy the content of the authorized_keys into *id_rsa.pub*

>I have excluded both the id_rsa from by placing them in my .gitignore
