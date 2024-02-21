if (-not $this.'.Blocks') {
    $theseBlocks = [Ordered]@{}
    $allEmojiBlocks = Get-Module Emoji | Split-Path | Join-Path -ChildPath "Data" | Join-Path -ChildPath "AllEmojiBlocks.csv" | Import-Csv
    foreach ($emojiBlock in $allEmojiBlocks) {
        $emojiBlock.pstypenames.clear()
        $emojiBlock.pstypenames.add('Emoji.Block')
        $theseBlocks[$emojiBlock.BlockName] = $emojiBlock
    }
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".Blocks" -Value $theseBlocks
}

$this.'.Blocks'