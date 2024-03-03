@{
    ModuleVersion = '0.1.3'
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
## Emoji 0.1.3:

* Improved Formatting
    * Now with Color (and better padding) (#46)
    * Adding Custom formats (#47)
    * Adding PowerShell formats (#49)
* Emoji Sequences:
    * Get-Emoji -Sequence (#55)
    * Emoji.Sequences.All (#41)
    * Emoji.Sequences.Add (#39)
    * Emoji.Sequences.Remove (#40)
    * Emoji.get/set Sequence (#35)
    * Sequence Formatting (#54)
* Added `Emoji.get_Demos` (#42)
* Added `/Demos/Emoji.demo.ps1` (#43)
* Set-Emoji
    * Added -ScriptBlock (#51)
    * Defaulting Value (#52)

---

Full history in [CHANGELOG](https://github.com/StartAutomating/Emoji/blob/main/CHANGELOG.md)

Like it?  Star It!  Love it?  Support It!
'@
        }
        Recommends = 'Posh','PipeScript','EZOut'
    }
}