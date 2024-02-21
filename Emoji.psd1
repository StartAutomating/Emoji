@{
    ModuleVersion = '0.1.1'
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
## Emoji 0.1.1:

### More Emoji

* Find/Search-Emoji improvements:
  * Supporting Multiple -Patterns (#15 ) (thanks @I-Am-Jakoby !)  
  * Supporting -Word (#16)
* Get-Emoji:
  * Get-Emoji -Block (#23)
  * Get-Emoji -First/-Skip (#26)
* Emoji Block Support:
  * `Emoji.get_Blocks` (#17)  
  * Emoji.Block pseudotype (#18, #19, #20, #21, #22)
* Added Logo (#28)
  
---

Full history in [CHANGELOG](https://github.com/StartAutomating/Emoji/blob/main/CHANGELOG.md)

Like it?  Star It!  Love it?  Support It!
'@
        }
        Recommends = 'Posh','PipeScript','EZOut'
    }
}