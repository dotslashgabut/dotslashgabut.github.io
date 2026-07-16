@echo off
setlocal enabledelayedexpansion

REM File ini akan mengenerate list file .html dan menyimpannya ke list.txt
set OUTPUT_FILE=list.txt

REM Hapus file lama jika ada
if exist %OUTPUT_FILE% del %OUTPUT_FILE%

REM Tambahkan header
echo # List of .html Files>> %OUTPUT_FILE%
echo Generation Time: %date% %time%>> %OUTPUT_FILE%
echo.>> %OUTPUT_FILE%

REM Loop melalui semua file .html di folder saat ini dan subfolder
for /r %%F in (*.html) do (
    setlocal enabledelayedexpansion
    set "filepath=%%F"
    REM Ekstrak parent directory dan filename
    for %%A in ("!filepath!") do (
        set "filename=%%~nxA"
        set "parent=%%~dpA"
    )
    REM Ambil nama folder terakhir dari parent path
    for %%B in ("!parent:~0,-1!") do set "foldername=%%~nxB"
    REM Ganti backslash dengan forward slash
    set "foldername=!foldername:\=/!"
    set "output=!foldername!/!filename!"
    echo https://!output!>> %OUTPUT_FILE%
    endlocal
)

echo.
echo List file selesai disimpan ke %OUTPUT_FILE%
pause
