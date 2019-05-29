#Polaris basics
    #Minimal web framework for PowerShell

#Install Polaris
    Find-Module Polaris | install-Module

#First step
    
New-PolarisGetRoute -Path "/helloworld" -Scriptblock {
    $Response.Send('Hello World!')
}

Start-Polaris

#Polaris will return strings. That string can be interpreted by a webbrowser, or not...

Invoke-RestMethod -Method GET -Uri http://localhost/helloworld:8080/


New-PolarisGetRoute -Path "/Processes" -Scriptblock {
    $RunningProcesses = Get-Process | select ProcessName,CPU,Id | ConvertTo-Html -Title "Processes" | Out-String
    $Response.SetContentType("text/html")
    $Response.Send($RunningProcesses)
 }

start "http://localhost/Process:8080/"