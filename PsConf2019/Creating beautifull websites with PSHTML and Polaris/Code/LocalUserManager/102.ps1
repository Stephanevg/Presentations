

using module "\\ss002207\TAAVAST3$\Documents\WindowsPowerShell\Modules\Polaris\0.2.0\Polaris.psd1"
Import-Module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1  -Force
#Import-Module Polaris -Force
import-module Microsoft.PowerShell.LocalAccounts

New-PolarisStaticRoute -RoutePath "/bootstrap" -FolderPath "./Styles/Bootstrap" -Force
New-PolarisStaticRoute -RoutePath "/chartjs" -FolderPath "./Styles/Chartjs" -Force
New-PolarisStaticRoute -RoutePath "/jquery" -FolderPath "./Styles/jquery" -Force
New-PolarisStaticRoute -RoutePath "/styles" -FolderPath "./Styles" -Force
New-PolarisStaticRoute -RoutePath "/routes" -FolderPath "./Routes" -Force
.\Routes\index.ps1
.\Routes\RemoveUser.ps1
.\Routes\Query.ps1
.\Routes\AddUser.ps1

$App = Start-Polaris -Port 8080 -Verbose
$App