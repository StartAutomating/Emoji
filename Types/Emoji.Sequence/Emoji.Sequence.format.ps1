Write-FormatView -TypeName Emoji.Sequence -Property Name, ExportedCommands, ExportedVariables -VirtualProperty @{
    ExportedCommands = { $_.ExportedCommands.Keys -join [Environment]::NewLine }
    ExportedVariables = { $_.ExportedVariables.Keys -join [Environment]::NewLine }
} -Wrap