#!/usr/bin/env python3
"""
Script to fix Unicode characters in the Jupyter notebook for better LaTeX compatibility.
"""
import json
import sys
import os

def fix_unicode_in_notebook(notebook_path):
    """Fix Unicode characters in notebook cells"""

    # Read the notebook
    with open(notebook_path, 'r', encoding='utf-8') as f:
        notebook = json.load(f)

    # Unicode replacements for better LaTeX compatibility
    replacements = {
        '✓': '[CHECK]',
        '✗': '[CROSS]',
        '₁': '_1',
        '₂': '_2',
        'ₙ': '_n',
        'ᵢ': '_i',
        'ⱼ': '_j',
    }

    changes_made = 0

    # Process each cell
    for cell in notebook['cells']:
        if 'source' in cell:
            for i, line in enumerate(cell['source']):
                original_line = line
                for unicode_char, replacement in replacements.items():
                    line = line.replace(unicode_char, replacement)

                if line != original_line:
                    cell['source'][i] = line
                    changes_made += 1

    if changes_made > 0:
        # Create backup
        backup_path = notebook_path + '.backup'
        if not os.path.exists(backup_path):
            import shutil
            shutil.copy2(notebook_path, backup_path)
            print(f"✅ Created backup: {backup_path}")

        # Write the modified notebook
        with open(notebook_path, 'w', encoding='utf-8') as f:
            json.dump(notebook, f, indent=2, ensure_ascii=False)

        print(f"✅ Fixed {changes_made} Unicode character instances in {notebook_path}")
        return True
    else:
        print("ℹ️  No Unicode characters found that need fixing")
        return False

if __name__ == "__main__":
    notebook_file = "Statistical_FDS_Assignment_1_Solutions.ipynb"

    if not os.path.exists(notebook_file):
        print(f"Notebook file {notebook_file} not found!")
        sys.exit(1)

    print(f"Checking {notebook_file} for Unicode characters...")

    if fix_unicode_in_notebook(notebook_file):
        print("🎉 Unicode fix completed! You can now run the PDF converter.")
    else:
        print("✅ Notebook is already compatible with LaTeX.")
