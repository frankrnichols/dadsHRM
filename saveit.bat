@echo off
if not exist C:\Users\FrankR\"Google Drive"\PGBsnapshots md C:\Users\FrankR\"Google Drive"\PGBsnapshots
if not exist "Read Me.txt" echo "Incremental backup notes" >>"Read Me.txt"
cd C:\Users\FrankR\"Google Drive"\PGBsnapshots
set /a var=00
:LOOP
if not exist Snapshot_%var% goto foundit
set /a var+=1
goto LOOP
:foundit
mkdir Snapshot_%var%
cd C:\Users\FrankR\Documents\GitHub\dadsHRM
set path=%path%;c:\program files\7-zip
7z a -r C:\Users\FrankR\"Google Drive"\PGBsnapshots\Snapshot_%var%\Snapshot_%var% *.*
echo.
echo.
echo Your new folder is named = Snapshot_%var%
echo.
echo.
echo.
set startDate=%date%
set startTime=%time%
set sdy=%startDate:~10%
set /a sdm=1%startDate:~4,2% - 100
set /a sdd=1%startDate:~7,2% - 100
set /a sth=%startTime:~0,2%
set /a stm=1%startTime:~3,2% - 100
set /a sts=1%startTime:~6,2% - 100
echo %sdm%/%sdd%/%sdy% %sth%:%stm% Snapshot_%var%: >>"Read Me.txt"
start "C:\Program Files (x86)\Notepad++\notepad++" "read me.txt"
echo In your editor, Save edited file: READ ME.TXT
echo and then...
pause
echo.
copy /Y "read me.txt" C:\Users\FrankR\"Google Drive"\PGBsnapshots\Snapshot_%var%
.
.


