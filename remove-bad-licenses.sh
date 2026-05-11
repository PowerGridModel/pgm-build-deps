# SPDX-FileCopyrightText: Contributors to the Power Grid Model project <powergridmodel@lfenergy.org>
#
# SPDX-License-Identifier: MPL-2.0

#!/bin/bash


# Find the SPDX JSON file
SPDX_FILE=$(find . -name "*spdx*.json" -o -name "sbom*.json" -o -name "*sbom.json"| head -1)

if [ -z "$SPDX_FILE" ]; then
  echo "No SPDX JSON file found! Fossology scan may have failed."
  echo "Available files:"
  find . -name "*.json" || echo "No JSON files found"
  exit 1
fi
echo "Found SPDX file: $SPDX_FILE"

# Get badly licensed files (excluding .git and .github directories)
echo "Extracting and deduplicating badly licensed files..."
BAD_FILES=$(jq -r '
  [.files[] | 
   select(.licenseInfoInFiles[]? | type == "string" and test("GPL"; "i")) | 
   select(.fileName | test("^\\.git/") | not) |
   select(.fileName | test("^\\.github/") | not) |
   .fileName] | 
  unique | 
  .[]
' "$SPDX_FILE")

if [ -z "$BAD_FILES" ]; then
  echo "No badly licensed files found - nothing to delete!"
else
  echo "Badly licensed files found:"
  echo "$BAD_FILES" | while read -r file_name; do
    if [ -n "$file_name" ]; then
      echo " - $file_name"
      
      if [ -f "$file_name" ]; then
        rm -f "$file_name"
        echo "Deleted: $file_name"
      else
        echo "File not found: $file_name"
        exit 1
      fi
    fi
  done
fi
