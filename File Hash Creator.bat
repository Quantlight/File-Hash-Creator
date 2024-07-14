@echo off
setlocal enabledelayedexpansion

rem Set the source folder
set "source_folder=E:\Recovered(Sorted)\Jpegs"

rem Set the output CSV file
set "output_csv=E:\Recovered(Sorted)\Jpegs\output.csv"

rem Create the CSV file with headers
echo "Filename","Size","Hash" > "%output_csv%"

rem Loop through files in the source folder
for %%F in ("%source_folder%\*.*") do (
    rem Get filename
    set "filename=%%~nxF"
    
    rem Get size
    for %%A in ("%%F") do (
        set "size=%%~zA"
    )

    rem Calculate hash using PowerShell
    for /f "tokens=*" %%H in ('powershell "(Get-FileHash '%%F' -Algorithm MD5).Hash"') do (
        set "hash=%%H"
    )

    rem Print filename, size, and hash on cmd
    echo Filename: !filename!, Size: !size! bytes, Hash: !hash!

    rem Append filename, size, and hash to CSV file
    echo "!filename!","!size!","!hash!" >> "%output_csv%"
)

echo "CSV file generated: %output_csv%"
