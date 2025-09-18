#!/usr/bin/env python3
"""
Custom nbconvert script that handles MiKTeX update warnings gracefully.
"""
import subprocess
import sys
import os

def convert_notebook_to_pdf(notebook_path):
    """Convert notebook to PDF using custom nbconvert settings."""

    # First convert to LaTeX
    print("Converting notebook to LaTeX...")
    latex_cmd = [
        "jupyter", "nbconvert",
        "--to", "latex",
        notebook_path
    ]

    result = subprocess.run(latex_cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"LaTeX conversion failed: {result.stderr}")
        return False

    # Get the LaTeX file name
    base_name = os.path.splitext(notebook_path)[0]
    tex_file = f"{base_name}.tex"

    if not os.path.exists(tex_file):
        print(f"LaTeX file {tex_file} not found!")
        return False

    print(f"LaTeX file created: {tex_file}")

    # Compile LaTeX to PDF with custom settings
    print("Compiling LaTeX to PDF...")

    # Run XeLaTeX multiple times for proper cross-references
    pdf_file = f"{base_name}.pdf"
    all_passes_successful = True

    for i in range(3):
        print(f"XeLaTeX pass {i+1}/3...")
        latex_compile_cmd = [
            "xelatex",
            "-interaction=nonstopmode",
            tex_file
        ]

        result = subprocess.run(latex_compile_cmd, capture_output=True, text=True, cwd=os.path.dirname(os.path.abspath(tex_file)) or ".")

        # Check for critical errors (but continue with warnings)
        if result.returncode != 0 and "major issue" not in result.stderr:
            print(f"XeLaTeX pass {i+1} failed with critical error:")
            print("STDERR:", result.stderr)
            all_passes_successful = False
            break
        else:
            print(f"XeLaTeX pass {i+1} completed (warnings ignored)")

    # Check if PDF was created after all passes
    if os.path.exists(pdf_file) and all_passes_successful:
        print(f"PDF successfully created: {pdf_file}")

        # Get file size
        file_size = os.path.getsize(pdf_file)
        print(f"PDF file size: {file_size:,} bytes")

        # Check log file for issues
        log_file = f"{base_name}.log"
        if os.path.exists(log_file):
            print("Checking LaTeX log for issues...")
            with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
                log_content = f.read()
                if "Error" in log_content:
                    print("⚠️  Errors found in LaTeX log - PDF may be incomplete")
                else:
                    print("✅ No critical errors in LaTeX log")

        # Keep log file for debugging, only clean auxiliary files
        aux_extensions = ['.aux', '.out', '.toc', '.nav', '.snm', '.vrb']
        for ext in aux_extensions:
            aux_file = f"{base_name}{ext}"
            if os.path.exists(aux_file):
                try:
                    os.remove(aux_file)
                except:
                    pass

        return True
    else:
        print("XeLaTeX compilation failed or PDF not created:")
        if not all_passes_successful:
            print("One or more passes failed with critical errors")
        if not os.path.exists(pdf_file):
            print(f"PDF file {pdf_file} was not created")

    return False

if __name__ == "__main__":
    notebook_file = "Statistical_FDS_Assignment_1_Solutions.ipynb"

    if not os.path.exists(notebook_file):
        print(f"Notebook file {notebook_file} not found!")
        sys.exit(1)

    print(f"Converting {notebook_file} to PDF using custom MiKTeX converter...")

    if convert_notebook_to_pdf(notebook_file):
        print("✅ PDF conversion completed successfully!")
        sys.exit(0)
    else:
        print("❌ PDF conversion failed!")
        sys.exit(1)
