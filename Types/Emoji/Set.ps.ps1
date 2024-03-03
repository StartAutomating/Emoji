param(
[vbn()]
[string[]]
$EmojiSequence,

[vbn()]
[PSObject]
$Value,

[vbn()]
[scriptblock]
$ScriptBlock
)

$joinedSequence = $EmojiSequence -join ''

if ($ScriptBlock) {
    $Value = $ScriptBlock
}

$emoji.Sequence.Add($joinedSequence, $value)

    
