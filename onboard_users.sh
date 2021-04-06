#!/bin/bash

# Automate the creation of new users on linux from a CSV file

# The csv file name
CSV=names.csv

# The group name
GROUPIE=developers

# name of ssh directory for skel
SSH_SKEL=/etc/skel/.ssh/

# variable for public key csv_file
AUTHZ=authorized_keys

# password variable
PASSWORD=password@123#

# Check if group exists
if [[ $(getent group $GROUPIE) ]]; then
    echo "$GROUPIE group already exists"
else
    sudo groupadd $GROUPIE
    echo "$GROUPIE group successfully created"
    # exit 0
fi

# Add ssh folder to skel directory
if [[ -d "${SSH_SKEL}" ]]; then
    echo "$SSH_SKEL already exists"
else
    sudo mkdir -p $SSH_SKEL
    sudo touch $SSH_SKEL/$AUTHZ
    sudo bash -c "cat $AUTHZ >> $SSH_SKEL/authorized_keys"
fi

# User creation on server
while IFS= read CURRENT; do
    #  check if current username already exists
    if [[ $(getent passwd $CURRENT) ]]; then
        echo "$CURRENT already exists"
    else
        sudo useradd -m -G $GROUPIE -s /bin/bash $CURRENT
        sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "${CURRENT}"
        # Force password change on first login
        sudo passwd -e ${CURRENT}
        # sudo passwd -x 3 ${CURRENT}
        sudo chmod 700 /home/$CURRENT/.ssh
        sudo chmod 644 /home/$CURRENT/.ssh/$AUTH
        echo "$CURRENT successfully created"
    fi

    # Check to see if the user was created successfully
    if [[ "${?}" -ne 0 ]]; then
        echo 'The user was not able to create.'
        exit 1
    fi
done <$CSV

exit 0
