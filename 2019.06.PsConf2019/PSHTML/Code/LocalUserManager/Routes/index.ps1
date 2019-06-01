
New-PolarisGetRoute -Path "/index" -Scriptblock {
    import-module Microsoft.PowerShell.LocalAccounts
    $Response.SetContentType('text/html')
    
    $Group = Get-LocalGroup -Name "Administrators"
    $Users = Get-LocalGroupMember -Group $Group
    
    $HTML = html {
        head {
            

            #Bootstrap
            link -href "styles/bootstrap/bootstrap.min.css"
            script -src "styles/jquery/jquery-3.3.1.slim.min.js" -type "text/javascript"
            script -src "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            script -src "styles/bootstrap/bootstrap.min.js" -type "text/javascript"
            #link -href "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            #script -src "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" -type "text/javascript"

            #jquery
            #script -src "https://code.jquery.com/jquery-3.3.1.slim.min.js" -type "text/javascript"

            #ChartJS
            script -src "styles/chartjs/Chart.bundle.min.js" -type "text/javascript"
            title 'Local User Manager'
        }
        body {

            div -Class "container" -Content {

                $Group = Get-LocalGroup -Name "Administrators"
                $Users = Get-LocalGroupMember -Group $Group
    

                div -id "listmembers" -Content {
                    h3 "The Admin group $($Group.Name) contains $($Users.Count) users"
                    ConvertTo-PsHtmlTable -Object $Users -Properties "Name","SID"
                }
    
                div -Class "alert alert-primary" -Content "Plop testing"
    
                div -Id "add users" -content {
                    h3 {
                        "Add user:"
                    }
            
                    Form -action "/adduser" -method post -id "adduser" -Content {
                        
                        
                        "UserName"
                        input -type 'text' -name "UserName"
                        "Description"
                        input -type 'text' -name "Description"
                        "Password"
                        input -type 'password' -name "Password"
                        input -type submit -Name 'Create' -Id "btn_Create"
                    
                    } -enctype 'application/x-www-form-urlencoded' -target _self
            
            
                }
    
                #>
                
                
                div -id "removeuser" -Content {
    
                    h3 {
                        "Remove user:"
                    }
    
    
                    Form -action "/removeuser" -method post -id "removeuser" -Content {
                       
                        input -type submit -Name 'Submit' -Id "btn_submit"
            
                        SelectTag {
                            foreach($U in $Users){
                                option -value $($U.SID) -Content $($U.Name)
                            } 
                            
                            
                        } -Attributes @{name='UserSid'}
                
            
                    } -enctype 'application/x-www-form-urlencoded' -target _self
                }
                #>
            }
           
            
            
        }
    }
    $Response.Send($HTML)
}