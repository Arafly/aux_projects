#!/bin/bash

# Automate the creation of new users on linux from a CSV file

# The csv file name
CSV=names.csv

# The group name
GROUPIE=developers

# Check if group exists
if [[ $(getent group $GROUPIE) ]]
then
    echo group already exists
    
else
    sudo groupadd $GROUPIE
    echo '$GROUPIE group successfully created'
    # exit 0
fi


