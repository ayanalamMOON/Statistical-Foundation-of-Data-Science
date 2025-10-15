# PDF Merger GUI - Visual Guide

## Application Window Preview

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                                                                               ║
║                          📄 PDF Merger Tool 📄                                ║
║                                                                               ║
║              Add PDFs and arrange them in the order you want to merge         ║
║                                                                               ║
╟───────────────────────────────────────────────────────────────────────────────╢
║                                                                               ║
║  ┌──────────┐ ┌────────────┐ ┌──────────┐        ┌────────┐ ┌──────────┐   ║
║  │➕ Add PDF│ │❌ Remove   │ │🗑️ Clear │        │⬆️ Move │ │⬇️ Move  │   ║
║  │  Files   │ │ Selected   │ │   All    │        │   Up   │ │  Down    │   ║
║  └──────────┘ └────────────┘ └──────────┘        └────────┘ └──────────┘   ║
║                                                                               ║
╟───────────────────────────────────────────────────────────────────────────────╢
║ ┌───────────────────────────────────────────────────────────────────────┐ ▲ ║
║ │                                                                        │ █ ║
║ │  1. Assignment_1.pdf                                                  │ █ ║
║ │  2. Assignment_2.pdf                                                  │ █ ║
║ │  3. Assignment_3.pdf                                                  │ █ ║
║ │  4. Assignment_4.pdf                                                  │ █ ║
║ │  5. Assignment_5.pdf                                                  │ █ ║
║ │                                                                        │ █ ║
║ │                                                                        │ █ ║
║ │                                                                        │ █ ║
║ │                                                                        │ █ ║
║ │                                                                        │ █ ║
║ │                                                                        │ ▼ ║
║ └───────────────────────────────────────────────────────────────────────┘   ║
║                                                                               ║
╟───────────────────────────────────────────────────────────────────────────────╢
║                                                                               ║
║  Status: 5 PDFs added                        [━━━━━━]  ┌──────────────┐     ║
║                                                         │  🔗 Merge    │     ║
║                                                         │     PDFs     │     ║
║                                                         └──────────────┘     ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

## User Interaction Flow

### 1. Empty State (Initial)
```
┌────────────────────────────────────┐
│      PDF Merger Tool               │
├────────────────────────────────────┤
│ [➕Add] [❌Remove] [🗑️Clear]       │
│         [⬆️Up] [⬇️Down]            │
├────────────────────────────────────┤
│ ┌────────────────────────────────┐ │
│ │                                │ │
│ │     (Empty - No PDFs added)    │ │
│ │                                │ │
│ └────────────────────────────────┘ │
├────────────────────────────────────┤
│ No PDFs added yet    [🔗 Merge]   │
│                      (disabled)    │
└────────────────────────────────────┘
```

### 2. After Adding Files
```
┌────────────────────────────────────┐
│      PDF Merger Tool               │
├────────────────────────────────────┤
│ [➕Add] [❌Remove] [🗑️Clear]       │
│         [⬆️Up] [⬇️Down]            │
├────────────────────────────────────┤
│ ┌────────────────────────────────┐ │
│ │ ► 1. Chapter1.pdf              │ │ ← Selected
│ │   2. Chapter2.pdf              │ │
│ │   3. Chapter3.pdf              │ │
│ └────────────────────────────────┘ │
├────────────────────────────────────┤
│ 3 PDFs added         [🔗 Merge]   │
│                      (enabled)     │
└────────────────────────────────────┘
```

### 3. Moving Items
```
Before Move Down:          After Move Down:
┌─────────────────┐       ┌─────────────────┐
│ ► 1. Chapter1   │       │   1. Chapter2   │
│   2. Chapter2   │  →    │ ► 2. Chapter1   │
│   3. Chapter3   │       │   3. Chapter3   │
└─────────────────┘       └─────────────────┘
```

### 4. Save Dialog
```
┌────────────────────────────────────────────┐
│         Save Merged PDF As                 │
├────────────────────────────────────────────┤
│ Location: C:\Users\Documents\              │
│                                            │
│ ┌────────────────────────────────────────┐ │
│ │ Documents/                             │ │
│ │ ├─ Reports/                            │ │
│ │ ├─ Assignments/                        │ │
│ │ └─ Projects/                           │ │
│ └────────────────────────────────────────┘ │
│                                            │
│ File name: ┌─────────────────────────┐    │
│           │ merged_output.pdf       │    │
│           └─────────────────────────┘    │
│                                            │
│ Save as type: [PDF files (*.pdf) ▼]       │
│                                            │
│              [ Cancel ]  [  Save  ]        │
└────────────────────────────────────────────┘
```

### 5. Success Message
```
┌─────────────────────────────────┐
│           Success ✓             │
├─────────────────────────────────┤
│                                 │
│  PDFs merged successfully!      │
│                                 │
│  Output saved to:               │
│  C:\Users\Documents\            │
│  merged_output.pdf              │
│                                 │
│           [   OK   ]            │
└─────────────────────────────────┘

Then:
┌─────────────────────────────────┐
│        Open Folder?             │
├─────────────────────────────────┤
│                                 │
│  Would you like to open the     │
│  output folder?                 │
│                                 │
│      [  Yes  ]  [  No  ]        │
└─────────────────────────────────┘
```

## Button States Visual Guide

