# INT301 Lab 4: Linux File Permissions and Ownership

## Key Concepts

### File Permission Types
- **Read (r):** Permission to read the file
- **Write (w):** Permission to modify or delete the file
- **Execute (x):** Permission to run the file as a program

### User Types
- **Owner:** The user who created the file
- **Group:** Users who belong to the same group
- **Others:** All other users

### Permission Codes Table
| Symbol | Meaning | Octal Value |
|--------|---------|-------------|
| r | Read permission | 4 |
| w | Write permission | 2 |
| x | Execute permission | 1 |
| - | No permission | 0 |

## Part 1: Viewing File Permissions

### Commands Used
- `ls -l` — List files with permissions
- `chmod` — Change file permissions
- `chown` — Change file ownership
- `chgrp` — Change group ownership

## Part 2: Modifying Permissions

### Exercise 1: Permission experiments
- `chmod 777 testfile.txt` — Full permissions for everyone
- `chmod 644 testfile.txt` — Owner read/write, group and others read only

### Permission breakdown
| Octal | Permissions | Description |
|-------|------------|-------------|
| 777 | rwxrwxrwx | Full permissions for everyone |
| 755 | rwxr-xr-x | Owner full, group/others read+execute |
| 644 | rw-r--r-- | Owner read/write, group/others read only |
| 600 | rw------- | Owner read/write only, no access for others |

## Part 3: Changing Ownership

### Exercise 2: Group ownership
- Changed group ownership using `sudo chgrp staff testfile.txt`
- Verified with `ls -l`

## Part 4: Practical Exercises

### Exercise 3: Create and modify permissions
- file1.txt: `chmod 755` — Full for owner, read+execute for group/others
- file2.txt: `chmod 644` — Read/write for owner, read for group/others
- file3.txt: `chmod 777` — Full permissions for everyone

### Exercise 4: Ownership challenge
- Created Project directory
- Set current user as owner with `sudo chown $USER:$USER Project`
- Verified with `ls -ld Project`
