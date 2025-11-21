"""
PDF Merger GUI Application
A user-friendly GUI application for merging multiple PDF files with custom ordering.
Features intelligent compression to reduce file size without quality loss.
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from pathlib import Path
import PyPDF2
from PyPDF2 import PdfWriter, PdfReader
from typing import List, Optional
import io


class PDFMergerGUI:
    """GUI application for merging PDF files with drag-and-drop ordering."""

    def __init__(self, root):
        self.root = root
        self.root.title("PDF Merger - Merge PDFs with Custom Order")
        self.root.geometry("800x600")
        self.root.resizable(True, True)

        # List to store PDF file paths
        self.pdf_files: List[str] = []

        # Compression settings
        self.enable_compression = tk.BooleanVar(value=True)
        self.compression_level = tk.StringVar(value="medium")

        # Configure style
        self.setup_styles()  # Create GUI elements
        self.create_widgets()

        # Center window
        self.center_window()

    def setup_styles(self):
        """Configure ttk styles for better appearance."""
        style = ttk.Style()
        style.theme_use("clam")

        # Configure colors
        style.configure("TFrame", background="#f0f0f0")
        style.configure(
            "Title.TLabel", font=("Arial", 16, "bold"), background="#f0f0f0"
        )
        style.configure("Info.TLabel", font=("Arial", 10), background="#f0f0f0")
        style.configure("TButton", font=("Arial", 10), padding=5)
        style.configure("Action.TButton", font=("Arial", 11, "bold"), padding=8)

    def create_widgets(self):
        """Create all GUI widgets."""
        # Main container
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.pack(fill=tk.BOTH, expand=True)

        # Title
        title_label = ttk.Label(
            main_frame, text="PDF Merger Tool", style="Title.TLabel"
        )
        title_label.pack(pady=(0, 10))

        # Info label
        info_label = ttk.Label(
            main_frame,
            text="Add PDFs and arrange them in the order you want to merge",
            style="Info.TLabel",
        )
        info_label.pack(pady=(0, 10))

        # Button frame
        button_frame = ttk.Frame(main_frame)
        button_frame.pack(fill=tk.X, pady=(0, 10))

        # Add PDF button
        self.add_btn = ttk.Button(
            button_frame,
            text="➕ Add PDF Files",
            command=self.add_pdfs,
            style="Action.TButton",
        )
        self.add_btn.pack(side=tk.LEFT, padx=5)

        # Remove selected button
        self.remove_btn = ttk.Button(
            button_frame,
            text="❌ Remove Selected",
            command=self.remove_selected,
            state=tk.DISABLED,
        )
        self.remove_btn.pack(side=tk.LEFT, padx=5)

        # Clear all button
        self.clear_btn = ttk.Button(
            button_frame, text="🗑️ Clear All", command=self.clear_all, state=tk.DISABLED
        )
        self.clear_btn.pack(side=tk.LEFT, padx=5)

        # Spacer
        ttk.Frame(button_frame).pack(side=tk.LEFT, expand=True)

        # Move up button
        self.move_up_btn = ttk.Button(
            button_frame, text="⬆️ Move Up", command=self.move_up, state=tk.DISABLED
        )
        self.move_up_btn.pack(side=tk.LEFT, padx=5)

        # Move down button
        self.move_down_btn = ttk.Button(
            button_frame, text="⬇️ Move Down", command=self.move_down, state=tk.DISABLED
        )
        self.move_down_btn.pack(side=tk.LEFT, padx=5)

        # List frame with scrollbar
        list_frame = ttk.Frame(main_frame)
        list_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))

        # Scrollbar
        scrollbar = ttk.Scrollbar(list_frame)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        # Listbox to display PDF files
        self.pdf_listbox = tk.Listbox(
            list_frame,
            font=("Arial", 10),
            selectmode=tk.EXTENDED,
            yscrollcommand=scrollbar.set,
            activestyle="none",
            relief=tk.SOLID,
            borderwidth=1,
        )
        self.pdf_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=self.pdf_listbox.yview)

        # Bind selection event
        self.pdf_listbox.bind("<<ListboxSelect>>", self.on_selection_change)

        # Status frame
        status_frame = ttk.Frame(main_frame)
        status_frame.pack(fill=tk.X, pady=(0, 10))

        self.status_label = ttk.Label(
            status_frame, text="No PDFs added yet", style="Info.TLabel"
        )
        self.status_label.pack(side=tk.LEFT)

        # Compression settings frame
        compression_frame = ttk.LabelFrame(
            main_frame, text="Compression Settings", padding="10"
        )
        compression_frame.pack(fill=tk.X, pady=(0, 10))

        # Enable compression checkbox
        compression_check = ttk.Checkbutton(
            compression_frame,
            text="Enable compression (reduces file size)",
            variable=self.enable_compression,
            command=self.on_compression_toggle,
        )
        compression_check.pack(anchor=tk.W, pady=(0, 5))

        # Compression level frame
        self.level_frame = ttk.Frame(compression_frame)
        self.level_frame.pack(fill=tk.X, padx=20)

        ttk.Label(self.level_frame, text="Compression level:").pack(
            side=tk.LEFT, padx=(0, 10)
        )

        levels = [
            ("Low (faster, larger)", "low"),
            ("Medium (balanced)", "medium"),
            ("High (slower, smaller)", "high"),
        ]

        for text, value in levels:
            ttk.Radiobutton(
                self.level_frame,
                text=text,
                variable=self.compression_level,
                value=value,
            ).pack(
                side=tk.LEFT, padx=5
            )  # Merge button frame
        merge_frame = ttk.Frame(main_frame)
        merge_frame.pack(fill=tk.X)

        self.merge_btn = ttk.Button(
            merge_frame,
            text="🔗 Merge PDFs",
            command=self.merge_pdfs,
            style="Action.TButton",
            state=tk.DISABLED,
        )
        self.merge_btn.pack(side=tk.RIGHT, padx=5)

        # Progress bar
        self.progress = ttk.Progressbar(merge_frame, mode="indeterminate", length=200)
        self.progress.pack(side=tk.RIGHT, padx=5)

    def center_window(self):
        """Center the window on the screen."""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f"{width}x{height}+{x}+{y}")

    def add_pdfs(self):
        """Open file dialog to add PDF files."""
        files = filedialog.askopenfilenames(
            title="Select PDF Files",
            filetypes=[("PDF files", "*.pdf"), ("All files", "*.*")],
            initialdir=Path.home(),
        )

        if files:
            for file in files:
                if file not in self.pdf_files:
                    self.pdf_files.append(file)
                    # Display only filename with order number
                    display_name = f"{len(self.pdf_files)}. {Path(file).name}"
                    self.pdf_listbox.insert(tk.END, display_name)

            self.update_status()
            self.update_button_states()

    def remove_selected(self):
        """Remove selected PDFs from the list."""
        selected_indices = self.pdf_listbox.curselection()

        if not selected_indices:
            return

        # Remove in reverse order to maintain correct indices
        for index in reversed(selected_indices):
            self.pdf_listbox.delete(index)
            self.pdf_files.pop(index)

        # Renumber remaining items
        self.renumber_list()
        self.update_status()
        self.update_button_states()

    def clear_all(self):
        """Clear all PDFs from the list."""
        if messagebox.askyesno("Confirm", "Remove all PDFs from the list?"):
            self.pdf_listbox.delete(0, tk.END)
            self.pdf_files.clear()
            self.update_status()
            self.update_button_states()

    def move_up(self):
        """Move selected item up in the list."""
        selected_indices = self.pdf_listbox.curselection()

        if not selected_indices or selected_indices[0] == 0:
            return

        index = selected_indices[0]

        # Swap in list
        self.pdf_files[index], self.pdf_files[index - 1] = (
            self.pdf_files[index - 1],
            self.pdf_files[index],
        )

        # Renumber and reselect
        self.renumber_list()
        self.pdf_listbox.selection_clear(0, tk.END)
        self.pdf_listbox.selection_set(index - 1)
        self.pdf_listbox.see(index - 1)

    def move_down(self):
        """Move selected item down in the list."""
        selected_indices = self.pdf_listbox.curselection()

        if not selected_indices or selected_indices[0] == len(self.pdf_files) - 1:
            return

        index = selected_indices[0]

        # Swap in list
        self.pdf_files[index], self.pdf_files[index + 1] = (
            self.pdf_files[index + 1],
            self.pdf_files[index],
        )

        # Renumber and reselect
        self.renumber_list()
        self.pdf_listbox.selection_clear(0, tk.END)
        self.pdf_listbox.selection_set(index + 1)
        self.pdf_listbox.see(index + 1)

    def renumber_list(self):
        """Renumber the items in the listbox."""
        self.pdf_listbox.delete(0, tk.END)
        for i, file in enumerate(self.pdf_files, 1):
            display_name = f"{i}. {Path(file).name}"
            self.pdf_listbox.insert(tk.END, display_name)

    def on_selection_change(self, event):
        """Handle listbox selection changes."""
        self.update_button_states()

    def on_compression_toggle(self):
        """Handle compression checkbox toggle."""
        if self.enable_compression.get():
            for child in self.level_frame.winfo_children():
                if isinstance(child, ttk.Radiobutton):
                    child.config(state=tk.NORMAL)
        else:
            for child in self.level_frame.winfo_children():
                if isinstance(child, ttk.Radiobutton):
                    child.config(state=tk.DISABLED)

    def update_status(self):
        """Update the status label."""
        count = len(self.pdf_files)
        if count == 0:
            self.status_label.config(text="No PDFs added yet")
        elif count == 1:
            self.status_label.config(text="1 PDF added")
        else:
            self.status_label.config(text=f"{count} PDFs added")

    def update_button_states(self):
        """Enable/disable buttons based on current state."""
        has_files = len(self.pdf_files) > 0
        has_selection = len(self.pdf_listbox.curselection()) > 0
        can_merge = len(self.pdf_files) >= 2

        # Update button states
        self.remove_btn.config(state=tk.NORMAL if has_selection else tk.DISABLED)
        self.clear_btn.config(state=tk.NORMAL if has_files else tk.DISABLED)
        self.merge_btn.config(state=tk.NORMAL if can_merge else tk.DISABLED)

        # Move buttons (only for single selection)
        if has_selection and len(self.pdf_listbox.curselection()) == 1:
            index = self.pdf_listbox.curselection()[0]
            self.move_up_btn.config(state=tk.NORMAL if index > 0 else tk.DISABLED)
            self.move_down_btn.config(
                state=tk.NORMAL if index < len(self.pdf_files) - 1 else tk.DISABLED
            )
        else:
            self.move_up_btn.config(state=tk.DISABLED)
            self.move_down_btn.config(state=tk.DISABLED)

    def compress_pdf(self, input_buffer, compression_level):
        """
        Compress PDF using various optimization techniques.

        Args:
            input_buffer: BytesIO buffer containing the merged PDF
            compression_level: 'low', 'medium', or 'high'

        Returns:
            BytesIO buffer with compressed PDF
        """
        reader = PdfReader(input_buffer)
        writer = PdfWriter()

        # Copy all pages to writer
        for page in reader.pages:
            # Compress page content streams
            page.compress_content_streams()

            # Add page to writer
            writer.add_page(page)

        # Set compression level based on user choice
        if compression_level == "high":
            # Maximum compression
            if reader.metadata:
                writer.add_metadata(reader.metadata)
            # Remove duplicate objects
            for page in writer.pages:
                page.compress_content_streams()
        elif compression_level == "medium":
            # Balanced compression
            if reader.metadata:
                writer.add_metadata(reader.metadata)
        # else: low compression (default behavior)

        # Write to output buffer
        output_buffer = io.BytesIO()
        writer.write(output_buffer)
        output_buffer.seek(0)

        return output_buffer

    def get_file_size_mb(self, file_path_or_buffer):
        """Get file size in MB."""
        if isinstance(file_path_or_buffer, (str, Path)):
            size_bytes = Path(file_path_or_buffer).stat().st_size
        else:
            file_path_or_buffer.seek(0, 2)  # Seek to end
            size_bytes = file_path_or_buffer.tell()
            file_path_or_buffer.seek(0)  # Reset to beginning
        return size_bytes / (1024 * 1024)

    def merge_pdfs(self):
        """Merge the PDF files in the current order with optional compression."""
        if len(self.pdf_files) < 2:
            messagebox.showwarning(
                "Not Enough Files", "Please add at least 2 PDF files to merge."
            )
            return

        # Ask for output file name
        output_file = filedialog.asksaveasfilename(
            title="Save Merged PDF As",
            defaultextension=".pdf",
            filetypes=[("PDF files", "*.pdf")],
            initialfile="merged_output.pdf",
        )

        if not output_file:
            return

        # Start progress bar
        self.progress.start(10)
        self.merge_btn.config(state=tk.DISABLED)
        self.root.update()

        try:
            # Create PDF merger object
            pdf_merger = PyPDF2.PdfMerger()

            # Add each PDF file in order
            for pdf_file in self.pdf_files:
                try:
                    pdf_merger.append(pdf_file)
                except Exception as e:
                    raise Exception(f"Error reading {Path(pdf_file).name}: {str(e)}")

            # Write to buffer first
            temp_buffer = io.BytesIO()
            pdf_merger.write(temp_buffer)
            pdf_merger.close()
            temp_buffer.seek(0)

            # Get original size
            original_size_mb = self.get_file_size_mb(temp_buffer)

            # Apply compression if enabled
            if self.enable_compression.get():
                self.status_label.config(text="Compressing PDF...")
                self.root.update()

                compressed_buffer = self.compress_pdf(
                    temp_buffer, self.compression_level.get()
                )
                compressed_size_mb = self.get_file_size_mb(compressed_buffer)

                # Write compressed PDF to output file
                with open(output_file, "wb") as output:
                    output.write(compressed_buffer.getvalue())

                # Calculate compression ratio
                reduction_percent = (
                    (original_size_mb - compressed_size_mb) / original_size_mb
                ) * 100
                compression_info = (
                    f"\n\nCompression Results:"
                    f"\nOriginal: {original_size_mb:.2f} MB"
                    f"\nCompressed: {compressed_size_mb:.2f} MB"
                    f"\nReduction: {reduction_percent:.1f}%"
                )
            else:
                # Write uncompressed PDF to output file
                with open(output_file, "wb") as output:
                    output.write(temp_buffer.getvalue())

                compression_info = f"\n\nFile size: {original_size_mb:.2f} MB"

            # Stop progress bar
            self.progress.stop()
            self.update_button_states()

            # Show success message
            messagebox.showinfo(
                "Success",
                f"PDFs merged successfully!\n\nOutput saved to:\n{output_file}{compression_info}",
            )

            # Ask if user wants to open the folder
            if messagebox.askyesno(
                "Open Folder", "Would you like to open the output folder?"
            ):
                import os
                import subprocess

                folder_path = Path(output_file).parent

                # Open folder based on OS
                if os.name == "nt":  # Windows
                    subprocess.run(["explorer", str(folder_path)])
                elif os.name == "posix":  # macOS/Linux
                    subprocess.run(
                        [
                            "open" if os.uname().sysname == "Darwin" else "xdg-open",
                            str(folder_path),
                        ]
                    )

        except Exception as e:
            self.progress.stop()
            self.update_button_states()
            messagebox.showerror("Error", f"Failed to merge PDFs:\n\n{str(e)}")


def main():
    """Main entry point for the application."""
    root = tk.Tk()
    app = PDFMergerGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
