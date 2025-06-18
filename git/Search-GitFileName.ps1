param (
    [string]$search = $( Read-Host "Search" ),
    [string]$gitDirectory = ".git"
)

$(git --git-dir $gitDirectory log --oneline -- "**/*$($search)*") | 
    Select-String -Pattern "^([a-zA-Z0-9]+)\s(.+)$" -List | 
    Foreach-Object { 
        $(git --git-dir $gitDirectory show --pretty="" --name-only  $_.Matches[0].Groups[1].Value)
    } |
        Out-Host -Paging
