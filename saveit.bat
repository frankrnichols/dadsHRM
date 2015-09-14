@echo off
if not exist CodeSnapshots md CodeSnapshots
if not exist "Read Me.txt" echo "Incremental backup notes" >>"Read Me.txt"
cd CodeSnapshots
set /a var=00
:LOOP
if not exist Snapshot_%var% goto foundit
set /a var+=1
goto LOOP
:foundit
mkdir Snapshot_%var%
cd ..
copy *.c CodeSnapshots\Snapshot_%var%
copy *.h CodeSnapshots\Snapshot_%var%
copy pca10031\s110\arm5\ble_app_hrs_s110_pca10031.uvprojx CodeSnapshots\Snapshot_%var%
copy pca10031\s110\arm5\_build\*.hex CodeSnapshots\Snapshot_%var%
echo.
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
echo.
pause
copy /Y "read me.txt" CodeSnapshots\Snapshot_%var%
mkdir C:\Users\FrankR\"Google Drive"\BLE_HSsnapshots\Snapshot_%var%
copy CodeSnapshots\Snapshot_%var% C:\Users\FrankR\"Google Drive"\BLE_HSsnapshots\Snapshot_%var%
.
.


