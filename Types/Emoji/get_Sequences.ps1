<#
.SYNOPSIS
    Emoji Sequences
.DESCRIPTION
    Gets the Emoji Sequences Collection
#>
if (-not $this.'.Sequences') {
    $this  | Add-Member NoteProperty '.Sequences' (
        [PSCustomObject]@{PSTypeName='Emoji.Sequences'}
    ) -Force
}

$this.'.Sequences'