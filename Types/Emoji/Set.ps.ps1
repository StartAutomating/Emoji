<#
.SYNOPSIS
    Sets an Emoji
.DESCRIPTION
    Sets an Emoji Sequence.

    This creates a command or variable (using some emoji), and sets it to a -Value or -ScriptBlock.

    If a -Value or -ScriptBlock is not provided, the -Value will default to a [ScriptBlock] that outputs the sequence.
#>
param(
# The Emoji Sequence.
[vbn()]
[string[]]
$EmojiSequence,

# The value to set.
[vbn()]
[PSObject]
$Value,

# A ScriptBlock value.  If provided, this will override -Value.
[vbn()]
[scriptblock]
$ScriptBlock
)

$joinedSequence = $EmojiSequence -join ''

if ($ScriptBlock) {
    $Value = $ScriptBlock
}

if (-not $value) {
    $value = [ScriptBlock]::Create("'$($joinedSequence -replace "'","''")'")
}

$emoji.Sequence.Add($joinedSequence, $value)

    
