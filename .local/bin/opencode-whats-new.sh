#!/bin/bash

# File to store the oldest version (persists through restarts)
VERSION_FILE="$HOME/.local/share/opencode/oldest-version.txt"

# Get the newest version from opencode --version
NEWEST=$(opencode --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)

# Check if we got a valid version
if [ -z "$NEWEST" ]; then
  echo "Error: Could not get version from opencode --version"
  exit 1
fi

# Add 'v' prefix to newest version
NEWEST_TAG="v$NEWEST"

# Check if version file exists
if [ ! -f "$VERSION_FILE" ]; then
  # First run - create the file with current version
  mkdir -p "$(dirname "$VERSION_FILE")"
  echo "$NEWEST_TAG" >"$VERSION_FILE"
  echo "Already up to date (first run - version file initialized)"
  exit 0
fi

# Read the oldest version from the file
OLDEST=$(cat "$VERSION_FILE" 2>/dev/null | tr -d '[:space:]')

# Check if oldest version is empty
if [ -z "$OLDEST" ]; then
  echo "$NEWEST_TAG" >"$VERSION_FILE"
  echo "Already up to date (version file was empty)"
  exit 0
fi

# Check if versions are the same
if [ "$OLDEST" = "$NEWEST_TAG" ]; then
  echo "Already up to date"
  exit 0
fi

# Fetch release notes between oldest and newest
gh api repos/anomalyco/opencode/releases --jq "[.[] | {tag: .tag_name, body: .body}] | map(select(.tag >= \"$OLDEST\" and .tag <= \"$NEWEST_TAG\"))"

# Update the version file with the newest version
echo "$NEWEST_TAG" >"$VERSION_FILE"
