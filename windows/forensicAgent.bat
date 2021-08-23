@echo off
set _executiontime=powershell -command "[datetime]::now.tostring('yyyy-MM-dd_hh-mm')"
%_executiontime% > date.txt
set /p executiontime= < date.txt
%executiontime%
mkdir %executiontime%
del date.txt

::What is this? Why is it important?
echo MRU Results
C:\WINDOWS\system32\reg.exe QUERY "HKEY_USERS\SOFTWARE\Microsoft\Windows\Explorer\RunMRU" /s > %executiontime%/mruResults.txt

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

::Is there any way to filter through this ?
echo Getting Scheduled Tasks
C:\WINDOWS\system32\schtasks.exe /query /v /fo CSV > %executiontime%/schTasks.csv

::Why is this important?
echo Getting Local Groups
::C:\WINDOWS\system32\cmd.exe /C for /f "delims=*" %x in ('net localgroup ^|find "*"') do net localgroup "%x" > %executiontime%>LocalGroups.txt
::Why is this important? How is the output interpreted?
echo Getting ARP Cache
C:\WINDOWS\system32\arp.exe -a > %executiontime%/ARPCache.txt

::Why is this important? How is the output interpreted?
echo Getting DNS Cache
C:\WINDOWS\system32\ipconfig.exe /displaydns > %executiontime%/DNS.txt

::Why is this important? How is the output interpreted?
echo Getting IP Config
C:\WINDOWS\system32\ipconfig.exe /all > %executiontime%/IPConfig.txt

::Doesn't find the keys on my either work or personal laptop
::echo Getting Startup 
powershell -command Get-ItemProperty -Path Registry::HKLM:\Software\Microsoft\Windows\CurrentVersion\Group` Policy\Scripts\Startup > %executiontime%/startup.txt
::C:\WINDOWS\system32\reg.exe QUERY HKLM\Software\Microsoft\Windows\CurrentVersion\Group` Policy\Scripts\Shutdown /s >> %executiontime%/startup.txt

::You need the autorun executable for this
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
::for /f "tokens=2 delims= " %F in ('netsh advfirewall show currentprofile ^| findstr FileName') do cmd /C xcopy /F /Y /Q %F %CD%
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
C:\WINDOWS\system32\reg.exe QUERY "HKEY_USERS\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s > %executiontime%/UIP.txt

powershell -command "Get-ChildItem -Path HKCU:\Software -Recurse" >> %executiontime%/UIP.txt
echo HKLM >> UIP.txt
powershell -command "Get-ChildItem -Path HKLM:\Software -Recurse" >> %executiontime%/UIP.txt

//extract prefetch
//daily ssnapshots
//lookup ips from netstat and dns cache on VT
//parse prefetch, checksum check vt
//comparec 2 machines , golden image//automate whois//downloads
//poweshell usage
//extract master file with disk vopy