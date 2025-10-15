# PDF Merger GUI

A user-friendly GUI application for merging multiple PDF files with custom ordering capabilities.

## Features

- **Add Multiple PDFs**: Select and add multiple PDF files at once
- **Custom Ordering**: Rearrange PDFs using Move Up/Down buttons
- **Visual List**: See all selected PDFs with their order numbers
- **Remove Files**: Remove selected files or clear all at once
- **Intelligent Compression**: Reduce file size by 20-50% without quality loss
- **Compression Levels**: Choose Low, Medium, or High compression
- **Real-time Statistics**: See before/after file sizes and reduction percentage
- **Save Anywhere**: Choose the output location and filename
- **Error Handling**: Comprehensive error messages for better user experience
- **Modern UI**: Clean and intuitive interface with emoji icons
- **Progress Indication**: Visual feedback during the merge process

## Installation

### Prerequisites

- Python 3.7 or higher (installed on your system)

### Quick Start (Windows)

**Option 1: Double-click to install and run**
1. Double-click `install_and_run.bat`
2. The application will start automatically

**Option 2: Install separately**
1. Double-click `install.bat` to install dependencies
2. Double-click `run.bat` to launch the application

### Manual Installation

1. Open Command Prompt or Terminal

2. Navigate to the PDF_Merger folder:
   ```bash
   cd "c:/Users/ayana/Projects/Stats&AI/Statistical Foundation of Data Science/PDF_Merger"
   ```

3. Install required packages:
   ```bash
   py -m pip install -r requirements.txt
   ```

## Usage

### Running the Application

**Windows (Easy):**
- Double-click `run.bat`

**Command Line:**
```bash
py pdf_merger_gui.py
```

### How to Use

1. **Add PDF Files**
   - Click the "➕ Add PDF Files" button
   - Select one or more PDF files from your computer
   - Files will appear in the list with order numbers

2. **Arrange Order**
   - Select a PDF from the list
   - Use "⬆️ Move Up" or "⬇️ Move Down" buttons to change the order
   - The numbers will update automatically

3. **Remove Files** (Optional)
   - Select one or more files to remove
   - Click "❌ Remove Selected" to remove them
   - Or click "🗑️ Clear All" to remove all files

4. **Configure Compression** (Optional)
   - Check "Enable compression" (enabled by default)
   - Select compression level:
     - Low: Fast, moderate compression
     - Medium: Balanced (recommended)
     - High: Maximum compression, slower

5. **Merge PDFs**
   - Once you have at least 2 PDFs added
   - Click "🔗 Merge PDFs" button
   - Choose where to save the merged PDF
   - Enter a filename for the output
   - Click "Save"

6. **Success**
   - A success message will appear with compression statistics
   - See original size, compressed size, and reduction percentage
   - Option to open the output folder directly

## Features in Detail

### File Management
- **Multi-select**: Add multiple PDFs at once
- **No duplicates**: Same file won't be added twice
- **Easy removal**: Remove selected files or clear all

### Ordering System
- **Visual numbers**: Each PDF shows its position (1, 2, 3, etc.)
- **Move Up/Down**: Single-click reordering
- **Automatic renumbering**: Order updates instantly

### User Interface
- **Status bar**: Shows how many PDFs are added
- **Smart buttons**: Buttons enable/disable based on context
- **Progress bar**: Visual feedback during merge
- **Tooltips**: Clear button labels with icons

### Error Handling
- Validates PDF files before merging
- Shows clear error messages
- Prevents invalid operations
- Handles file access issues

## Requirements

- **PyPDF2**: For PDF manipulation and merging

## File Structure

```
PDF_Merger/
├── pdf_merger_gui.py       # Main application
├── requirements.txt        # Python dependencies
└── README.md              # This file
```

## Troubleshooting

### "PyPDF2 not found" Error
Install the required package:
```bash
pip install PyPDF2
```

### "Permission Denied" Error
- Make sure the output location is writable
- Close any PDF viewers that might have the file open
- Try saving to a different location

### "Invalid PDF" Error
- Ensure all selected files are valid PDF files
- Try opening the PDF in a PDF reader to verify
- Some encrypted PDFs may not work

## Technical Details

- **Framework**: Tkinter (Python's standard GUI library)
- **PDF Library**: PyPDF2 for PDF manipulation
- **Python Version**: 3.7+
- **Platform**: Cross-platform (Windows, macOS, Linux)

## License

This is a utility tool for educational and personal use.

## Author

Created for the Statistical Foundation of Data Science course.

## Version

1.0.0 - Initial release
