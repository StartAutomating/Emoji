<#
.SYNOPSIS
    Gets one or more Emoji
.DESCRIPTION
    Gets Emoji by exact name or number.

    If neither name or number is provided, returns the Emoji module.
#>
[CmdletBinding(SupportsPaging)]
param(
# One or more specific Emoji names
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

# One or more specific emoji numbers
[vbn()]
[Alias('Range')]
[int[]]
$Number,

# If set, will get Emoji blocks
[vbn()]
[Alias('AllBlock','AllBlocks','ListBlock','ListBlocks')]
[switch]
$Block,

# One or more block names
[vbn()]
[ValidValues(Values={
    $pwd |
        Split-Path | 
        Split-Path | 
        Join-Path -ChildPath "Data" | 
        Join-Path -ChildPath "AllEmojiBlocks.csv" | 
        Import-Csv | 
        Select-Object -ExpandProperty BlockName
})]
[string[]]
$BlockName
)

$allNamedEmoji = Import-Emoji

if (-not $this) {
    $this = Get-Module Emoji
}

if ($BlockName) {
    foreach ($nameOfBlock in $BlockName) {
        $blockRange = $this.Blocks[$nameOfBlock].Range
        if ($blockRange) {
            $number += $blockRange
        }        
    }
}

if ($Name) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Name -In $Name
}
if ($Number) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Number -In $Number
}

$selectSplat = $Emoji.GetPagingParameters($PSCmdlet.PagingParameters)
if ($name -or $number) {
    if ($selectSplat.Count -gt 1) {
        $allNamedEmoji  | Select-Object @selectSplat
    } else {
        $allNamedEmoji
    }
} 
elseif ($Block) {
    if ($selectSplat.Count) {
        $emoji.Blocks.Values | Select-Object @selectSplat
    } else {
        $emoji.Blocks.Values
    }    
}
else {
    $Emoji
}
