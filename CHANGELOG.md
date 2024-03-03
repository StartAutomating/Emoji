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

## Emoji 0.1.2:

### Updating Emoji:

* Paging Parameter Fixes:
  * Emoji.GetPagingParameters (#32)
  * Search-Emoji Paging (#34)
  * Get-Emoji Paging (#30)
* Adding Emoji.tests.ps1 (#33)

---

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