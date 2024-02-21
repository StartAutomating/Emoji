<#
.SYNOPSIS
    Exports Emoji
.DESCRIPTION
    Exports All Named Emoji.
#>
param(
# The export path.
[string]
$EmojiPath,

# If set, will overwrite any file at the exportPath
[switch]
$Force
)


if (-not $this) {
    $this = Get-Module Emoji
}
if ($this.'.EmojiCache') {
    $exporterNoun = @($EmojiPath -split '[\\/]')[-1] -replace '.+\.'
    $exporters = $ExecutionContext.SessionState.InvokeCommand.GetCommands("Export-$exporterNoun", 'Function,Cmdlet,Alias', $true)
    if ($exporters -and $exporters.Count -eq 1) {        
        $this.'.EmojiCache' | & $exporters $EmojiPath
        Get-Item $EmojiPath
    }
}