param (
    [string]$search = $( Read-Host "Search" )
)

$(git log --oneline -- "**/*$($search)*") | 
    Select-String -Pattern "^([a-zA-Z0-9]+)\s(.+)$" -List | 
    Foreach-Object { 
        $(git show --pretty="" --name-only  $_.Matches[0].Groups[1].Value)
    } |
        Out-Host -Paging
