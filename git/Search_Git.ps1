param (
    [string]$search = $( Read-Host "Search" ),
    [string]$gitDirectory = ".git",
    [int]$context = 2
)

$(git --git-dir $gitDirectory log --oneline -G $search) | 
    Select-String -Pattern "^([a-zA-Z0-9]+)\s(.+)$" -List | 
    Foreach-Object { 
        $(git --git-dir $gitDirectory show $_.Matches[0].Groups[1].Value) | 
            Select-String -Context $context $search
    } |
        Out-Host -Paging
