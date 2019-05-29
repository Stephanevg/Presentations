# Connect against Meetup.com API
import-module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1 -force
#Import-Module MeetupPS

$MeetupGroupName = 'FrenchPSUG'
$Key = "1tuvvavlcf38a2f5r4skeorjed"
#$Secret = #
#Set-MeetupConfiguration -ClientID $Key -Secret $Secret


$CanvasID = "canvasAttendance"
$Html = html { 
    head {
        title 'PSHTML Charts using Charts.js'
        
    }
    body {
        
        h1 "Generated using PSHTML"

        div {

           p {
               "The following chart has been generated using PSHTML Chart.js and MeetupPS"
           }
           canvas -Height 600 -Width 800 -Id $CanvasID {
    
           }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            
            $Data = Get-MeetupEvent -GroupName $MeetupGroupName -Status past | Sort 'local_date' | select Local_date,yes_rsvp_count
            #$dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )
            #$DataSetMeetup = [dataSet]::New($Data.'yes_rsvp_count',"Num Attendees")
            $DataSetMeetup = New-PSHTMLChartBarDataSet -Data $data.'yes_rsvp_count' -label "Num Attendees" -backgroundColor blue
            #$DataSetMeetup.backgroundColor = [Color]::blue
            $MeetupLabels = $data.'local_date'
            New-PSHTMLChart -type bar -DataSet $DataSetMeetup -title "FRPSUG meetup Statistics over time" -Labels $MeetupLabels -canvasID $CanvasID 
           
        }

         
    }
}

$Path = ".\009.html"
$Html | Out-File -FilePath $Path -Encoding utf8
Start $Path