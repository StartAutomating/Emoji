<#
.SYNOPSIS
    Find Emoji
.DESCRIPTION
    Searches for Emoji
#>
param(
# The search pattern
[string]
$Pattern,

# If set, will search using the -like operator.  By default, will search using -match
[switch]
$Like
)

if (-not $this) {
    $this = Get-Module Emoji
}

foreach ($namedEmoji in $this.Import()) {
    if ($like) {
        if ($namedEmoji.Name -like $Pattern) {
            $namedEmoji
        }
    } elseif ($namedEmoji.Name -match $Pattern) {
        $namedEmoji
    }
}
