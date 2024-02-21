Write-FormatView -TypeName Emoji.Block -Property 'Start', 'BlockName', 'End' -AlignProperty @{
    Start = 'Right'
    End   = 'Left'
    BlockName  = 'Center'
} -Width 8, 8, 0 -AutoSize
