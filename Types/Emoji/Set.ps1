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
[Parameter(ValueFromPipelineByPropertyName)]
[string[]]
$EmojiSequence,

# The value to set.
[Parameter(ValueFromPipelineByPropertyName)]
[PSObject]
$Value,

# A ScriptBlock value.  If provided, this will override -Value.
[Parameter(ValueFromPipelineByPropertyName)]
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

    

