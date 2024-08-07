<#
.SYNOPSIS
    Imports Emoji
.DESCRIPTION
    Imports all named Emoji from an -EmojiPath.

    If the -EmojiPath is not provided, it will import it's local copy
#>
param(
# The path to the emoji data
[string]
$EmojiPath,

# If set, will overwrite existing data.
[switch]
$Force
)


if (-not $this) {
    $this = Get-Module Emoji
}
if ((-not $this.'.EmojiCache') -or $Force) {
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".EmojiCache" -Value $this.DB.Tables['Symbol']    
}
$this.'.EmojiCache'