$html = html {
    head {
        title 'Export to table'
        link -href 'assets/home.css' -rel 'stylesheet'
    }
    body {
        p {
            "My favorite car is:"
        }
        SelectTag {
            option -value "Citroen" -Content "Citroen"
            option -value "Renault" -Content "Renault"
            option -value "Peugeot" -Content "Peugeot"
            option -value "DS" -Content "DS"
        }
    }
}

$Path = ".\006.html"
$Html | Out-File -FilePath $Path -Encoding utf8
Start $Path 