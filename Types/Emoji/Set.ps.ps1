param(
[vbn()]
[string[]]
$EmojiSequence,

[vbn()]
[PSObject]
$Value
)

$joinedSequence = $EmojiSequence -join ''

$emoji.Sequence = $joinedSequence, $value

    
