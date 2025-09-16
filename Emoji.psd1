@{
    ModuleVersion = '0.1.6'
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
            ReleaseNotes = @'
## Emoji 0.1.6:

* `Emoji.Symbol.ToString()` (#93)
* Workflow fix (#92)
* `Emoji.Symbol.get_HTML` includes a class (#91)

---

Full history in [CHANGELOG](https://github.com/StartAutomating/Emoji/blob/main/CHANGELOG.md)

> Like It? [Star It](https://github.com/StartAutomating/Emoji)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)

'@
        }
        Recommends = 'Posh','PipeScript','EZOut'
    }
}