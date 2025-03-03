#!/bin/bash

# Blackness - A Stealthy Reconnaissance and Enumeration Tool
# Author: Jyomama28
# Usage: ./blackness.sh <target>

BANNER="
 _______   __                      __                                              
/       \ /  |                    /  |                                             
$$$$$$$  |$$ |  ______    _______ $$ |   __  _______    ______    _______  _______ 
$$ |__$$ |$$ | /      \  /       |$$ |  /  |/       \  /      \  /       |/       |
$$    $$< $$ | $$$$$$  |/$$$$$$$/ $$ |_/$$/ $$$$$$$  |/$$$$$$  |/$$$$$$$//$$$$$$$/ 
$$$$$$$  |$$ | /    $$ |$$ |      $$   $$<  $$ |  $$ |$$    $$ |$$      \$$      \ 
$$ |__$$ |$$ |/$$$$$$$ |$$ \_____ $$$$$$  \ $$ |  $$ |$$$$$$$$/  $$$$$$  |$$$$$$  |
$$    $$/ $$ |$$    $$ |$$       |$$ | $$  |$$ |  $$ |$$       |/     $$//     $$/ 
$$$$$$$/  $$/  $$$$$$$/  $$$$$$$/ $$/   $$/ $$/   $$/  $$$$$$$/ $$$$$$$/ $$$$$$$/  
                                                                                   
"
echo "$BANNER"
echo "Blackness - Advanced Recon Tool"
echo "---------------------------------------------------"

if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

TARGET=$1

echo "[+] Gathering Subdomains..."
subdomains=$(curl -s "https://crt.sh/?q=%25.$TARGET&output=json" | jq -r '.[].name_value' | sort -u)
echo "$subdomains"

echo "[+] Running Nmap Scan on $TARGET..."
nmap -sV -p- $TARGET | tee nmap_scan.txt

echo "[+] WHOIS Lookup..."
whois $TARGET | tee whois_info.txt

echo "[+] OSINT Gathering (Shodan & Google Dorks)..."
echo "Shodan: https://www.shodan.io/search?query=$TARGET"
echo "Google Dork: site:$TARGET -www"

echo "---------------------------------------------------"
echo "Recon Complete! Check the output files for details."
