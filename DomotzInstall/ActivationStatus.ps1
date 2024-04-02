# Define the HTTP endpoint URL
$StatusUrl = "http://127.0.0.1:3000/api/v1/status"

try {
        $StatusResponse = Invoke-RestMethod -Uri $StatusUrl
        
        # Check if the "mode" field is equal to "CONFIGURED"
        if ($StatusResponse.mode -eq "CONFIGURED") {
            Write-Output "Mode is $($StatusResponse.mode)"
            Write-Output "Installed version is $($StatusResponse.package.pkg_version)"
            $StatusResponse.mode | Out-File -FilePath c:\temp\domotzstatus.txt
            $StatusResponse.package.pkg_version | Out-File -FilePath c:\temp\domotzversion.txt
        } else {
            Write-Output "Mode is $($StatusResponse.mode)"
            $StatusResponse.mode | Out-File -FilePath c:\temp\domotzstatus.txt
        }
    } catch {
        Write-Host "No valid status from Domotz"
        Set-Content -Path c:\temp\domotzstatus.txt -Value 'UNKNOWN'
    }
