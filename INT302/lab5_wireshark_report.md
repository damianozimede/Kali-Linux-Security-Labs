# Lab 5: Wireshark Network Analysis Report
## Target Information
- **IP Address:** 192.168.5.130
- **Target:** OWASP Broken Web Applications VM
- **Capture Interface:** eth0
- **Date:** May 22, 2026

## Exercise 1: Wireshark GUI Components
| Component | Description |
|-----------|-------------|
| Menu Bar | File, Edit, View, Go, Capture, Analyze, Statistics, Telephony, Wireless, Tools, Help |
| Toolbar | Icons for start/stop capture, open/save files, navigation, and zoom |
| Display Filter Bar | Input field for filtering captured packets (Ctrl-/) |
| Packet List Pane | Real-time list of captured packets with colour coding |
| Packet Details Pane | Expandable protocol layers for selected packet |
| Packet Bytes Pane | Raw hex and ASCII data of selected packet |
| Capture Interfaces Panel | Lists available interfaces with live traffic activity graphs |
| Statistics Menu | Located in the menu bar, 5th item from the left |

**Wireshark Version:** 4.6.4

## Exercise 2: Capturing Traffic — GUI vs tshark
**Wireshark GUI:**
- Visual, user-friendly interface with real-time colour-coded packet display
- Three-pane layout: Packet List, Packet Details, Packet Bytes
- Easy to click and inspect individual packets interactively
- Captured 202 packets including ARP, TCP, HTTP, BROWSER, and ICMPv6 traffic

**tshark (Terminal):**
- Command-line based, outputs packets as plain text line by line
- Captured 18 packets during a 30-second session on eth0
- Less visual but useful for scripting, automation, and remote/headless environments

**Key Difference:** Wireshark is better for interactive visual analysis; tshark is better for automation and remote capture scenarios.

## Exercise 3: Display Filter Analysis
| Filter | Packets Captured |
|--------|-----------------|
| `http` | 2 |
| `dns` | 4 |
| `tcp` | 40 |
| `ip.addr == 192.168.5.130` | Mixed protocols |

**Specific IP Addresses Identified:**
| IP Address | Role |
|------------|------|
| 192.168.5.130 | OWASP Broken Web Applications VM |
| 192.168.5.139 | Kali Linux (attacker machine) |
| 192.168.5.2 | DNS Server / Default Gateway |
| 192.168.5.254 | VMware DHCP Server |

## Exercise 4: Packet Details — Packet 136
| Field | Value |
|-------|-------|
| Source IP | 192.168.5.139 (Kali Linux) |
| Destination IP | 192.168.5.130 (OWASP VM) |
| Protocol | TCP |
| Source Port | 43296 |
| Destination Port | 80 (HTTP) |
| TCP Flag | SYN (0x002) — initiating connection |
| Frame Size | 74 bytes (592 bits) |
| TTL | 64 |
| Capture Time | May 22, 2026 06:45:08 WAT |

**Protocol Layers Observed:**
- Frame — physical capture metadata
- Ethernet II — MAC addresses of both VMware interfaces
- Internet Protocol Version 4 — source/destination IPs, TTL, no fragmentation
- Transmission Control Protocol — SYN flag set, Seq: 0, Window size: 64240

## Exercise 5: TCP Stream Analysis
**Session:** Kali Linux (192.168.5.139) → OWASP VM (192.168.5.130) on port 80

