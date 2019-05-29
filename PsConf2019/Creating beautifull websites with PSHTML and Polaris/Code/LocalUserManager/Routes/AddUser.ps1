
New-PolarisPostRoute -Path '/adduser' -Scriptblock {

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

   try{

        $SecurePassword = convertto-securestring -String $obj.Password -AsPlainText -Force
        $NewUserObject = New-LocalUser -Name $Obj.UserName -Password $SecurePassword -Description $obj.Description -ErrorAction stop
        $AdminGroup = Get-LocalGroup -Name "Administrators" -ErrorAction Stop
        Add-LocalGroupMember -Group $AdminGroup -Member $NewUserObject -ErrorAction Stop
        $Message = "Successfully created local admin user: $($obj.UserName)"
   }Catch{
       $Message = $_
   }

   $Response.Send($Message)
   

} -Force    

