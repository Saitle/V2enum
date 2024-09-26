# V1enum

![Cybersecurity Script in Action](./v1.png)

## Overview

This script is designed for **automated subdomain enumeration**, combining multiple reconnaissance tools to help cybersecurity professionals, penetration testers, and bug bounty hunters uncover valuable subdomains. It provides a **comprehensive and efficient** workflow, generating a consolidated list of subdomains from various sources. With the use of tools like `subfinder`, `assetfinder`, `sublist3r`, `crt.sh`, `shosubgo`, and `asnmap`, this script saves time and effort by aggregating results in one file.

## Key Features
- **Multi-Tool Integration**: Uses popular subdomain enumeration tools for a wide-reaching scan.
- **Streamlined Output**: Merges and de-duplicates results into a single file.
- **Easy to Extend**: Designed as a base model, it is primed for future development with new tools and features.
- **Built for Automation**: Fully automated execution with minimal user input.

## Tools Used
- `subfinder` – Quickly discovers subdomains using passive sources.
- `assetfinder` – Finds subdomains related to the given domain.
- `sublist3r` – Searches across multiple search engines for subdomains.
- `crt.sh` – Retrieves subdomains from SSL certificate transparency logs.
- `shosubgo` – Queries Shodan API for additional subdomain information.
- `asnmap` – Provides subdomain enumeration based on ASN data.
- `tlsx` – Helps with TLS information extraction during ASN mapping.

## Requirements
Before running the script, ensure that the following tools are installed and available in your system's `$PATH`:
- `subfinder`
- `assetfinder`
- `sublist3r`
- `curl`
- `jq`
- `asnmap`
- `tlsx`
- `shosubgo` (set the correct path to your executable)

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Saitle/V1enum.git
   cd V1enum

