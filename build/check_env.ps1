
Write-Output "NOTE: Validating that required commands are found in your PATH."
$commands = @("aws", "packer", "terraform")
$all_found = $true

foreach ($cmd in $commands) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Error "ERROR: $cmd is not found in the current PATH."
        $all_found = $false
    } else {
        Write-Output "NOTE: $cmd is found in the current PATH."
    }
}

if ($all_found) {
    Write-Output "NOTE: All required commands are available."
} else {
    Write-Error "ERROR: One or more commands are missing."
    exit 1
}

Write-Output "NOTE: Checking AWS CLI connection."
try {
    $account = aws sts get-caller-identity --query "Account" --output text
    Write-Output "NOTE: Successfully logged in to AWS."
} catch {
    Write-Error "ERROR: Failed to connect to AWS. Please check your credentials and environment variables."
    exit 1
}
