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
    if (-not $EmojiPath) {
        $EmojiPath = $this | 
            Split-Path | 
            Join-Path -ChildPath Data | 
            Join-Path -ChildPath "AllNamedEmoji.csv"
    }
    if (Test-Path $EmojiPath) {
        $impoterNoun = @($EmojiPath -split '[\\/]')[-1] -replace '.+\.'
        $importers = $ExecutionContext.SessionState.InvokeCommand.GetCommands("Import-$impoterNoun", 'Function,Cmdlet,Alias', $true)
        if ($importers -and $importers.Count -eq 1) {
            $importedEmojiList = & $importers $EmojiPath
            if ($importedEmojiList.Length -gt 1 -and $importedEmojiList[0].Hex -match '[0-9a-f]{4,}') {                                
                Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".EmojiCache" -Value @(foreach ($importedEmoji in $importedEmojiList) {
                    $importedEmoji.pstypenames.insert(0,'Emoji.Symbol')
                    $importedEmoji
                })
            }
        }
    }
}
$this.'.EmojiCache'