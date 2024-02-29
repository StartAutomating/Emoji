<#
.SYNOPSIS
    Adds an Emoji sequence
.DESCRIPTION
    Adds an Emoji sequence to the cache 
#>
param(
# The Emoji Sequence
[string]
$EmojiSequence,

# The value of the Emoji sequence.
[PSObject]
$Value
)

$this | Add-Member NoteProperty $EmojiSequence -Value $value -Force