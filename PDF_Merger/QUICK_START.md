# PDF Merger GUI - Quick Start Guide

## 🚀 Getting Started

### Step 1: Install Dependencies
```bash
# Option A: Use the batch file (Windows)
Double-click: install.bat

# Option B: Use command line
py -m pip install -r requirements.txt
```

### Step 2: Launch the Application
```bash
# Option A: Use the batch file (Windows)
Double-click: run.bat

# Option B: Use command line
py pdf_merger_gui.py
```

## 📖 How to Use

### Adding PDF Files
1. Click **"➕ Add PDF Files"** button
2. Select one or more PDF files
3. Files appear in the list with numbers (1, 2, 3, ...)

### Reordering PDFs
1. **Select** a PDF from the list (click on it)
2. Use **"⬆️ Move Up"** or **"⬇️ Move Down"** buttons
3. Watch the numbers update automatically!

### Removing PDFs
- **Remove one**: Select it → Click **"❌ Remove Selected"**
- **Remove all**: Click **"🗑️ Clear All"**

### Merging PDFs
1. Make sure you have **at least 2 PDFs** added
2. Arrange them in the **desired order**
3. Click **"🔗 Merge PDFs"** button
4. Choose where to **save** the merged file
5. Enter a **filename** (e.g., "merged_output.pdf")
6. Click **"Save"**
7. Done! ✓

## 🎯 Key Features

| Feature                | Description                            |
| ---------------------- | -------------------------------------- |
| **Multiple Selection** | Add many PDFs at once                  |
| **No Duplicates**      | Same file won't be added twice         |
| **Visual Order**       | See the merge order with numbers       |
| **Easy Reordering**    | Move Up/Down buttons                   |
| **Smart Buttons**      | Buttons enable/disable automatically   |
| **Progress Bar**       | See when merge is happening            |
| **Error Messages**     | Clear feedback if something goes wrong |

## 💡 Tips

1. **Add files in any order** - you can reorder them later
2. **Select multiple files** at once in the file dialog
3. **Remove mistakes** easily before merging
4. **Check the order** (1, 2, 3...) before clicking Merge
5. **Choose a good name** for your merged PDF

## 🔧 Troubleshooting

### "PyPDF2 not found"
```bash
py -m pip install PyPDF2
```

### "Can't open the application"
- Check if Python is installed: `py --version`
- Make sure tkinter is available (usually comes with Python)

### "Can't save the file"
- Choose a different location
- Make sure you have write permissions
- Close any PDF viewers that might have the file open

### "Invalid PDF file"
- Some encrypted PDFs may not work
- Try opening the PDF in a viewer first to check it

## 📁 Files in This Folder

| File                    | Purpose                          |
| ----------------------- | -------------------------------- |
| `pdf_merger_gui.py`     | Main application                 |
| `requirements.txt`      | Python dependencies              |
| `install.bat`           | Install dependencies (Windows)   |
| `run.bat`               | Launch application (Windows)     |
| `install_and_run.bat`   | Install & launch in one step     |
| `check_dependencies.py` | Check if everything is installed |
| `README.md`             | Full documentation               |
| `QUICK_START.md`        | This file                        |

## 🎓 Example Workflow

```
1. Launch app (run.bat)
   ↓
2. Add PDFs: chapter1.pdf, chapter3.pdf, chapter2.pdf
   ↓
3. Reorder: Move chapter2.pdf between chapter1 and chapter3
   ↓
4. Merge PDFs
   ↓
5. Save as: "complete_book.pdf"
   ✓ Success!
```

## ⚙️ System Requirements

- **OS**: Windows, macOS, or Linux
- **Python**: 3.7 or higher
- **Memory**: Minimal (works with large PDFs too)
- **Disk Space**: Negligible (~1 MB)

## 📞 Need Help?

1. Run `py check_dependencies.py` to verify installation
2. Read the full `README.md` for detailed information
3. Check error messages carefully - they guide you to the solution

---

**Happy Merging! 📄 + 📄 = 📚**
