"""
Helper script to incrementally build the Practical_8.ipynb notebook.
This script adds cells to the notebook one section at a time.
"""

import json
import os

def load_notebook(filepath='Practical_8.ipynb'):
    """Load existing notebook or create new one."""
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)
    else:
        return {
            'cells': [],
            'metadata': {
                'kernelspec': {
                    'display_name': 'Python 3',
                    'language': 'python',
                    'name': 'python3'
                },
                'language_info': {
                    'name': 'python',
                    'version': '3.8.0'
                }
            },
            'nbformat': 4,
            'nbformat_minor': 4
        }

def save_notebook(nb, filepath='Practical_8.ipynb'):
    """Save notebook to file."""
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(nb, f, indent=2, ensure_ascii=False)
    print(f"✓ Saved notebook to {filepath}")

def add_markdown_cell(nb, content):
    """Add a markdown cell to the notebook."""
    cell = {
        'cell_type': 'markdown',
        'metadata': {},
        'source': content if isinstance(content, list) else [content]
    }
    nb['cells'].append(cell)
    return nb

def add_code_cell(nb, code, outputs=None):
    """Add a code cell to the notebook."""
    cell = {
        'cell_type': 'code',
        'execution_count': None,
        'metadata': {},
        'outputs': outputs if outputs else [],
        'source': code if isinstance(code, list) else [code]
    }
    nb['cells'].append(cell)
    return nb

if __name__ == "__main__":
    print("Notebook builder helper loaded successfully!")
    print("Use this script to incrementally build Practical_8.ipynb")
