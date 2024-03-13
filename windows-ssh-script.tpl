
# Show all ansible host details
Write-Output "Variable values:"
Write-Output "USER: ${user}"
Write-Output "HOSTNAME: ${hostname}"
Write-Output "IDENTITYFILE: ${IdentityFile}"

# Check if the Host $user section already exists in the config file
if (Select-String -Path ${SSH_CONFIG_PATH} -Pattern "Host ${user}") {
    Write-Output "Host section already exists, updating..."  
    Write-Output "Checking pattern matching..."
    Get-Content ${SSH_CONFIG_PATH}
}
    # Read all lines from the SSH config file
    $Content = Get-Content ${SSH_CONFIG_PATH}
    
    # Flag to indicate if the host section is found
    $hostSectionFound = $false
    
    # Iterate over each line in the SSH config file
    for ($i = 0; $i -lt $Content.Count; $i++) {
        # Skip comment lines
        if ($Content[$i] -match "^#") {
            continue
        }
        
        if ($Content[$i] -match "^Host\s+${user}\s*$") {
            Write-Output "Updating existing host section..."
    
            # Set the flag to indicate the host section is found
            $hostSectionFound = $true
    
            # Update the HostName, User, and IdentityFile lines
            $Content[$i+1] = "    HostName ${hostname}"
            $Content[$i+2] = "    User ${user}"
            $Content[$i+3] = "    IdentityFile ${IdentityFile}"
            
            # Exit the loop since the host section is updated
            break
        }
    }
    
    # If the host section is not found, append it to the end of the file
    if (-not $hostSectionFound) {
        Write-Output "Host section does not exist, appending..."
        $Content += "Host ${user}"
        $Content += "    HostName ${hostname}"
        $Content += "    User ${user}"
        $Content += "    IdentityFile ${IdentityFile}"
    }
    
    # Write the updated content back to the SSH config file
    $Content | Set-Content ${SSH_CONFIG_PATH}
    


