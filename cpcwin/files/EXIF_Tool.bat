@echo off
::CMPFOR Script created by Sgt. Mark Southby
::2022-02-10
:: Rename your version of exiftool(-k)-#.#.exe to exiftool.exe
::Click and Drag folder with images and videos
::to folder containing exiftool.exe and kml.fmt

::Set the output filename before the .kml
set /p filename=KML Description [No Spaces]: 

::Check to see if output name exisits
IF EXIST %filename%.kml goto exst
::If not found, use exisiting name
GOTO unique
:exst
color 0c
::If it exists add an increment
echo %filename% Exists! Adding increment...
set /a incr=%incr%+1
set filename=%filename%-%incr%
echo %filename%
::Check to see if file and increment exisit
ECHO Checking ....
IF EXIST %filename%.KML goto exst

:unique
echo %filename% does not exist, out put will be %filename%.kml

::Set Path to photos
ECHO Click and drag photos folder to this window and press Enter.
SET /p path=:
:: Run EXIFTool Command
exiftool -n -r -q -p C:\standalone\exiftool\kml.fmt %PATH%>%filename%.KML
pause
