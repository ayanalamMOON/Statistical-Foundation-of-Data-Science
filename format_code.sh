#!/bin/bash
# Helper script to format code using black from venv
#
# USAGE:
#   ./format_code.sh [path] [--install-jupyter]
#
# EXAMPLES:
#   ./format_code.sh                              # Format all files in current directory
#   ./format_code.sh "Practical Assignments"      # Format specific directory
#   ./format_code.sh --install-jupyter            # Install Jupyter support first
#   ./format_code.sh "Assignment 4" --install-jupyter
#
# FEATURES:
#   - Formats Python files (.py)
#   - Formats Jupyter notebooks (.ipynb)
#   - Excludes .venv, __pycache__, .git, .ipynb_checkpoints
#   - Auto-installs Jupyter support when needed
#
# FIRST TIME SETUP:
#   Run with --install-jupyter flag to enable notebook formatting

cd "$(dirname "$0")"

# Check for install flag
if [ "$1" == "--install-jupyter" ] || [ "$2" == "--install-jupyter" ]; then
    echo "Installing Black with Jupyter support..."
    source .venv/Scripts/activate
    pip install "black[jupyter]"
    echo "Installation complete!"
    echo ""
fi

# Path to format (default to current directory if not provided)
if [ "$1" == "--install-jupyter" ]; then
    TARGET_PATH="."
else
    TARGET_PATH="${1:-.}"
fi

echo "============================================"
echo "Code Formatting with Black"
echo "============================================"
echo "Target: $TARGET_PATH"
echo ""

# Check if black is available
if [ ! -f ".venv/Scripts/black.exe" ]; then
    echo "Error: Black formatter not found in virtual environment"
    echo "Please run: pip install black"
    exit 1
fi

# Format Python files and Jupyter notebooks
echo "1. Formatting Python files (.py)..."
.venv/Scripts/black.exe "$TARGET_PATH" --exclude="\.venv|venv|__pycache__|\.git|\.ipynb_checkpoints"

echo ""
echo "2. Formatting Jupyter notebooks (.ipynb)..."
JUPYTER_OUTPUT=$(.venv/Scripts/black.exe "$TARGET_PATH" --include="\.ipynb$" --exclude="\.venv|venv|__pycache__|\.git|\.ipynb_checkpoints" 2>&1)

if echo "$JUPYTER_OUTPUT" | grep -q "Jupyter dependencies are not installed"; then
    echo "Note: Jupyter support not installed for Black"
    echo "To format .ipynb files, run: ./format_code.sh --install-jupyter"
    echo "Or manually: pip install \"black[jupyter]\""
else
    echo "$JUPYTER_OUTPUT"
fi

echo ""
echo "============================================"
echo "Formatting complete!"
echo "============================================"
