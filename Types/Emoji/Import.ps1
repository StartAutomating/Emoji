<#
.SYNOPSIS
    Imports Emoji
.DESCRIPTION
    Imports all named Emoji from an -EmojiPath.

    If the -EmojiPath is not provided, it will import it's local copy
#>
param(
# The path to the emoji data
[string]
$EmojiPath,

# If set, will overwrite existing data.
[switch]
$Force
)


if (-not $this) {
    $this = Get-Module Emoji
}
if ((-not $this.'.EmojiCache') -or $Force) {
    if (-not $DataPath) {
        $DataPath = $this | 
            Split-Path | 
            Join-Path -ChildPath Data
    }
    $emojiXsd = Join-Path $DataPath "Emoji.xsd"
    $emojiXml = Join-Path $DataPath "Emoji.xml"
    $emojiDataSet = [Data.DataSet]::new('Emoji')
    $null = $emojiDataSet.ReadXmlSchema($emojiXsd)
    $null = $emojiDataSet.ReadXml($emojiXml)        
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".EmojiCache" -Value @(foreach ($importedEmoji in $emojiDataSet.Tables['Symbol'].Rows) {
        $importedEmoji.pstypenames.insert(0,'Emoji.Symbol')
        $importedEmoji
    })
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".Blocks" -Value @(foreach ($importedBlock in $emojiDataSet.Tables['Block'].Rows) {
        $importedBlock.pstypenames.insert(0,'Emoji.Block')
        $importedBlock
    })
}
$this.'.EmojiCache'