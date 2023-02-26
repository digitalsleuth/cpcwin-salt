@echo off
::CMPFOR Script created by Sgt. Mark Southby
::2023-02-25
:: Rename your version of exiftool(-k)-#.#.exe to exiftool.exe
::Click and Drag folder with images and videos
::to folder containing exiftool.exe and kml.fmt

::Set the output filename before the .kml
set /p filename=KML File Name:
set orig=%filename%
::Set Path to photos
ECHO Click and drag photos folder to this window and press Enter.
SET /p output=:
::Check to see if output name exisits
IF EXIST %output%\"%filename%.KML" goto exst
::If not found, use exisiting name
GOTO unique
:exst
::If it exists add an increment
set /a incr=%incr%+1
::set filename=%filename%-%incr%
::Check to see if file and increment exists
IF EXIST %output%\"%filename%-%incr%.KML" goto exst
::Reference original file exists, display updated filename
set filename=%filename%-%incr%
echo %orig%.KML exists at %output:"=%

:unique
echo Output will be "%output:"=%\%filename%.KML"
:: Run EXIFTool Command
C:\standalone\exiftool\exiftool -n -r -q -p C:\standalone\exiftool\kml.fmt %output%>%output%\"%filename%.KML"
echo.
set incr=0
pause
