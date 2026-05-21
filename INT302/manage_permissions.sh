#!/bin/bash

# Script to manage file permissions

file="/home/labfile.txt"

echo "Viewing file permissions for $file..."
ls -l $file

echo "Changing permissions to read, write, and execute for the owner..."
chmod u+rwx $file

echo "New permissions for $file:"
ls -l $file

directory="/home/labdir"

echo "Changing permissions for all files in $directory recursively..."
chmod -R 755 $directory

echo "Listing permissions for all files in $directory..."
ls -l $directory

echo "Changing ownership of $file to user 'john'..."
chown john $file

echo "Ownership of $file has been changed:"
ls -l $file

echo "Changing ownership of all files in $directory to user 'john'..."
chown -R john $directory

echo "Listing ownership for all files in $directory..."
ls -l $directory

echo "Checking if $file exists before changing permissions..."
if [ -e $file ]; then
    chmod u+rwx $file
    echo "Permissions changed successfully."
else
    echo "Error: $file does not exist!"
fi

echo "Applying ACL for user 'john' to read the file..."
setfacl -m u:john:r /home/labfile.txt

echo "Viewing ACL for $file..."
getfacl /home/labfile.txt

echo "Removing ACL for user 'john'..."
setfacl -x u:john /home/labfile.txt

echo "ACL removed. Current ACL for $file:"
getfacl /home/labfile.txt

echo "Archiving and compressing the /home/labdir directory..."
tar -czvf /tmp/labdir_backup.tar.gz /home/labdir --preserve-permissions

echo "Backup created with preserved permissions."
