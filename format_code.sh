#!/bin/bash
# Helper script to format code using black from venv
# Usage: ./format_code.sh [path]
# If no path provided, formats current directory

cd "$(dirname "$0")"

# Path to format (default to current directory if not provided)
TARGET_PATH="${1:-.}"

echo "Formatting Python code with black..."
echo "Target: $TARGET_PATH"
echo ""

# Use black from venv
.venv/Scripts/black.exe "$TARGET_PATH"

echo ""
echo "✓ Done!"
