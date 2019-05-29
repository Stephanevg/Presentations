#http://chen.about-powershell.com/2018/10/auto-refresh-polaris-page-to-retrieve-status-using-pshtml/

New-PolarisGetRoute -Path "/Service" -Scriptblock {
    $HTML = html {
        head {
            Title "Auto Refresh"
            meta -httpequiv "refresh" -content "10"
        }
        body {
            hr 
            h1 "Get-Service"
            hr 
            Table -ChildItem {
                tr -Content {
                    Th -Content "Name"
                    Th -Content "Status"
                }
                tr -Content {
                    foreach ($Service in (Get-Service | Select -First 10)) {
                        tr -Content {
                            td -Content {
                                $Service.Name
                            }
                            if ($Service.Status -eq "Running") {
                                td -Content {
                                    $Service.Status
                                } -Style "color:GREEN"
                            }
                            else {
                                td -Content {
                                    $Service.Status
                                } -Style "color:RED"
                            }
                        }
                    }
                } -Id "customers" -Attributes @{"border"="1"}
            } 
        } -Style "font-family:Candara"
    }
    $Response.SetContentType('text/html')
    $Response.Send($HTML)
}

Using module Polaris

.\routes\home.ps1
.\routes\Service.ps1

Start-Polaris -Port 8080