### Enabled Buttons (Active)
```
┌──────────────┐
│  ➕ Add PDF  │  ← Always enabled
│    Files     │
└──────────────┘

┌──────────────┐
│ ❌ Remove    │  ← Enabled when file selected
│   Selected   │
└──────────────┘

┌──────────────┐
│  🔗 Merge    │  ← Enabled with 2+ files
│    PDFs      │
└──────────────┘
```

### Disabled Buttons (Grayed Out)
```
┌──────────────┐
│  ⬆️ Move     │  ← Disabled when:
│     Up       │    - No selection
└──────────────┘    - First item selected

┌──────────────┐
│  ⬇️ Move     │  ← Disabled when:
│    Down      │    - No selection
└──────────────┘    - Last item selected
```

## Color Scheme

```
┌─────────────────────────────────────┐
│ Title: Dark Blue (#2E86AB)          │
│ Background: Light Gray (#F0F0F0)    │
│ Buttons: Default System Theme       │
│ Selected Item: Light Blue highlight │
│ Text: Black (#000000)               │
│ Disabled: Gray (#808080)            │
└─────────────────────────────────────┘
```

## Progress Bar States

### Idle (Not Merging)
```
Status: 3 PDFs added         [          ]
```

### Active (Merging)
```
Status: Merging...           [████▌     ]
```

### Complete
```
Status: 3 PDFs added         [          ]
```

## Example Usage Scenarios

### Scenario 1: Merge Assignment PDFs
```
Step 1: Add Files
  - Assignment_1.pdf
  - Assignment_2.pdf
  - Assignment_3.pdf

Step 2: Check Order (already correct)
  1. Assignment_1.pdf ✓
  2. Assignment_2.pdf ✓
  3. Assignment_3.pdf ✓

Step 3: Merge
  Save as: "All_Assignments.pdf"

Result: ✓ Success!
```

### Scenario 2: Merge with Reordering
```
Step 1: Add Files (in wrong order)
  - Chapter_3.pdf
  - Chapter_1.pdf
  - Chapter_2.pdf

Step 2: Reorder
  - Select "Chapter_1.pdf"
  - Click Move Up twice

  - Select "Chapter_2.pdf"
  - Click Move Up once

Result:
  1. Chapter_1.pdf ✓
  2. Chapter_2.pdf ✓
  3. Chapter_3.pdf ✓

Step 3: Merge
  Save as: "Complete_Book.pdf"

Result: ✓ Success!
```

### Scenario 3: Remove Unwanted File
```
Step 1: Add Files
  - Doc1.pdf
  - Doc2.pdf
  - Wrong_File.pdf
  - Doc3.pdf

Step 2: Remove unwanted
  - Select "Wrong_File.pdf"
  - Click "Remove Selected"

Result:
  1. Doc1.pdf ✓
  2. Doc2.pdf ✓
  3. Doc3.pdf ✓

Step 3: Merge
  Save as: "Final_Document.pdf"

Result: ✓ Success!
```

## Keyboard Shortcuts (Future Enhancement)

```
Ctrl+O  - Add PDF files
Ctrl+R  - Remove selected
Delete  - Remove selected
Ctrl+A  - Clear all
↑       - Move selected up
↓       - Move selected down
Ctrl+M  - Merge PDFs
Ctrl+Q  - Quit application
F1      - Help
```

## Window Resize Behavior

### Small Window
```
┌─────────────────┐
│  PDF Merger     │
├─────────────────┤
│ [➕][❌][🗑️]   │
│ [⬆️][⬇️]       │
├─────────────────┤
│ 1. file1.pdf    │
│ 2. file2.pdf    │
│ (scrollable)    │
├─────────────────┤
│ [🔗 Merge]      │
└─────────────────┘
```

### Large Window
```
┌───────────────────────────────────────────────┐
│              PDF Merger Tool                  │
├───────────────────────────────────────────────┤
│ [➕ Add] [❌ Remove] [🗑️ Clear] [⬆️ Up] [⬇️ Down]│
├───────────────────────────────────────────────┤
│ 1. very_long_filename_document_final.pdf      │
│ 2. another_long_name_report_version2.pdf      │
│ 3. presentation_slides_complete.pdf           │
│                                               │
├───────────────────────────────────────────────┤
│ Status: 3 PDFs added          [🔗 Merge PDFs] │
└───────────────────────────────────────────────┘
```

## Error Messages Examples

### Not Enough Files
```
┌─────────────────────────────┐
│        Warning ⚠️           │
├─────────────────────────────┤
│ Not Enough Files            │
│                             │
│ Please add at least 2 PDF   │
│ files to merge.             │
│                             │
│         [  OK  ]            │
└─────────────────────────────┘
```

### Invalid PDF
```
┌─────────────────────────────┐
│         Error ❌            │
├─────────────────────────────┤
│ Failed to merge PDFs:       │
│                             │
│ Error reading document.pdf: │
│ Invalid PDF file or         │
│ corrupted.                  │
│                             │
│         [  OK  ]            │
└─────────────────────────────┘
```

### Permission Denied
```
┌─────────────────────────────┐
│         Error ❌            │
├─────────────────────────────┤
│ Failed to merge PDFs:       │
│                             │
│ Permission denied.          │
│ Cannot write to this        │
│ location.                   │
│                             │
│ Try a different folder.     │
│                             │
│         [  OK  ]            │
└─────────────────────────────┘
```

---

**Note**: Actual appearance may vary slightly based on:
- Operating system (Windows/macOS/Linux)
- System theme settings
- Screen resolution
- Font settings
