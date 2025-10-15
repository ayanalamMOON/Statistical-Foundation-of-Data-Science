@echo off
echo ================================
echo PDF Merger GUI - Installation
echo ================================
echo.
echo Activating virtual environment...
echo.

cd ..
call .venv\Scripts\activate.bat
cd PDF_Merger

echo Installing required dependencies...
echo.

python -m pip install -r requirements.txt

echo.
echo ================================
echo Installation Complete!
echo ================================
echo.
echo To run the application, use:
echo     run.bat
echo.
pause

deactivate
