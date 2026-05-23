# INT301 Week 2 Lab 2: Advanced Linux Command Shell Automation

## Part 1: Intelligent Navigation System

### Concept
Created smart_navigator.sh that solves the problem of basic cd commands not
remembering navigation history.

### Features Built
- History file with timestamps for every directory change
- Safe navigation function with error checking
- History viewer showing last 10 entries
- Safety checks before navigating

### Discussion Questions

**Q1: What happens if you navigate to a file instead of a directory?**
The script displays a misleading error saying the directory "does not exist"
even though the file actually exists. This is because [ -d ] only checks for
directories. To improve, add [ -f ] check to display a more specific message
like "Error: That is a file, not a directory".

**Q2: What would happen if the history file becomes very large?**
The history file could grow very large over time, wasting disk space and making
it slow to read. To fix this, implement automatic cleanup by trimming the file
after every navigation using tail, keeping only the most recent entries.

**Q3: When would navigation tracking be useful in system administration?**
- Troubleshooting — retrace steps to find which directories were visited
- Forensic investigation — track suspicious directory access
- Unfamiliar systems — find way back to important locations
- Auditing — maintain record of what was accessed and when

## Part 2: Robust File Operations

### Features Built in file_manager.sh
- Secure file creation with directory structure creation
- Permission management with verification
- Safe move with automatic backup creation
- Error handling for all operations

### Critical Thinking Answers

**Q1: What happens if disk is full during file creation?**
File creation fails silently with only a generic failure message. To improve,
add a disk space check before attempting to create the file so the user gets
a clear warning like "Not enough disk space available".

**Q2: How does script handle permission denied errors?**
Script shows only a generic failure message without specifying it was a
permissions issue. To improve, capture system error messages using 2>&1 and
check beforehand if user has write permission using [ -w ].

**Q3: What additional safety features could we add?**
- Checksum verification to confirm file integrity after creation
- File size limits to prevent disk abuse
- User confirmation prompts before overwriting files
- Detailed logging of all file operations
- Permission checks using [ -r ], [ -w ], and [ -x ] before operations

## Part 3: Interactive Menu System

### Features Built in automation_dashboard.sh
- Main menu with 8 options
- Smart Navigation submenu
- File Creation submenu
- System Information display
- Sources both smart_navigator.sh and file_manager.sh

### Learning Reflection Answers

**Q1: How does menu system improve usability?**
- Users don't need to remember exact command names or syntax
- Everything accessible from a single interface
- Guided interaction reduces mistakes
- Menu catches invalid options gracefully

**Q2: What happens if user enters invalid data?**
The case statement catches it with * wildcard and displays "Invalid option.
Please try again." Script never crashes — keeps looping until valid option chosen.

**Q3: How easy to add new functions?**
Very easy — just add a numbered option to show_main_menu, add a matching case
entry in handle_menu_selection, and write the new function. This is called
modular design.

**Q4: Real-world applications?**
- Banking and finance — automating routine file operations and backups
- IT departments — giving junior staff guided way to perform tasks
- Data centers — managing multiple servers through simple interface
- Cybersecurity teams — running routine security checks
- Hospitals and government — managing files safely

## Part 4: Advanced Exercises

### Exercise 4.1: Automated Backup System (backup_system.sh)
Created backup system that:
- Creates timestamped backups
- Compresses backups using tar
- Maintains rotation of maximum 5 backups
- Verifies backup integrity
- Result: Working perfectly

### Exercise 4.2: System Health Monitor (health_monitor.sh)
Created monitoring script that:
- Checks disk space with configurable threshold
- Monitors memory usage
- Checks critical services (ssh, apache2)
- Alerts if issues detected
- Result: Disk 31% OK, Memory 30% OK, SSH and Apache2 not running (normal)

### Exercise 4.3: Log File Analyzer (log_analyzer.sh)
Created analyzer that:
- Analyzes log files for errors
- Generates summary reports
- Archives old log files
- Result: Found 21 errors in dpkg.log
