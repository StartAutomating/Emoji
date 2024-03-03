<#
.SYNOPSIS
    Adds an Emoji sequence
.DESCRIPTION
    Adds an Emoji sequence to the cache 
#>
param(
# The Emoji Sequence
[string]
$EmojiSequence,

# The value of the Emoji sequence.
[PSObject]
$Value
)


if (-not $EmojiSequence) { return }
$dynamicModule = 
    if ($EmojiSequence -and $value -is [ScriptBlock]) {        
        New-Module -Name $EmojiSequence -ScriptBlock ([ScriptBlock]::Create(
            "function $EmojiSequence {
                . `${$EmojiSequence}
            }

            `${$EmojiSequence} = `$args[0]

            Export-ModuleMember -Function * -Variable * -Alias *"
        )) -ArgumentList $value    
    }     
    else {
        New-Module -Name $EmojiSequence -ScriptBlock ([ScriptBlock]::Create(
            "`${$EmojiSequence} = `$args[0]
            Export-ModuleMember -Function * -Variable * -Alias *"
        )) -ArgumentList $value
    }

if ($dynamicModule) {
    $dynamicModule | Import-Module -Global -Force -DisableNameChecking -PassThru
    $this | Add-Member NoteProperty $EmojiSequence -Value $dynamicModule -Force
} else {
    $this | Add-Member NoteProperty $EmojiSequence -Value $value -Force
}