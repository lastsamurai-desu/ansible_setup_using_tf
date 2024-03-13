#!/bin/bash

# Default location for Linux SSH config file
LINUX_SSH_CONFIG_PATH="$HOME/.ssh/config"

# Show all ansible host details
echo "Variable values:"
echo "USER: ${user}"
echo "HOSTNAME: ${hostname}"
echo "IDENTITYFILE: ${IdentityFile}"

# Check if the Host $user section already exists in the config file
if grep -q "Host ${user}" "${LINUX_SSH_CONFIG_PATH}"; then
    echo "Host section already exists, updating..."
    echo "Checking pattern matching..."
    cat "${LINUX_SSH_CONFIG_PATH}"
fi

# Read all lines from the SSH config file
Content=$(<"${LINUX_SSH_CONFIG_PATH}")

# Flag to indicate if the host section is found
hostSectionFound=false

# Iterate over each line in the SSH config file
while IFS= read -r line; do
    # Skip comment lines
    if [[ $line =~ ^# ]]; then
        continue
    fi
    
    if [[ $line =~ ^Host\s+${user}\s*$ ]]; then
        echo "Updating existing host section..."
        
        # Set the flag to indicate the host section is found
        hostSectionFound=true
        
        # Update the HostName, User, and IdentityFile lines
        sed -i "$((${LINENO} + 1))s/.*/    HostName ${hostname}/" "${LINUX_SSH_CONFIG_PATH}"
        sed -i "$((${LINENO} + 2))s/.*/    User ${user}/" "${LINUX_SSH_CONFIG_PATH}"
        sed -i "$((${LINENO} + 3))s/.*/    IdentityFile ${IdentityFile}/" "${LINUX_SSH_CONFIG_PATH}"
        
        # Exit the loop since the host section is updated
        break
    fi
done <<< "$Content"

# If the host section is not found, append it to the end of the file
if ! $hostSectionFound; then
    echo "Host section does not exist, appending..."
    echo "Host ${user}" >> "${LINUX_SSH_CONFIG_PATH}"
    echo "    HostName ${hostname}" >> "${LINUX_SSH_CONFIG_PATH}"
    echo "    User ${user}" >> "${LINUX_SSH_CONFIG_PATH}"
    echo "    IdentityFile ${IdentityFile}" >> "${LINUX_SSH_CONFIG_PATH}"
fi
