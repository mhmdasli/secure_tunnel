$ProgData = $env:PROGRAMDATA
$Dest_Folder = "$ProgData\SecureTunnel"
$User_Profile = $env:USERPROFILE
Set-ExecutionPolicy Bypass -Scope Process -Force
# dest
# Remove-Item  "$env:PROGRAMDATA\SecureTunnel" -Recurse -Force
New-Item -Path $env:PROGRAMDATA -Name "SecureTunnel" -ItemType "directory" -Force   

#build
ps2exe .\Program.ps1 "$Dest_Folder\SecureTunnel.exe" -iconFile .\ico.ico

# move items
# create shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Dest_Folder\SecureTunnel.lnk")
$Shortcut.TargetPath = "$Dest_Folder\SecureTunnel.exe"
$Shortcut.Save()


    
# start the app
Set-Location $Dest_Folder
Copy-Item "$User_Profile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Move-Item ".\SecureTunnel.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -Force
Start-Process powershell -windowstyle hidden ".\SecureTunnel.exe"
