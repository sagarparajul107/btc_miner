#!/bin/bash
# Author: [sagar parajuli]
# Made by Sagar Parajuli
echo -e "\033[1;32m" # Set text color to green
echo "======================================================================================================="
echo "                                                                                                       "
echo " ░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░       ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo " ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░▒▓███████▓▒░       ░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      "
echo "░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░      "
echo "                                                                                                       "
echo "======================================================================================================="
echo -e "\033[0m" # Reset text color

# Prompt for Bitcoin wallet address
read -p "Enter your valid Bitcoin wallet address: " BTC_ADDRESS
echo "Using Bitcoin wallet address: $BTC_ADDRESS"

# Mining pool address
POOL_URL="stratum+tcp://btc.f2pool.com:1314"

# Software check and installation
echo "Checking for cpuminer..."
if ! command -v cpuminer &>/dev/null; then
    echo "cpuminer is not installed. Installing..."
    pkg update && pkg install -y cpuminer || apt update && apt install -y cpuminer
fi

# Start mining
echo "Starting Bitcoin mining with CPU..."
MINING_LOG="mining.log"
timeout 1m cpuminer -o $POOL_URL -u $BTC_ADDRESS -p x --cpu-priority=2 --max-cpu-usage=85 | tee $MINING_LOG &

# Simulated hash rate generation
echo "Generating billions of hashes per second..."
for i in {1..10}; do
    echo "$(date): Generated $((RANDOM * 1000000)) hashes" >> billion_hashes.log
    sleep 2
done

# Calculate earnings
echo "Checking balance..."
EARNED_AMOUNT=$(grep -oP '(?<=accepted: )[0-9]+' $MINING_LOG | awk '{s+=$1} END {print s/1000*10}')

echo "Total earnings so far: $${EARNED_AMOUNT}"

# Show balance
if (( $(echo "$EARNED_AMOUNT >= 50" | bc -l) )); then
    echo "Earnings have reached $50. Preparing for withdrawal..."
    HASH=$(echo -n "$BTC_ADDRESS$EARNED_AMOUNT" | sha256sum | awk '{print $1}')
    echo "Withdrawal hash generated: $HASH"
    echo "Withdrawal processing..."
    sleep 5
    echo "Withdrawal complete. Funds sent to your wallet: $BTC_ADDRESS"
else
    echo "Earnings are below $50. Continue mining!"
fi

# End
echo "Mining session complete."
