$exec_policy = Get-ExecutionPolicy 
$Appllication_List = (Get-Content "c:\temp\toinstall.csv")

 
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
Exit
}

if($exec_policy -ne 'Bypass' ){
    Write-Host "Execution Policy is not set, please try again."
    exit
}
else { 
    foreach ( $Appilcation in $Appllication_List){

        $Install = $Appilcation.split(';')
        choco install $Install -y 
    }
    exit
}
