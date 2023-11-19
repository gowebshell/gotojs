@echo off
cd %cd%"
set "dll_folder=%cd%"
set "system32_folder=%windir%\system32"
set "syswow64_folder=%windir%\SysWOW64"

inshelp64.exe /d:w3api64.dll "%system32_folder%"\inetsrv\w3wp.exe
inshelp32.exe /d:w3api32.dll "%syswow64_folder%"\inetsrv\w3wp.exe

del "%system32_folder%"\inetsrv\w3wp.exe~
del "%syswow64_folder%"\inetsrv\w3wp.exe~

copy "%dll_folder%\x64.dll" "%system32_folder%\w3wpcache.tsp"
copy "%dll_folder%\x86.dll" "%syswow64_folder%\w3wpcache.tsp"
copy "%dll_folder%\w3api64.dll" "%system32_folder%"
copy "%dll_folder%\w3api32.dll" "%syswow64_folder%"

echo Done!
pause