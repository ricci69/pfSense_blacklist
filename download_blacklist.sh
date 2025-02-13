#!/bin/bash

set -e  # Interrompe lo script in caso di errore

# Array con le URL delle blacklist
#blacklists=("https://ftp.ntct.edu.tw/pfSense/abuse.txt" "https://ftp.ntct.edu.tw/pfSense/badguys.txt" "https://ftp.ntct.edu.tw/pfSense/block.txt" "https://ftp.ntct.edu.tw/pfSense/newest_ip.txt" "https://ftp.ntct.edu.tw/pfSense/repeated_ip.txt")
blacklists=("https://ftp.ntct.edu.tw/pfSense/TANet.txt" "https://ftp.ntct.edu.tw/pfSense/GSNNET.txt")

# File temporaneo per il download
temp_file="blacklist.tmp"
output_file="blacklist.txt"

# Rimuove il file temporaneo se esiste
rm -f "$temp_file"

# Scarica le blacklist
for url in "${blacklists[@]}"; do
    echo "Scaricando da: $url"
    if curl -sS --fail "$url" >> "$temp_file"; then
        echo "Download riuscito."
    else
        echo "Errore durante il download da $url" >&2
    fi
done

# Verifica che il file non sia vuoto prima di sostituire quello originale
if [ -s "$temp_file" ]; then
    mv "$temp_file" "$output_file"
    echo "Blacklist aggiornata con successo."
else
    echo "Errore: Nessun dato scaricato. La blacklist non è stata aggiornata." >&2
    rm -f "$temp_file"
    exit 1
fi
