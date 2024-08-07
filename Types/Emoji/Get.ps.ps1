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
[Alias('AllBlock','AllBlocks','ListBlock','ListBlocks','Blocks')]
[switch]
$Block,

# If set, will list Emoji sequences
[vbn()]
[Alias('AllSequence','AllSequences','ListSequences','ListSequence','Sequences')]
[switch]
$Sequence,

# One or more block names
[vbn()]
[ValidValues(Values={
    $emoji.Blocks.Rows.BlockName
})]
[string[]]
$BlockName
)

$allSelectedEmoji = Import-Emoji

if (-not $this) {
    $this = Get-Module Emoji
}

if ($BlockName) {
    foreach ($nameOfBlock in $BlockName) {
        $blockRange = $this.Blocks.Rows.Find($nameOfBlock).Range
        if ($blockRange) {
            $number += $blockRange
        }        
    }
}

if ($Name) {
    if ($Name -match '\p{P}') {
        if ($name -match '\*' -and $name -notmatch '[\[\]\.\?\(\)]') {
            $allSelectedEmoji = Search-Emoji -Like -Pattern $name
        } else {
            $allSelectedEmoji = Search-Emoji -Pattern $name
        }
    } else {
        $allSelectedEmoji = $this.DB.Symbol.Select("Name IN ('$($Name -join "','")')")
    }    
}
if ($Number) {
    $allSelectedEmoji = $this.DB.Symbol.Select("Number IN ($($Number -join ","))")
}

$selectSplat = $Emoji.GetPagingParameters($PSCmdlet.PagingParameters)
if ($name -or $number) {
    if ($selectSplat.Count -gt 1) {
        $allSelectedEmoji  | Select-Object @selectSplat
    } else {
        $allSelectedEmoji
    }
} 
elseif ($Block) {
    if ($selectSplat.Count) {
        $emoji.Blocks.Rows | Select-Object @selectSplat
    } else {
        $emoji.Blocks.Rows
    }    
}
elseif ($Sequence) {
    if ($selectSplat.Count) {
        $emoji.Sequences.All | Select-Object @selectSplat
    } else {
        $emoji.Sequences.All
    }
}
else {
    $Emoji
}
