"""
Demo/Test script for PDF Merger GUI
This script can be used to verify the installation is working.
"""

def check_dependencies():
    """Check if all required dependencies are installed."""
    print("=" * 50)
    print("PDF Merger GUI - Dependency Check")
    print("=" * 50)
    print()

    all_good = True

    # Check Python version
    import sys
    print(f"✓ Python version: {sys.version.split()[0]}")

    if sys.version_info < (3, 7):
        print("  ⚠ Warning: Python 3.7 or higher is recommended")
        all_good = False

    # Check tkinter
    try:
        import tkinter
        print("✓ tkinter is available")
    except ImportError:
        print("✗ tkinter is NOT available")
        print("  Install tkinter for your Python version")
        all_good = False

    # Check PyPDF2
    try:
        import PyPDF2
        print(f"✓ PyPDF2 is installed (version: {PyPDF2.__version__})")
    except ImportError:
        print("✗ PyPDF2 is NOT installed")
        print("  Run: py -m pip install PyPDF2")
        all_good = False

    print()
    print("=" * 50)

    if all_good:
        print("✓ All dependencies are installed!")
        print("You can now run: py pdf_merger_gui.py")
    else:
        print("⚠ Some dependencies are missing")
        print("Please install them before running the application")

    print("=" * 50)
    print()

    return all_good


if __name__ == "__main__":
    check_dependencies()

    input("Press Enter to exit...")
