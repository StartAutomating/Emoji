<#
.SYNOPSIS
    Gets one or more Emoji
.DESCRIPTION
    Gets Emoji by exact name or number.

    If neither name or number is provided, returns the Emoji module.
#>
param(
[ArgumentCompleter({
    param ( $commandName,$parameterName,$wordToComplete,$commandAst, $fakeBoundParameters )
        
    if (-not $script:EmojiNames) {
        $script:EmojiNames = @(Import-Emoji| Select-Object -ExpandProperty Name)
    }
    if ($wordToComplete) {            
        $toComplete = $wordToComplete -replace "^'" -replace "'$"
        return @($script:emojiNames -like "$toComplete*" -replace '^', "'" -replace '$',"'")
    } else {            
        return @($script:emojiNames -replace '^', "'" -replace '$',"'")
    }
})]
[Alias('String')]
[string[]]
$Name,

[vbn()]
[Alias('Range')]
[int[]]
$Number
)

$allNamedEmoji = Import-Emoji
if ($Name) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Name -In $Name
}
if ($Number) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Number -In $Number
}

if ($name -or $number) {
    $allNamedEmoji
} else {
    $Emoji
}