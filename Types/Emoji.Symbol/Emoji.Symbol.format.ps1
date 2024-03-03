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

Write-FormatView -TypeName Emoji.Symbol -Property Emoji, Name, PowerShell -AlignProperty @{
    Emoji = 'Left'
    PowerShell   = 'Right'
    Name  = 'Center'
} -AutoSize -VirtualProperty @{
    Emoji = { $_.Emoji.ToString().PadRight(3) }
} -StyleProperty @{
    Hex = 'Foreground.Cyan'
    Name = 'Foreground.Green'
} -Name PowerShell

Write-FormatView -TypeName Emoji.Symbol -Property Emoji -AlignProperty @{
    Emoji = 'Left'
} -AutoSize -Name Emoji

Write-FormatView -TypeName Emoji.Symbol -Action {
    Write-FormatViewExpression -ScriptBlock {
        $_.Emoji.PadRight(4)
    }

    Write-FormatViewExpression -Property Name -Style Foreground.Green
}

Write-FormatView -TypeName Emoji.Symbol -Action {
    Write-FormatViewExpression -Property Emoji
} -Name Emoji

Write-FormatView -TypeName Emoji.Symbol -Action {
    Write-FormatViewExpression -ScriptBlock {
        $_.Emoji.PadRight(4)
    }

    Write-FormatViewExpression -Property PowerShell -Style Foreground.Cyan

    Write-FormatViewExpression -Property Name -Style Foreground.Green
} -Name PowerShell