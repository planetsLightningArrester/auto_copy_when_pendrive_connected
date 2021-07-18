@echo off

@REM Set here the parameters
set storage=E:\
set from=C:\test\
set to=%storage%test\

:Begin
echo Searching for devices

goto Loop

:Loop
ping 127.0.0.1 -n 3 > NUL
if exist %storage% (goto Yes) else (goto Loop)

:Yes
echo Copying files to  %to%
xcopy /y /s %from% %to%
goto RemoveDevice

:RemoveDevice
echo Ejecting the device
powershell $driveEject = New-Object -comObject Shell.Application; $driveEject.Namespace(17).ParseName(\"%storage%\\").InvokeVerb(\"Eject\")
timeout 5 > NUL
goto Begin

:end
pause