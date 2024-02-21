## Emoji 0.1:

### Initial Release of Emoji

* Emoji is PowerShell Module for Emoji (#1)
* It is built from the [Unicode Character Dataset](https://unicode.org/Public/UCD/latest/ucd/), using [PipeScript](https://github.com/StartAutomating/PipeScript) (#2)
* It builds an object model around Emoji, using [EZOut](https://github.com/StartAutomating/EZOut)
* That model is used as the basis for a single command, `Emoji` (#4)
* The `Emoji` function can be accessed with several verbs:
  * Import-Emoji imports (#5)
  * Find/Search-Emoji searches loaded emoji (#6)
  * Get-Emoji gets emoji (#7)
  * Set-Emoji sets variables or functions (#8)
  * Export-Emoji exports named characters (#13)
* `Emoji.Symbol` types make each emoji nicer to work with:
  * By formatting nicely (#10)
  * By adding a ScriptProperty, .Number (#11)
  * By aliasing an AliasProperty, .Emoji (#12)

---

Full history in [CHANGELOG](https://github.com/StartAutomating/Emoji/blob/main/CHANGELOG.md)

Like it?  Star It!  Love it?  Support It!