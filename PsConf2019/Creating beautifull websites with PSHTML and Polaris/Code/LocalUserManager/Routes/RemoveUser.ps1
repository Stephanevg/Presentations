
New-PolarisPostRoute -Path "/removeuser" -Scriptblock {
    
    $Response.SetContentType('application/json')
    $Body = [System.Web.HttpUtility]::UrlDecode($Request.BodyString)
    $Body = [System.Web.HttpUtility]::UrlDecode($Request.BodyString)
    $Data = @{}
    $Body.split('&') | %{
        $part = $_.split('=')
        $Data.add($part[0], $part[1])
    }
    $Json = $Data | ConvertTo-Json
    $obj = $Json | ConvertFrom-Json

    $Group = Get-LocalGroup -Name 'Administrators'
    $LocalUser = Get-LocalUser -SID $Obj.UserSid
    If($LocalUser){
        Write-Verbose "Removing user $($LocalUser.FullName)"
        Try{

            Remove-LocalGroupMember -Group $Group -Member $LocalUser -ErrorAction Stop
            $Message = "Successfully removed user $($LocalUser.Name) with SID: $($Obj.UserSid)"
        }Catch{
            $Message = $_
        }
    }else{
        $Message = "No user found with SID: $($Obj.UserSid)"
    }
     $Response.Send($Message)
     
} -force

