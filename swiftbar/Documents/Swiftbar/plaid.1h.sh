#!/usr/bin/env bash

# <xbar.title>IPO Odds</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Dana Merrick</xbar.author>
# <xbar.author.github>dmerrick</xbar.author.github>
# <xbar.desc>Displays the current market‑implied probability that a company will announce an IPO on Kalshi.</xbar.desc>
# <xbar.dependencies>bash,curl,jq</xbar.dependencies>

# Name of the market ticker to query
market_ticker="KXIPO-26-PLAID"

# Base URL for Kalshi's public market API.  No API key is required for this endpoint.
api_url="https://api.elections.kalshi.com/trade-api/v2/markets/${market_ticker}"

# Fetch the market data and extract the last trade price. Kalshi now returns
# this as last_price_dollars (a string in dollars, e.g. "0.0700"); multiply by
# 100 to get the implied probability as a whole-number percent.
last_price=$(curl -s "$api_url" \
  | jq -r '.market.last_price_dollars | select(. != null) | (tonumber * 100 | round)' 2>/dev/null)

# If jq failed to extract a number, set a default message.
if [[ -z "$last_price" || "$last_price" == "null" ]]; then
  echo "N/A"
  exit 0
fi

# Append a percent sign to the numeric value for display in the menu bar.
echo "${last_price}%"

# Lines below the separator (---) will appear in the plugin's dropdown menu.
echo "---"
echo "View on Kalshi | href=https://kalshi.com/markets/kxipo/ipos/kxipo-26"
echo "Refresh now | refresh=true"
