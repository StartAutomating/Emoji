Write-FormatView -TypeName Emoji.Symbol -Property Emoji, Name, Hex -AlignProperty @{
    Emoji = 'Left'
    Hex   = 'Right'
    Name  = 'Center'
} -AutoSize -VirtualProperty @{
    Emoji = { $_.Emoji.ToString().PadRight(3) }
} -StyleProperty @{
    Hex = 'Foreground.Cyan'
    Name = 'Foreground.Green'
}

Write-FormatView -TypeName Emoji.Symbol -Action {
    Write-FormatViewExpression -ScriptBlock {
        $_.Emoji.PadRight(4)
    }

    Write-FormatViewExpression -Property Name -Style Foreground.Green
}
