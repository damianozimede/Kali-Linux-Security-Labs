# Security Reconnaissance Report

## Executive Summary
**Target**: github.com  
**Assessment Date**: May 20, 2026  
**Scope**: Passive information gathering  
**Overall Risk Level**: Low

## 1. Target Overview
- **Domain**: github.com
- **IP Address**: 140.82.121.3
- **Registrar**: CSC Corporate Domains Inc.
- **Registration Date**: January 29, 2007
- **Expiration Date**: January 29, 2027

## 2. Network Infrastructure
### 2.1 IP Addresses
- Primary: 140.82.121.3

### 2.2 Network Performance
- Average Response Time: N/A
- Packet Loss: 100% (ICMP blocked)

## 3. DNS Configuration
### 3.1 Name Servers
- dns1-4.p08.nsone.net
- ns-1283.awsdns-32.org
- ns-1707.awsdns-21.co.uk
- ns-421.awsdns-52.com
- ns-520.awsdns-01.net

### 3.2 Mail Servers
- github-com.mail.protection.outlook.com - Priority 0

### 3.3 Security Records
- SPF: Present
- DKIM: Selector unknown (not publicly discoverable)
- DMARC: Present

## 4. Subdomain Analysis
### 4.1 Discovered Subdomains
- smtp.github.com (Mail)
- api.github.com (API)
- gist.github.com (Code sharing)
- pages.github.com (Hosting)

## 5. Security Observations
### 5.1 Strengths
- ICMP ping blocked at firewall level
- Uses both NS1 and AWS DNS for redundancy
- M
