param(
[Parameter(ValueFromPipelineByPropertyName)]
[string[]]
$EmojiSequence,

[Parameter(ValueFromPipelineByPropertyName)]
[PSObject]
$Value,

[Parameter(ValueFromPipelineByPropertyName)]
[scriptblock]
$ScriptBlock
)

$joinedSequence = $EmojiSequence -join ''

if ($ScriptBlock) {
    $Value = $ScriptBlock
}

$emoji.Sequence.Add($joinedSequence, $value)

    

