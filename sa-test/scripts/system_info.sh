#!/usr/bin/env bash
echo "=== Süsteemi info ==="

echo "Hostname: $(hostname)"
echo "Kasutaja: $(whoami)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
echo "Mälu kokku: $(free -m | awk '/Mem:/ {print $2}') MB"
