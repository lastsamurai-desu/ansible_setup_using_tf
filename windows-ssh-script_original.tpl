add-content -path c:/users/kjwat/.ssh/config -value @'

Host ${user}
   HostName ${hostname}
   User ${user}
   IdentityFile ${IdentityFile}
'@
