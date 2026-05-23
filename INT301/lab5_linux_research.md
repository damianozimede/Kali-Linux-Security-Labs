# INT301 Lab 5: Advanced Linux Research & Analysis

## Executive Summary
This report investigates two key topics:
1. Linux Kernel Security Mechanisms
2. Advanced Linux Commands for Security

Key findings show Kali Linux has robust security features including AppArmor 
(119 profiles loaded, 17 in enforce mode) and ASLR enabled at level 2.

## Section 1: Linux Kernel Security Mechanisms

### ASLR (Address Space Layout Randomization)
- Current setting: 2 (full randomization)
- Randomizes memory addresses to prevent exploitation
- Setting 0=disabled, 1=partial, 2=full

### AppArmor
- Status: Loaded and active
- 119 profiles loaded, 17 in enforce mode
- Provides mandatory access control (MAC)
- Limits program capabilities to prevent exploitation

### SELinux vs AppArmor
| Feature | SELinux | AppArmor |
|---------|---------|----------|
| Type | Label-based | Path-based |
| Complexity | More granular | Easier to configure |
| Used in | RHEL/CentOS | Debian/Kali |

## Section 2: Advanced Linux Commands for Security

### Nmap Results (scanme.nmap.org)
- Port 22 (SSH): OpenSSH 6.6.1p1
- Port 80 (HTTP): Apache 2.4.7
- Multiple filtered ports indicating firewall presence

### Forensic Commands
- `dd` — Disk imaging and data copying
- `strings` — Extract readable text from binary files
- `file` — Identify file types

## Section 3: Security Features on Kali System
- **ASLR:** Fully enabled (level 2)
- **AppArmor:** Active with 119 profiles
- **Automatic updates:** Enabled via apt-daily-upgrade.timer
- **Security tools installed:** burpsuite, arp-scan, ike-scan, fierce

## Section 4: Vulnerability Case Study

### CVE-2021-4034 (PwnKit)
- **CVSS Score:** 7.8 (High)
- **Type:** Local privilege escalation
- **Affected:** All major Linux distributions
- **Component:** PolicyKit (pkexec)
- **Impact:** Full root access
- **Fix:** Patched in polkit version 0.120

## Section 5: Research Tables

### Security Distribution Comparison
| Feature | Kali Linux | Parrot OS | BlackArch |
|---------|-----------|-----------|-----------|
| Update Frequency | Rolling | Rolling | Rolling |
| Default Hardening | Medium | Medium | Low |
| Tool Collection | 600+ | 400+ | 2800+ |
| Use Case | Pentesting | Privacy/Pentesting | Advanced Research |

### Security Implementation
| Mechanism | Implementation | Effectiveness |
|-----------|--------------|---------------|
| AppArmor | Path-based MAC | High |
| ASLR | Full (level 2) | High |
| Firewall | iptables | Medium |
| Auto Updates | Daily | High |

## Section 6: Recommendations
1. Keep ASLR at level 2 always
2. Enable more AppArmor profiles
3. Implement stricter iptables rules
4. Regular security audits using installed tools
5. Monitor CVE databases for new vulnerabilities

## Section 7: Memory Protection Features

### Stack Protection
- Stack canaries detect buffer overflow attacks
- Implemented via gcc -fstack-protector flag
- Prevents classic stack smashing attacks

### NX/XD Bit (No-Execute)
- Marks memory regions as non-executable
- Prevents shellcode execution in data segments
- Hardware-enforced on modern processors

### SMEP/SMAP
- Prevents kernel from executing user-space code
- Blocks kernel from accessing user-space memory
- Critical for preventing privilege escalation

## Section 8: Incident Response Commands
- `ps aux` — List all running processes
- `netstat -tulpn` — Show network connections
- `last` — Show login history
- `who` — Show logged in users
- `find / -mtime -1` — Find recently modified files

## Log Files to Monitor
- `/var/log/auth.log` — Authentication attempts
- `/var/log/syslog` — System messages
- `/var/log/kern.log` — Kernel messages
- `/var/log/apache2/` — Web server logs
- `/var/log/dpkg.log` — Package installation logs

## Section 9: Conclusion
1. Linux provides robust built-in security mechanisms including ASLR and AppArmor
2. Kali Linux is purpose-built for security with 600+ specialized tools
3. Advanced commands like dd, strings, nmap, and tcpdump are essential skills
4. Linux security continues to evolve with eBPF and AI-powered monitoring
5. Proper hardening following CIS benchmarks reduces attack surface significantly
