# Lab 4: Basic Port Scanning Report

## Target Information
- **IP Address:** 192.168.5.130
- **Target:** OWASP Broken Web Applications VM
- **Date:** May 21, 2026

## Exercise 1: Open Ports
| Port | Service |
|------|---------|
| 22/tcp | SSH |
| 80/tcp | HTTP |
| 139/tcp | NetBIOS |
| 143/tcp | IMAP |
| 443/tcp | HTTPS |
| 445/tcp | SMB |
| 5001/tcp | commplex-link |
| 8080/tcp | HTTP Proxy |
| 8081/tcp | BlackIce |

## Exercise 2: Service Versions and OS
| Port | Service | Version |
|------|---------|---------|
| 22 | SSH | OpenSSH 5.3p1 |
| 80 | HTTP | Apache 2.2.14 + PHP 5.3.2 |
| 139/445 | SMB | Samba 3.X - 4.X |
| 143 | IMAP | Courier Imapd 2008 |
| 8080 | HTTP | Apache Tomcat 1.1 |
| 8081 | HTTP | Jetty 6.1.25 |

**Operating System:** Linux kernel 2.6.17 - 2.6.36 (Ubuntu)

## Exercise 3: Vulnerabilities (nmap)
| Vulnerability | CVE | Severity |
|--------------|-----|---------|
| Apache ByteRange DoS | CVE-2011-3192 | High |
| SSL POODLE | CVE-2014-3566 | High |
| SSL CCS Injection | CVE-2014-0224 | High |
| Weak Diffie-Hellman Key | N/A | Medium |
| Slowloris DoS | CVE-2007-6750 | High |
| Cross-domain misconfiguration | N/A | Medium |
| CSRF vulnerabilities | N/A | Medium |
| Internal IP disclosure | N/A | Low |

## Exercise 4: Vulnerabilities (nikto)
- Apache 2.2.14 outdated — remote buffer overflow possible
- PHP 5.3.2 End of Life — no security updates
- OpenSSL 0.9.8k outdated
- TRACE method enabled — XST vulnerable
- Missing security headers (CSP, HSTS, X-Content-Type-Options)
- Directory indexing exposed (/icons/, /cgi-bin/, /test/, /images/)
- phpMyAdmin publicly accessible
- WordPress login page exposed
- Internal IP 127.0.1.1 leaked in headers
- Flash crossdomain.xml allows all domains

## Tools Used
- nmap 7.99
- nikto 2.6.0
