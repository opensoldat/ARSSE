@echo off
cd ..
rmdir /S/Q ARSSE
mkdir ARSSE
cd utils
call upx.compress.ARSSE.exe.bat
cd ..
copy utils\ARSSE.exe ARSSE\
copy botlist.txt ARSSE\
copy CommandBox.help.txt ARSSE\
copy CommandBox.txt ARSSE\
copy maplist.txt ARSSE\
copy readme.arsse.txt ARSSE\
mkdir ARSSE\script
copy script\*.txt ARSSE\script\
mkdir ARSSE\logs
mkdir ARSSE\data
copy data\ip.adb ARSSE\data\
mkdir ARSSE\documentation
copy documentation\*.txt ARSSE\documentation\
mkdir ARSSE\flags
copy flags\*.gif ARSSE\flags\
cd utils
call 7zip.compress.ARSSE.full.bat
pause
