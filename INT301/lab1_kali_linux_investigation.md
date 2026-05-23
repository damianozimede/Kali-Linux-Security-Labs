# INT301 Lab 1: Investigate Kali Linux

## Part 1: Advanced Directory Navigation & Creation

### Exercise 1.1: Difference between cd ~ and cd /home/kali
- `cd ~` takes you to /root. It is relative to the active user
- `cd /home/kali` takes you to /home/kali. It is an absolute path to a specific folder

### Exercise 3.1: How ../ syntax works
The `../` syntax is known as a Relative Path. It acts as a pointer to the parent of the current working directory. 
- Single Dot (.): Represents the directory currently in
- Double Dot (..): Represents the directory immediately above current one

## Part 2: Comprehensive File Operations

### Exercise 2.1: Verify copies were created
Both copies verified successfully using ls command.

### Exercise 4.1: Delete all .tmp files
All .tmp files in temp_files removed with single rm command.

## Part 3: File Content Management

### Exercise 2.1: What does diff output show?
The diff output shows the difference between two files line by line.
Line 1 in config_old.txt (Version 1.0) was changed to line 1 in config_new.txt (Version 2.0).

### Exercise 3.2: Count ERROR messages
There are 2 ERROR messages in the file.

### Exercise 3.3: Show lines 2-3 of logfile.txt
Command: `head -3 logfile.txt | tail -2`

## Part 4: Advanced Permission Exercises

### Exercise 4.1: Permission changes explained
- `chmod u+x admin_tool.sh` — Added execute permission for owner
- `chmod o-r secret_file.txt` — Removed read permission from others
- `chmod a+w public_read.txt` — Added write permission for all users

### Exercise 4.2: Octal permissions explained

| Octal | Permissions | Meaning |
|-------|------------|---------|
| 755 | rwxr-xr-x | Owner: full, Group/Others: read+execute |
| 600 | rw------- | Owner: read+write, Group/Others: none |
| 644 | rw-r--r-- | Owner: read+write, Group/Others: read only |

## Part 5: Search and Find Operations

### Exercise 5.1: Difference between outputs
- `-name` searches by filename patterns
- `-type f` finds only regular files
- `-type d` finds only directories

### Exercise 5.2: find with exec accomplished
The command searched Lab1 for all .sh files and automatically added execute permission using chmod +x.

## Part 6: Text Processing

### Exercise 6.1: Three numbers from wc represent
The three numbers represent: number of lines, words, and bytes/characters.

## Part 7: Compression and Archiving

### Exercise 7.1: Extraction verified successfully

## Part 8: System Monitoring

### Exercise 8.1: Lab1 directory space
Lab1 directory uses 136K (136 kilobytes)

## Challenge Exercises

### Challenge 1: Penetration Test Directory Structure
Created Engagement_2024 with subdirectories:
- reconnaissance, exploitation, reporting, evidence
- evidence/screenshots, evidence/logs, evidence/packets
- readme.txt in each main directory

### Challenge 2: Permission Scheme
- All .sh files: executable only by owner
- All .txt files: readable by everyone, writable by owner only
- One file with no permissions for anyone

### Challenge 3: Command Line Operations
1. Found all .log files in home directory
2. Counted lines containing "ERROR"
3. Saved results to error_report.txt
