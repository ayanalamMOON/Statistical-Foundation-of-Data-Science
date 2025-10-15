@echo off
echo ================================
echo PDF Merger GUI
echo ================================
echo.
echo Activating virtual environment...
echo.

cd ..
call .venv\Scripts\activate.bat
cd PDF_Merger

echo Starting application...
echo.

python pdf_merger_gui.py

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to start application
    echo.
    echo Please make sure PyPDF2 is installed:
    echo     python -m pip install PyPDF2
    echo.
    pause
)

deactivate
