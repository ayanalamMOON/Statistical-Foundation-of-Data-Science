@echo off
echo ================================
echo PDF Merger GUI - Setup & Launch
echo ================================
echo.
echo Activating virtual environment...
echo.

cd ..
call .venv\Scripts\activate.bat
cd PDF_Merger

echo Installing dependencies if needed...
echo.

python -m pip install -r requirements.txt --quiet

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Starting PDF Merger GUI...
echo.

python pdf_merger_gui.py

pause

deactivate
