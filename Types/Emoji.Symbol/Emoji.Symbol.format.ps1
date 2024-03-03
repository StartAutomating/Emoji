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