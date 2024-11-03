# Define the services to check
$services = @(
    "GlobalSecureAccessAutoUpgradeService",
    "GlobalSecureAccessClient",
    "GlobalSecureAccessManagementService",
    "GlobalSecureAccessPolicyRetrieverService",
    "GlobalSecureAccessTunnelingService"
)

# Initialize the custom settings results
$customSettings = @{}

# Function to check if a service is running
function Check-ServiceRunning {
    param (
        [string]$serviceName
    )

    # Get the service object
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

    # Check if the service is running and record the result in custom settings
    if ($null -ne $service -and $service.Status -eq 'Running') {
        $customSettings[$serviceName] = @{
            Running = $true
        }
    } else {
        $customSettings[$serviceName] = @{
            Running = $false
        }
    }
}

# Loop through each service to check if it's running
foreach ($service in $services) {
    Check-ServiceRunning -serviceName $service
}

# Output the custom settings as JSON
$customSettings | ConvertTo-Json -Compress
