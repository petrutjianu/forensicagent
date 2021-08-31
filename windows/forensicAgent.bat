@echo off
set _executiontime=powershell -command "[datetime]::now.tostring('yyyy-MM-dd_hh-mm')"
%_executiontime% > date.txt
set /p executiontime= < date.txt
%executiontime%
mkdir %executiontime%
del date.txt


echo MRU Results
C:\WINDOWS\system32\reg.exe QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /s > %executiontime%/mruResults.txt

echo Getting Temp Directory Files 
echo Temp Directory Files > %executiontime%/TempDirFiles.txt
echo "Default user AppData\Local\Temp:" >> TempDirFiles.txt
C:\WINDOWS\system32\cmd.exe /C "dir /A /Q /S /T C:\Users\Default\AppData\Local\Temp"  >> %executiontime%/TempDirFiles.txt
echo "Administrator AppData\Local\Temp:" >> TempDirFiles.txt
C:\WINDOWS\system32\cmd.exe /C "dir /A /Q /S /T C:\Users\Administrator\AppData\Local\Temp" >> %executiontime%/TempDirFiles.txt
echo "WDAG Uitility Account AppData\Local\Temp:" >> %executiontime%/TempDirFiles.txt
C:\WINDOWS\system32\cmd.exe /C "dir /A /Q /S /T "C:\Users\WDAGUtilityAccount\AppData\Local\Temp"
echo %username% AppData\Local\Temp >> %executiontime%/TempDirFiles.txt
C:\WINDOWS\system32\cmd.exe /C "dir /A /Q /S /T C:\Users\%username%\AppData\Local\Temp" >> %executiontime%/TempDirFiles.txt

echo Getting Process List
C:\WINDOWS\system32\wbem\wmic.exe process get > %executiontime%/ProcessList.csv

echo Getting Services List
C:\WINDOWS\system32\wbem\wmic.exe service get /format:csv > %executiontime%/ServiceList.csv
::echo Getting Running Services 
::echo Running Services >> %executiontime%/ServiceList.csv
::wmic service list brief /format:csv | findstr "Running" >>%executiontime%/ServiceList.csv


echo Getting Network Status
C:\WINDOWS\system32\netstat.exe -abno > %executiontime%/network.txt
netsh winhttp show proxy >> %executiontime%/network.txt

echo Getting Scheduled Tasks and BITS Jobs
C:\WINDOWS\system32\schtasks.exe /query /v /fo CSV > %executiontime%/schTasks.csv
powershell -command Get-BitsTransfer > %executiontime%/bitsjobs.txt
echo Getting Local Groups
for /f "delims=*" %%x in ('net localgroup ^|find "*"') do net localgroup "%%x" >> LocalGroups.txt > %executiontime%>LocalGroups.txt
echo Getting ARP Cache
C:\WINDOWS\system32\arp.exe -a > %executiontime%/ARPCache.txt

echo Getting DNS Cache
C:\WINDOWS\system32\ipconfig.exe /displaydns > %executiontime%/DNS.txt

echo Getting IP Config
C:\WINDOWS\system32\ipconfig.exe /all > %executiontime%/IPConfig.txt

echo Getting Startup 
powershell -command Get-ItemProperty -Path Registry::HKLM:\Software\Microsoft\Windows\CurrentVersion\Group` Policy\Scripts\Startup > %executiontime%/startup.txt
C:\WINDOWS\system32\reg.exe QUERY HKLM\Software\Microsoft\Windows\CurrentVersion\Group` Policy\Scripts\Shutdown /s >> %executiontime%/startup.txt
powershell -command Get-ItemProperty -Path Registry::HKCU:\Environment >> %executiontime%/startup.txt

::Uncomment the line below if you want to include the Autoruns command line utility in the forensic agent run
::autorunsc.exe -accepteula -a * -c -vt -o autoruns.csv

echo Getting SMB Sessions
echo Inbound Sessions > %executiontime%/SMB.txt
C:\WINDOWS\system32\net.exe session >> %executiontime%/SMB.txt
echo Outbound Sessions >> %executiontime%/SMB.txt
C:\WINDOWS\system32\reg.exe QUERY "HKEY_USERS\Network" /s >> %executiontime%/SMB.txt

echo Getting Remote Desktop Sessions Information
C:\WINDOWS\system32\query.exe user > %executiontime%/RDS.txt

echo Getting Firewall Information
echo Getting Firewall Logs 
for /f "tokens=2 delims= " %%F in ('netsh advfirewall show currentprofile ^| findstr FileName') do cmd /C xcopy /F /Y /Q "%%F" "%%executiontime%"
echo Getting Firewall Rules
echo Firewall Rules > %executiontime%/fwrules.txt
netsh advfirewall firewall show rule name=all >> %executiontime%/fwrules.txt

echo Getting System Information
C:\WINDOWS\system32\systeminfo.exe > %executiontime%/system.txt
echo Drives >> %executiontime%/system.txt
wmic volume list brief >>%executiontime%/system.txt


echo Getting WMIC Installed Programs
C:\WINDOWS\system32\wbem\wmic.exe product get Caption,Description,IdentifyingNumber,InstallDate,InstallDate2,InstallLocation,InstallSource,InstallState,Language,LocalPackage,Name,PackageCache,PackageCode,PackageName,ProductID,Vendor,Version /format:csv > %executiontime%/InstalledPrograms.csv

echo Getting User Installed Programs
C:\WINDOWS\system32\reg.exe QUERY "HKEY_USERS\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s /fo CSV | find "," > UIP.csv

powershell command "-Get-ChildItem -Path Registry::HKCU:\Software -Recurse | Export-Csv -Path .\UIPHKCU.csv"
powershell command "-Get-ChildItem -Path Registry::HKLM:\Software -Recurse | Export-Csv -Path .\UIPHKLM.csv"
powershell -command "Get-Item -Path Registry::HKLM\SOFTWARE | Select-Object -ExpandProperty Property | Export-Csv -Path .'"
