$html = html {
    head {
        title 'Adding logic'
        
    }
    body {
        h2 {
            "Local User Report:"
        }

        $AdminGroup = Get-LocalGroup -Name "administrators"
        $Users = Get-LocalGroupMember -Group $AdminGroup

        h3 "The group $($AdminGroup.Name) contains $($Users.Count) users"

        ConvertTo-PsHtmlTable -Object $Users -Properties "Name","SID"


        h2 {
            "Fix user:"
        }

        SelectTag {
            foreach($U in $Users){

                option -value $U.SID -Content $U.Name
            }
            
        }

        button -Content "Fix"
    }
}

$Path = ".\007.html"
$Html | Out-File -FilePath $Path -Encoding utf8
Start $Path 