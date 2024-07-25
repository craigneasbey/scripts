param (
    [string]$search = $( Read-Host "Search" )
)

$(git log --oneline -G $search) | 
    Select-String -Pattern "^([a-zA-Z0-9]+)\s(.+)$" -List | 
    Foreach-Object { 
        $(git show $_.Matches[0].Groups[1].Value) | 
            Select-String -Context 4 $search
    } |
        Out-Host -Paging
