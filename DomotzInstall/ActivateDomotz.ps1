# Domotz Agent -- Powershell script (this is just an example you can customize it the way you want)

# Please edit the following lines 
$ApiEndpoint = "https://api-us-east-1-cell-1.domotz.com/public-api/v1/"

$AgentUrl = "https://portal.domotz.com/download/agent_packages/domotz-windows-x64-10.exe"

$WindowsAgentInstallerFile = "$PSScriptRoot\domotz-windows-x64-10.exe"
$WindowsAgentInstallerDir = $PSScriptRoot
$StatusUrl = "http://127.0.0.1:3000/api/v1/status"
$ActivationUrl = "http://127.0.0.1:3000/api/v1/agent"
$ActivationHeaders = @{
    "X-API-Key" = $ActivationKey
}
$ActivationBody = @{
    "name" = $AgentName
    "endpoint" = $ApiEndpoint

} | ConvertTo-Json

$IsRunning = $false
do {
    try {
        $StatusResponse = Invoke-RestMethod -Uri $StatusUrl
        $IsRunning = $true
        Write-Host "Agent is running. Proceeding with activation."
    } catch {
        Write-Host "Waiting for Agent to start, please wait..."
        Start-Sleep -s 2
    }
}
while ($IsRunning -eq $false)

# Activate Agent with name provided in $AgentName
try {
    Invoke-RestMethod -Uri $ActivationUrl -Method Post -Headers $ActivationHeaders -ContentType "application/json" -Body $ActivationBody
    Write-Host "Agent activated"
} catch {
    Write-Host "Something went wrong during agent activation"
    Write-Host "Status Code: " $_.Exception.Response.StatusCode.value__
    $BodyError = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
    $BodyError.BaseStream.Position = 0
    $BodyError.ReadToEnd()
}
