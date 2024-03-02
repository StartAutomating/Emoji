<#
.SYNOPSIS
    Sets Emoji Sequences
.DESCRIPTION
    Sets the Emoji Sequences Collection.
.NOTES
    Any string arguments will be considered the sequence.
    The first non-string argument will be considered the value.
#>
param()

$unrolledArgs = $args | . { process { $_ } }

if (-not $this.'.Sequences') {
    $this  | Add-Member NoteProperty '.Sequences' (
        [PSCustomObject]@{PSTypeName='Emoji.Sequences'}
    ) -Force
}

$Value = $null
$emojiSequence = foreach ($arg in $unrolledArgs) {
    if ($arg -is [string]) {
        $arg
    } elseif (-not $value) {
        $value = $arg
    }
}

if ($emojiSequence -and $Value) {
    $this.'.Sequences'.Add($emojiSequence -join '', $value)
}


