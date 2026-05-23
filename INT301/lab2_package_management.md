# INT301 Lab 2: Advanced Package Management and Application Deployment

## Part 1: Advanced APT Operations

### Exercise 1.1: apt upgrade vs apt full-upgrade
- `apt upgrade`: Upgrades packages but will never remove installed packages
- `apt full-upgrade`: Upgrades packages and will remove or add packages if needed to resolve dependencies

### Exercise 1.2: Wireshark dependencies and python3 dependents
**Wireshark dependencies:**
- libc6, libgcc-s1, libgcrypt20, libglib2.0-0t64, libminizip1t64, libnl-3-200, libnl-genl-3-200, libnl-route-3-200, libpcap0.8t64, libqt6core5com

**Packages that depend on python3:**
- python3-dev, llvm-18-tools, clang-18, python3-rna, nsight-systems and many more

### Exercise 1.3: Three password cracking tools in Kali
1. aircrack-ng — wireless WEP/WPA cracking utilities
2. crack — Password guessing program (crypt() variant)
3. crack-md5 — Password guessing program (MD5 variant)

## Part 2: Advanced Installation Techniques

### Exercise 2.1: Python3 version and package hold
- Python3 currently installed and available version: 3.13.9-3
- When holding a package: the package is set on Hold and prevented from upgrading

### Exercise 2.2: htop installation from local file
- htop downloaded and installed successfully from local .deb file
- If dependencies are missing, dpkg throws an error and `sudo apt install -f` fixes them

## Part 3: Dependency Management

### Exercise 3.1: remove vs purge
- `apt remove`: Removes package but keeps configuration files. Use when package might be reinstalled later
- `apt purge`: Removes package AND configuration files. Use when you want a completely clean uninstall

## Part 4: Repository Management

### Exercise 4.1: Why pin packages from specific repositories
- Control stability: prefer Kali packages over Debian to avoid conflicts
- Prevent unwanted upgrades: keep critical tools at a specific version
- Mix repositories safely: use testing repo for one package without upgrading everything else

## Part 5: Alternative Package Managers

### Exercise 5.1: Installation locations comparison
- **APT:** Standard system directories like /usr/bin, /usr/lib, /etc
- **Snap:** Installed in /snap/ and run in an isolated sandbox
- **Flatpak:** Installed in /var/lib/flatpak/ or ~/.local/share/flatpak/ and also run sandboxed

## Part 6: Source Compilation

### Exercise 6.1: Compiling from source vs package managers

**Advantages of compiling from source:**
- Get the latest version not yet in repositories
- Can customize compilation options
- Works when no package exists

**Disadvantages of compiling from source:**
- No automatic updates
- Must manually manage dependencies
- Takes more time and technical knowledge

**Advantages of package managers:**
- Automatic updates and dependency management
- Faster and easier installation
- Tracked and removable cleanly

## Part 7: Advanced Troubleshooting

### Exercise 7.1: Files installed by nmap package
- /usr/bin/nmap — main nmap executable
- /usr/bin/nping — network packet generator
- /usr/lib/nmap/nmap — nmap library binary
- /usr/share/doc/nmap/ — documentation files

## Challenge Exercises

### Challenge 1: Repository Migration
- Added kali-experimental repository to sources.list
- Potential risks: Experimental packages may be unstable or break dependencies

### Challenge 2: Dependency Graph
- kali-linux-large has 11,505 lines of dependencies
- Used apt-rdepends to generate the full dependency graph

### Challenge 3: Custom Package Creation
- Created system information script
- Packaged as DEB file with proper dependencies
- Installed and tested successfully

### Challenge 4: Recovery Scenario
- Simulated broken package by force removing python3-minimal
- Fixed with: `sudo apt --fix-broken install`
- Time to fix: Under 1 minute
