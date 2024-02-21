@{
    ModuleVersion = '0.1'
    RootModule = 'Emoji.psm1'
    
    Description = '⟩⚡PowerShell Emoji 😎😉😍🥰🤔😟'

    FormatsToProcess = 'Emoji.format.ps1xml'
    TypesToProcess = 'Emoji.types.ps1xml'

    Guid = 'a82424bc-4a28-4151-8b9e-79289775c29b'
    CompanyName = 'Start-Automating'
    Author = 'James Brundage'
    Copyright = '2024 Start-Automating'

    PrivateData = @{
        PSData = @{
            ProjectURI = 'https://github.com/StartAutomating/Emoji'
            LicenseURI = 'https://github.com/StartAutomating/blob/main/LICENSE'
            Tags = 'Emoji', 'PowerShell'
        }
        Recommends = 'Posh','PipeScript','EZOut'
    }
}