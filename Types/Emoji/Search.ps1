<#
.SYNOPSIS
    Find Emoji
.DESCRIPTION
    Searches for Emoji
#>
param(
# One or more search patterns
[string[]]
$Pattern,

# If set, will search using the -like operator.  By default, will search using -match
[switch]
$Like
)

if (-not $this) {
    $this = Get-Module Emoji
}

foreach ($condition in $Pattern) {
    foreach ($namedEmoji in $this.Import()) {
        if ($like) {
            
            if ($namedEmoji.Name -like $condition) {
                $namedEmoji
            }
        } elseif ($namedEmoji.Name -match $condition) {
            $namedEmoji
        }
    }    
}
