Write-FormatView -TypeName Emoji.Symbol -Property Emoji, Name, Hex -AlignProperty @{
    Emoji = 'Center'
    Hex = 'Left'
    Name = 'Center'
} -Width 6, 0, 0 -AutoSize
