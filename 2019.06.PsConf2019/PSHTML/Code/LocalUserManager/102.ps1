

using module Polaris
Import-Module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1  -Force
#Import-Module Polaris -Force
import-module Microsoft.PowerShell.LocalAccounts

New-PolarisStaticRoute -RoutePath "/styles" -FolderPath "./Styles" -Force

.\Routes\index.ps1
.\Routes\RemoveUser.ps1
.\Routes\Query.ps1
.\Routes\AddUser.ps1

$App = Start-Polaris -Port 8080 -Verbose
$App