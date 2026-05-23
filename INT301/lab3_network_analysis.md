# INT301 Lab 3: Advanced Network Analysis and Troubleshooting

## Part 1: Comprehensive Network Discovery

### Exercise 1.1: ss vs netstat
- `ss` is newer, faster and more feature-rich than netstat
- `netstat` is older and being phased out but still widely used
- `ss` provides more detailed socket information and is recommended over netstat

### Exercise 1.2: Virtual interface connectivity test
Connectivity between virtual interfaces working perfectly.
- 4 packets transmitted, 4 received, 0% packet loss

## Part 2: Advanced Connectivity Testing

### Exercise 2.1: Flood ping results
- Flood ping sends packets as fast as possible (1000 packets in just 73ms)
- Useful for stress testing network interfaces and measuring maximum throughput
- Can detect packet loss under load
- Must be run as root/sudo for safety reasons

## Part 3: Network Service Analysis

### Exercise 3.1: Information from service banners
- HTTP banner revealed: Server type (gws = Google Web Server), date, security policies
- SSH banner reveals: SSH version, encryption algorithms supported
- This info helps identify: software versions, potential vulnerabilities, security misconfigurations

## Part 4: Advanced Traffic Analysis

### Exercise 4.1: tcpdump filter for DNS
Command: `sudo tcpdump -i eth0 port 53`
- Captures both DNS queries and responses
- Example: A? google.com (query) and A 142.250.74.78 (response)

## Part 5: DNS and Name Resolution

### Exercise 5.1: DNS response time comparison
- Local DNS resolver (192.168.5.2): 35 msec
- Google's public DNS (8.8.8.8): 75 msec
- Conclusion: Local DNS is faster because it caches results closer to you

## Challenge Exercises

### Challenge 1: Network Mapping
**Active hosts found on 192.168.5.0/24:**
- 192.168.5.1 (VMware)
- 192.168.5.2 (VMware - Gateway)
- 192.168.5.254 (VMware)
- 192.168.5.139 (Kali machine)
- Gateway (192.168.5.2) has port 53 open running dnsmasq 2.51

### Challenge 2: Traffic Analysis Report
- **Date:** May 9, 2026
- **Interface:** eth0
- **Packets Captured:** 50

**Top Protocols:**
1. ICMP - Ping requests/replies
2. DNS - Domain resolution queries
3. ARP - Address resolution between hosts

**Hosts Communicating:**
- 192.168.5.139 (Kali) ↔ 192.168.5.2 (Gateway)
- 192.168.5.139 (Kali) ↔ 142.251.140.238 (Google)

**Plaintext Credentials:** None found

### Challenge 3: DNS Investigation
- **IP addresses:** 216.239.34.10, 216.239.36.10, 216.239.38.10
- **Authoritative name servers:** ns1, ns2, ns3, ns4.google.com
- **DNS misconfigurations:** None found

### Challenge 4: Network Troubleshooting
- **Simulated issue:** Added iptables rule to block port 80 outbound traffic
- **Symptom:** curl connection timed out
- **Troubleshooting:** Identified blocked rule with `iptables -L`
- **Fix:** Removed rule with `iptables -D` then flushed with `iptables -F`
- **Verified:** HTTP traffic restored successfully
