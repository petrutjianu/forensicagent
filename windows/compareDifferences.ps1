#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\UIPHKCU.csv'))
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\UIPHKCU.csv'))
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property PSPath -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Key = If ($R.PSPath -eq "") {"Unknown"} Else {$R.PSPath}
            
           
 
        }
        $Array += $Object
    }
}
 
#Display results in console
If($Array.Count -eq 0) {"No differences in UIPHKCU"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\schTasks.csv'))
 
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\schTasks.csv'))
 
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property "Task To Run",TaskName -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{

	    TaskName = $R.PSObject.Properties["TaskName"]
           Task = $R.PSObject.Properties["Task To Run"]
           # "Compare indicator" = $R.sideindicator
 
        }
        $Array += $Object
    }
}
 
#Display results in console
If($Array.Count -eq 0) {"No differences in scheduled tasks"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\UIPHKLM.csv'))
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\UIPHKLM.csv'))
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property PSPath -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Key = If ($R.PSPath -eq "") {"Unknown"} Else {$R.PSPath}
            
           
 
        }
        $Array += $Object
    }
}
 
#Display results in console
If($Array.Count -eq 0) {"No differences in UIPHKLM"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\InstalledPrograms.csv'))
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\InstalledPrograms.csv'))
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property InstallLocation,InstallSource -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Location = If ($R.InstallLocation -eq "") {"Unknown"} Else {$R.InstallLocation}
            Source = $R.InstallSource
          
        }
        $Array += $Object
    }
}
 
 
#Display results in console
If($Array.Count -eq 0) {"No differences"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\ProcessList.csv')) -Header Node,Caption,CommandLine,CreationClassName,CreationDate,CSCreationClassName,CSName,Description,ExecutablePath,ExecutionState,Handle,HandleCount,InstallDate,KernelModeTime,MaximumWorkingSetSize,MinimumWorkingSetSize,Name,OSCreationClassName,OSName,OtherOperationCount,OtherTransferCount,PageFaults,PageFileUsage,ParentProcessId,PeakPageFileUsage,PeakVirtualSize,PeakWorkingSetSize,Priority,PrivatePageCount,ProcessId,QuotaNonPagedPoolUsage,QuotaPagedPoolUsage,QuotaPeakNonPagedPoolUsage,QuotaPeakPagedPoolUsage,ReadOperationCount,ReadTransferCount,SessionId,Status,TerminationDate,ThreadCount,UserModeTime,VirtualSize,WindowsVersion,WorkingSetSize,WriteOperationCount,WriteTransferCount

#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\ProcessList.csv')) -Header Node,Caption,CommandLine,CreationClassName,CreationDate,CSCreationClassName,CSName,Description,ExecutablePath,ExecutionState,Handle,HandleCount,InstallDate,KernelModeTime,MaximumWorkingSetSize,MinimumWorkingSetSize,Name,OSCreationClassName,OSName,OtherOperationCount,OtherTransferCount,PageFaults,PageFileUsage,ParentProcessId,PeakPageFileUsage,PeakVirtualSize,PeakWorkingSetSize,Priority,PrivatePageCount,ProcessId,QuotaNonPagedPoolUsage,QuotaPagedPoolUsage,QuotaPeakNonPagedPoolUsage,QuotaPeakPagedPoolUsage,ReadOperationCount,ReadTransferCount,SessionId,Status,TerminationDate,ThreadCount,UserModeTime,VirtualSize,WindowsVersion,WorkingSetSize,WriteOperationCount,WriteTransferCount


#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property "ExecutablePath","CommandLine","Name" -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            ExecutablePath = $R.PSObject.Properties["ExecutablePath"]
            CommandLine = $R.PSObject.Properties["CommandLine"]
            Name = $R.PSObject.Properties["Name"]
          
 
        }
        $Array += $Object
    }
}
 
 
#Display results in console
If($Array.Count -eq 0) {"No differences in processes"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\ServiceList.csv')) - Header Node,AcceptPause,AcceptStop,Caption,CheckPoint,CreationClassName,DelayedAutoStart,Description,DesktopInteract,DisplayName,ErrorControl,ExitCode,InstallDate,Name,PathName,ProcessId,ServiceSpecificExitCode,ServiceType,Started,StartMode,StartName,State,Status,SystemCreationClassName,SystemName,TagId,WaitHint
 
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\ServiceList.csv')) - Header Node,AcceptPause,AcceptStop,Caption,CheckPoint,CreationClassName,DelayedAutoStart,Description,DesktopInteract,DisplayName,ErrorControl,ExitCode,InstallDate,Name,PathName,ProcessId,ServiceSpecificExitCode,ServiceType,Started,StartMode,StartName,State,Status,SystemCreationClassName,SystemName,TagId,WaitHint
 
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property "Name","PathName" -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Name=$R.PSObject.Properties["Name"]
            FilePath = $R.PSObject.Properties["PathName"]
          
 
        }
        $Array += $Object
    }
}
 
 
#Display results in console
If($Array.Count -eq 0) {"No differences in services"} Else {$Array}

#Importing CSV
$File1 = Import-Csv -Path (-join($args[0],'\autoruns.csv'))
 
#Importing CSV 
$File2 = Import-Csv -Path (-join($args[1],'\autoruns.csv'))
#Compare both CSV files
$Results = Compare-Object  $File1 $File2 -Property InstallLocation,InstallSource -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "=>" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Location = If ($R.Path.length -lt 2) {"Unknown"} Else {$R.Path}
 
        }
        $Array += $Object
    }
}
 
#Display results in console
If($Array.Count -eq 0) {"No differences from autoruns"} Else {$Array}