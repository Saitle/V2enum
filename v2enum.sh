#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -d domain"
    exit 1
}

# Check if required tools are installed
check_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 could not be found. Please install it to continue."
        exit 1
    fi
}

# Parse command line arguments
while getopts ":d:" opt; do
    case $opt in
        d)
            DOMAIN=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Check if the domain was provided
if [ -z "$DOMAIN" ]; then
    echo "Domain not provided."
    usage
fi

# Ensure required tools are installed
tools=("subfinder" "assetfinder" "sublist3r" "curl" "jq" "asnmap" "tlsx" "shosubgo")
for tool in "${tools[@]}"; do
    check_tool "$tool"
done

# Define the output file
OUTPUT_FILE="${DOMAIN}_subdomains.txt"

# Perform subdomain enumeration
echo "Running subfinder..."
subfinder -d "$DOMAIN" >> "$OUTPUT_FILE"
sleep 2

echo "Running assetfinder..."
assetfinder -subs-only "$DOMAIN" >> "$OUTPUT_FILE"
sleep 2

echo "Running sublist3r..."
sublist3r -d "$DOMAIN" | grep -oE '([a-zA-Z0-9]+\.){1,}[a-zA-Z]{2,}' >> "$OUTPUT_FILE"
sleep 2

echo "Running crt.sh..."
curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | jq -r '.[].name_value' | tr '\n' '\n' | sort -u >> "$OUTPUT_FILE"
sleep 3

echo "Running shosubgo..."
shosubgo -d "$DOMAIN" -s '<shodan_api_key>' >> "$OUTPUT_FILE"
sleep 2

echo "Enumerating ASNs"
echo "$asn" | asnmap -silent | tlsx -san -cn -silent -resp-only >> "$OUTPUT_FILE"

# Remove duplicate entries
sort -u "$OUTPUT_FILE" -o "$OUTPUT_FILE"

echo "Subdomain enumeration completed. Results saved to ${OUTPUT_FILE}"