**Client Request (red):**
- GET / HTTP/1.1
- Host: 192.168.5.130
- User-Agent: curl/8.19.0
- Accept: */*

**Server Response (blue):**
- HTTP/1.1 200 OK
- Server: Apache/2.2.14 (Ubuntu) with PHP 5.3.2, mod_python, OpenSSL
- Content-Type: text/html
- Content-Length: 28,067 bytes
- Returned the full OWASP Broken Web Applications homepage HTML

**Stream Stats:** 1 client packet, 16 server packets, 28 KB total conversation

## Exercise 6: Protocol Hierarchy
| Protocol | Packets | % of Traffic |
|----------|---------|-------------|
| ARP | 63 | 31.2% |
| UDP | 89 | 44.1% |
| TCP | 40 | 19.8% |
| ICMPv6 | 7 | 3.5% |
| ICMP | 3 | 1.5% |

**UDP Breakdown:**
| Sub-Protocol | Packets |
|--------------|---------|
| NetBIOS Name Service | 35 |
| NTP | 31 |
| SMB/Browser | 12 |
| DHCP | 7 |
| DNS | 4 |

**Most Prevalent Protocol: UDP (44.1%)** — driven mainly by NetBIOS name registrations and NTP clock synchronisation traffic from the OWASP VM.

## Exercise 7: IO Graph Analysis
**Graph:** All Packets over time (1 second intervals)

**Patterns Observed:**
| Time Period | Activity |
|-------------|----------|
| 0–100s | Very low background traffic, occasional ARP broadcasts |
| ~125s | Large spike (~43 packets/sec) — curl HTTP session to OWASP VM |
| 130–160s | Moderate activity settling after HTTP data transfer |
| ~225s | Second spike (~35 packets/sec) — tshark capture session |
| 160–320s | Low background traffic, periodic ARP and NetBIOS |

**Key Observations:**
- Two clear traffic spikes corresponding to deliberate network activity
- Background traffic mostly flat with periodic ARP broadcasts
- No TCP Errors detected throughout the capture

## Exercise 8: Exported Capture File
- **Filename:** Lab5_capture.pcap
- **Location:** ~/Kali-Linux-Security-Labs/INT302/
- **Format:** Wireshark/tcpdump pcap

**Scenario for future review:** If the OWASP VM was suspected of communicating with an unauthorised external server, this pcap file could be reopened in Wireshark for forensic examination — identifying suspicious connections, extracting HTTP payloads, or sharing with another analyst without needing to recreate the capture session.

## Exercise 9: Real-World Troubleshooting Scenario
**Scenario:** A user reports that a web application hosted on a company server is loading slowly or timing out intermittently.

**Wireshark Approach:**
- Capture traffic between the client and server on the relevant interface
- Filter by server IP using `ip.addr == <server IP>`
- Look for excessive TCP retransmissions indicating packet loss
- Check for duplicate ACKs signalling network congestion
- Identify TCP Zero Window packets indicating the server buffer is full
- Measure response times between SYN and SYN-ACK to identify latency

**Symptoms to Investigate:**
- High number of retransmitted packets
- Long delays between HTTP request and response
- Connection resets (RST flags)
- Incomplete TCP handshakes (SYN with no SYN-ACK)

## Exercise 10: Security Threat Analysis
**Threat 1: Unencrypted HTTP Traffic**
- **Packets:** 141 (GET request) and 173 (200 OK response)
- **Indicator:** Full HTTP session transmitted in plaintext over port 80
- **Risk:** A Man-in-the-Middle (MITM) attacker could intercept, read, or modify all data exchanged between client and server since no encryption (HTTPS) was in use
- **Evidence:** Complete HTML source code of the OWASP web application was fully visible in the TCP stream follow

**Threat 2: Excessive ARP Broadcasting**
- **Packets:** 63 ARP broadcast packets (31.2% of all captured traffic)
- **Indicator:** Repeated `Who has 192.168.5.2? Tell 192.168.5.1` broadcasts from a single source
- **Risk:** Could indicate ARP spoofing/poisoning where an attacker floods the network with fake ARP replies to redirect traffic through their machine for interception
- **Evidence:** Unusually high volume of ARP packets from a single MAC address (VMware_c0:00:08) throughout the entire capture session

## Tools Used
- Wireshark 4.6.4
- tshark (terminal-based Wireshark)
- curl 8.19.0
