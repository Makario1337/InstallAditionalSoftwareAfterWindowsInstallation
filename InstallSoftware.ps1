$exec_policy = Get-ExecutionPolicy 
$Appllication_List = (Get-Content "C:\temp\Install.csv")
 
function TestForAdminRights {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((TestForAdminRights) -eq $false)
{
if ($elevated) {
# elevation did not work, declining.
} else {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}

if($exec_policy -ne 'Bypass' ){
    Write-Host "Execution Policy is not set, please try again."
    exit
}
else { 
    foreach ( $Appilcation in $Appllication_List){

        $Install = $Appilcation.split(';')
        Clear-Host
        write-host "Now installing" $Install
        C:\ProgramData\chocolatey\bin\choco.exe install $Install -y | Out-File C:\temp\Install.log
    }
    Set-ExecutionPolicy Restricted  
    exit
}
