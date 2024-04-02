# Define the HTTP endpoint URL
$endpointUrl = "http://127.0.0.1:3000/api/v1/status"

# Send the HTTP request and store the response
$response = Invoke-RestMethod -Uri $endpointUrl -Method Get

# Check if the response is successful (status code 200)
if ($response.StatusCode -eq 200) {
    # Parse the JSON response
    $jsonData = $response.Content | ConvertFrom-Json
    
    # Check if the "mode" field is equal to "CONFIGURED"
    if ($jsonData.mode -eq "CONFIGURED") {
        Write-Output "Mode is CONFIGURED"
        # You can add further actions here if needed
    } else {
        Write-Output "Mode is not CONFIGURED"
        # You can add alternative actions here if needed
    }
} else {
    Write-Output "Failed to fetch data from the endpoint"
    # You can handle other status codes here if needed
}
