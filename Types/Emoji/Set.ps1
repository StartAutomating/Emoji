param(
[Parameter(ValueFromPipelineByPropertyName)]
[string[]]
$EmojiSequence,

[Parameter(ValueFromPipelineByPropertyName)]
[PSObject]
$Value
)

$joinedSequence = $EmojiSequence -join ''

$emoji.Sequence = $joinedSequence, $value

    

