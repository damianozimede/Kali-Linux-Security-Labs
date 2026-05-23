# Lab 6: Advanced Packet Analysis Report
## Target Information
- **IP Address:** 192.168.5.130
- **Target:** OWASP Broken Web Applications VM
- **Capture Interface:** eth0
- **Date:** May 23, 2026

## Exercise 1: TCP Flag Analysis
**Purpose of SYN and ACK flags in the TCP handshake:**

| Packet | Flags | Direction | Meaning |
|--------|-------|-----------|---------|
| 136 | SYN | Kali → OWASP | Client requests to open a connection |
| 139 | SYN, ACK | OWASP → Kali | Server agrees and acknowledges the request |
| 140 | ACK | Kali → OWASP | Client confirms — connection established |

**SYN flag:** Synchronises sequence numbers between client and server to initiate a new connection. When set, it signals the start of a TCP session.

**ACK flag:** Acknowledges receipt of data. Once the handshake is complete, every subsequent packet has ACK set, confirming that data is being received successfully.

## Exercise 2: HTTP Packet Analysis
**Packet 141 — HTTP Request:**

| Field | Value |
|-------|-------|
| Request Method | GET |
| Request URI | http://192.168.5.130/ |
| HTTP Version | HTTP/1.1 |
| Host | 192.168.5.130 |
| User-Agent | curl/8.19.0 |
| Accept | */* |
| Response (Packet 173) | HTTP/1.1 200 OK (text/html) |

**Inference:** This was a simple HTTP GET request made by curl from Kali Linux to the OWASP web server. The server responded with a 200 OK status. The transaction was completely unencrypted — all headers and response content are visible in plain text, which is a significant security risk.

## Exercise 3: DNS Query and Response Analysis
**Query (Packet 46):**

| Field | Value |
|-------|-------|
| Source | 192.168.5.130 (OWASP VM) |
| Destination | 192.168.5.2 (DNS Server) |
| Query Type | A (IPv4 address lookup) |
| Domain Queried | ntp.ubuntu.com |
| Transaction ID | 0x117a |
| Questions | 1 |
| Answer RRs | 0 (no answer yet) |

**Response (Packet 47):**

| Field | Value |
|-------|-------|
| Source | 192.168.5.2 (DNS Server) |
| Destination | 192.168.5.130 (OWASP VM) |
| Transaction ID | 0x117a (matches query) |
| Status | No error |
| Answer RRs | 4 (four IP addresses returned) |
| Resolved IPs | 185.125.190.58, 91.189.91.157, 185.125.190.56 + 1 more |
| Response Time | 31.26 milliseconds |

**Structure:** The DNS response uses the same Transaction ID as the query to match them together. It returned 4 A records for ntp.ubuntu.com for load balancing purposes.

## Exercise 4: Custom Filter
**Filter syntax used:**
tcp and ip.src == 192.168.5.139 and ip.dst == 192.168.5.130

**Packets captured:**

| Packet | Info |
|--------|------|
| 136 | SYN — initiating connection |
| 140 | ACK — completing handshake |
| 141 | HTTP GET / HTTP/1.1 |
| 144-172 | ACK packets acknowledging data received from server |

**Observation:** The filter successfully isolated client-side packets only, filtering out all ARP, DNS, NTP and server-side response packets.

## Exercise 5: Filter by Port
**Filter syntax used:**
tcp.port == 80

**Packets captured:**

| Packet | Direction | Info |
|--------|-----------|------|
| 136 | Kali to OWASP | SYN — connection initiated |
| 139 | OWASP to Kali | SYN, ACK — connection accepted |
| 140 | Kali to OWASP | ACK — handshake complete |
| 141 | Kali to OWASP | HTTP GET / HTTP/1.1 |
| 142-155+ | OWASP to Kali | ACK and data packets delivering HTML response |

**Difference from Exercise 4:** This filter catches traffic in both directions, while Exercise 4 only showed one direction using specific IPs.

## Exercise 6: Anomaly Detection
**Anomaly 1: Excessive ARP Broadcasting**
- **Indicator:** Single MAC address (VMware_c0:00:08) repeatedly broadcasting "Who has 192.168.5.2?" — 63 ARP packets making up 31.2% of all traffic
- **Risk:** Consistent with ARP poisoning/spoofing where an attacker floods the network with ARP requests to intercept traffic
- **Remediation:** Implement Dynamic ARP Inspection (DAI) on network switches, use static ARP entries for critical hosts, and monitor for unusually high ARP broadcast rates

**Anomaly 2: Unencrypted HTTP Traffic**
- **Indicator:** Packets 141 and 173 show a complete HTTP session in plaintext including full HTML content
- **Risk:** Any sensitive data transmitted over HTTP is visible to anyone on the network
- **Remediation:** Enforce HTTPS across all web services, implement HSTS, and redirect all HTTP traffic to HTTPS

## Exercise 7: HTTPS/TLS Traffic Analysis
**TLS Handshake Packets:**

| Packet | Info |
|--------|------|
| 11 | Client Hello — Kali initiates TLS connection, advertises supported cipher suites |
| 16 | Server Hello — Server responds, selects cipher suite, sends certificate |
| 18 | Change Cipher Spec — both sides switch to encrypted communication |
| 20+ | Application Data — all actual data fully encrypted and unreadable |

**What is exchanged during the handshake:**
- Client advertises supported TLS version (TLSv1.3) and cipher suites
- Server selects the strongest mutually supported cipher suite
- Digital certificates exchanged to verify server identity
- Encryption keys negotiated securely

**How it contributes to security:**
- All Application Data packets are fully encrypted and unreadable
- Server identity verified through certificates preventing MITM attacks
- Communication over port 443 instead of port 80

## Exercise 8: Security Assessment
**Scope:** Network traffic captured on eth0 between Kali Linux (192.168.5.139) and OWASP VM (192.168.5.130)

**Findings:**

| Risk | Description | Severity |
|------|-------------|----------|
| Unencrypted HTTP | Web traffic sent in plaintext over port 80 | High |
| Excessive ARP Broadcasting | 63 ARP broadcasts from single MAC address | Medium |
| Outdated Server Software | Apache 2.2.14, PHP 5.3.2, OpenSSL 0.9.8k all end-of-life | High |
| No HTTPS enforcement | Server accepts HTTP without redirecting to HTTPS | High |

**Recommended Actions:**
- Immediately enforce HTTPS and disable HTTP on port 80
- Implement HSTS to prevent protocol downgrade attacks
- Update Apache, PHP, and OpenSSL to current supported versions
- Enable Dynamic ARP Inspection on network switches
- Monitor ARP traffic for unusual broadcast volumes

## Exercise 9: Capture Report
**Objectives:**
- Analyse captured network traffic using Wireshark and tshark
- Dissect TCP, HTTP, DNS and TLS protocols
- Create and apply custom display filters
- Identify security vulnerabilities in network traffic
- Compare encrypted vs unencrypted traffic

**Methods:**
- Loaded Lab5_capture.pcap containing 202 packets captured on eth0
- Applied display filters to isolate specific protocols (tcp, http, dns, arp, tls)
- Used Display Filter Expression dialog to construct complex filters
- Followed TCP streams to analyse full conversations
- Generated fresh HTTPS traffic to example.com for TLS analysis

**Key Findings:**
- HTTP traffic between Kali and OWASP VM was completely unencrypted — full HTML content visible in plain text
- 63 ARP broadcast packets (31.2% of traffic) from a single source — potential ARP poisoning indicator
- DNS queries for ntp.ubuntu.com revealed OWASP VM communicating with external NTP servers
- TLS 1.3 traffic to example.com was fully encrypted — application data unreadable confirming effectiveness of HTTPS
- OWASP VM running outdated software stack (Apache 2.2.14, PHP 5.3.2, OpenSSL 0.9.8k)

**Recommendations:**
- Enforce HTTPS across all web services and disable plain HTTP
- Implement Dynamic ARP Inspection to prevent ARP spoofing
- Update all server software to current supported versions
- Monitor network traffic regularly for anomalies using Wireshark or tshark
- Use TLS 1.3 as minimum standard for all encrypted communications

## Tools Used
- Wireshark 4.6.4
- tshark (terminal-based Wireshark)
- curl 8.19.0
