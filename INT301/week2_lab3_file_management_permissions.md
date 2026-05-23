# INT301 Week 2 Lab 3: Automating Advanced File Management and Permissions

## Lab Overview
Focused on automating file management tasks with bash scripts, including
handling file permissions, ownership changes, and access control.

## Learning Objectives Achieved
1. Automated management of file and directory permissions
2. Automated changing ownership of files and directories
3. Used conditional statements to handle permission errors
4. Implemented automated security practices using ACLs
5. Mastered file archiving and compression while retaining permissions

## Part 1: Automating File Permissions

### 1.1 Viewing and Modifying Permissions
Created manage_permissions.sh that:
- Displays current file permissions
- Changes permissions to read, write, execute for owner
- Verifies changes with ls -l

### 1.2 Recursive Permission Changes
Added recursive permission changes to manage_permissions.sh:
- Applied chmod -R 755 to entire directory
- Verified changes on all files in directory

## Part 2: Automating Ownership Changes

### 2.1 File Ownership
Added ownership change to manage_permissions.sh:
- Changed ownership of labfile.txt to user john
- Verified with ls -l showing john as owner

### 2.2 Recursive Ownership Changes
Added recursive ownership to manage_permissions.sh:
- Applied chown -R john to entire directory
- Verified all files show john as owner

## Part 3: Permission Error Handling

### 3.1 Conditional Error Handling
Added error handling to manage_permissions.sh:
- Checks if file exists before changing permissions
- Displays clear error message if file not found
- Result: "Permissions changed successfully" confirmed

## Part 4: Access Control Lists (ACLs)

### 4.1 Managing File ACLs
Added ACL management to manage_permissions.sh:
- Applied read ACL for user john using setfacl
- Verified with getfacl showing:
  - user::rwx
  - user:john:r--
  - group::r--
  - mask::r--

### 4.2 Removing ACLs
Added ACL removal to manage_permissions.sh:
- Removed john's ACL using setfacl -x
- Verified removal with getfacl

## Part 5: File Archiving with Permissions

### 5.1 Retaining Permissions in Archives
Added archiving to manage_permissions.sh:
- Compressed /home/labdir using tar -czvf
- Used --preserve-permissions flag
- Verified backup: 124 bytes at /tmp/labdir_backup.tar.gz

## Part 6: Exercises

### Exercise 1: Automated Permission Checker (permission_checker.sh)
Script that:
- Takes a directory as input
- Checks permissions of all files
- Automatically adds execute permission if missing
- Result: All 3 test files detected and fixed successfully

### Exercise 2: Bulk Ownership Change (bulk_ownership.sh)
Script that:
- Accepts directory path and username as input
- Recursively changes ownership of all files
- Result: file1.txt, file2.txt, file3.txt all changed to john successfully

### Exercise 3: Automated ACL Management (acl_management.sh)
Script that:
- Sets default ACL on directory for specific user
- Grants read and execute permissions
- Default ACL ensures new files inherit permissions automatically
- Result: default:user:john:r-x confirmed in getfacl output

### Exercise 4: Scheduled Backup Script (scheduled_backup.sh)
Script that:
- Automates daily backups with date in filename
- Preserves file permissions and ownership
- Saves as backup_YYYY-MM-DD.tar.gz format
- Result: backup_2026-05-14.tar.gz created successfully (180 bytes)
  - All 3 files from /home/labdir backed up
  - Permissions preserved
