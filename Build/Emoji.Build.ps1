[ValidatePattern("\s(?>Unicode|UCD)")]
param()

# Push to the current location (this is redundant inside of a Pipeline, but good practice for interactive use)
Push-Location $PSScriptRoot

#region Download Unicode Character Dataset
# If we don't have the latest zip
if (-not $latestUnicodeZip) {
    # download it
    $latestUnicodeZip = Invoke-WebRequest https://unicode.org/Public/zipped/latest/UCD.zip
}

# Put the contents into UCD
$UCDZipPath = Join-Path $pwd "UCD.zip"
$UCDPath    = Join-Path $pwd "UCD"
if (-not (Test-path $UCDZipPath)) {
    [IO.File]::WriteAllBytes("$UCDZipPath",$latestUnicodeZip.Content)
    Expand-Archive -Path "$UCDZipPath" -DestinationPath "$UCDPath" -Force
}
#endregion Download Unicode Character Dataset

$parentPath = $pwd | Split-Path
$DataPath = Join-Path $parentPath "Data"

$emojiDataSet = [Data.DataSet]::new('Emoji')
$blockTable = $emojiDataSet.Tables.Add('Block')
$blockTable.Columns.AddRange(@(
    [Data.DataColumn]::new('BlockName', [string], '','Attribute')
    [Data.DataColumn]::new('RangeStart', [int], '','Attribute')
    [Data.DataColumn]::new('RangeEnd', [int], '','Attribute')
))
$blockTable.PrimaryKey = $blockTable.Columns['BlockName']
$symbolTable = $emojiDataSet.Tables.Add('Symbol')
$symbolTable.Columns.AddRange(@(
    [Data.DataColumn]::new('Number', [int], '','Attribute')
    [Data.DataColumn]::new('Name', [string], '','Attribute')    
    [Data.DataColumn]::new('String', [string], '','Attribute')
    [Data.DataColumn]::new('BlockName', [string], '','Hidden')
))
$symbolTable.PrimaryKey = $symbolTable.Columns['Hex']
$symbolsNestedInBlocks = $emojiDataSet.Relations.Add('Symbol', $emojiDataSet.Tables['Block'].Columns['BlockName'], $symbolTable.Columns['BlockName'])
$symbolsNestedInBlocks.Nested = $true
$symbolsNestedInBlocks.ParentKeyConstraint[0].ConstraintName = 'Block'


if (-not (Test-Path $DataPath)) {
    New-Item -ItemType Directory -Path $DataPath -Force | Out-Null
}

#region Extract, Transform, and Load Emoji Blocks
$allEmojiBlocks = 
    Get-ChildItem -Path $UCDPath -Recurse -Filter 'Blocks.txt' |
    Import-Csv -Delimiter ';' -Header Range, BlockName |
    Where-Object Range |
    Where-Object Range -notlike '#*'    

$currentGeneralCategory = ''

$allEmojiBlocksPath = (Join-Path $DataPath AllEmojiBlocks.csv)
@(foreach ($emojiBlock in $allEmojiBlocks) {
    
    $rangeStart, $rangeEnd = $emojiBlock.Range -split '\.\.'
    $null = $blockTable.Rows.Add($emojiBlock.BlockName, "0x$rangeStart" -as [int], "0x$rangeEnd" -as [int])
    
    [PSCustomObject][Ordered]@{
        RangeStart = $rangeStart
        RangeEnd = $rangeEnd
        BlockName=$emojiBlock.BlockName
    }
    
}) | Export-Csv -Path $allEmojiBlocksPath

Get-Item $allEmojiBlocksPath
#endregion Extract, Transform, and Load Emoji Blocks

#region Extract, Transform, and Load Named Emoji
$allNamedEmoji = 
    Get-ChildItem -Path $UCDPath -Recurse -Filter 'DerivedName.txt' |
    Import-Csv -Delimiter ';' -Header HexCode, Name

$allUniquelyNamedEmoji = $allNamedEmoji | 
    Group-Object Name | 
    Where-Object Count -eq 1

$allNamedEmojiPath = (Join-Path $DataPath AllNamedEmoji.csv)
@(foreach ($uniquelyNamedEmoji in $allUniquelyNamedEmoji) {
    $emojiName, $emojiHex = $uniquelyNamedEmoji.Name, "$($uniquelyNamedEmoji.Group[0].HexCode)".Trim()
    if ($emojiHex -match '\..') { continue }
    $emojiString = try {
        $ExecutionContext.InvokeCommand.ExpandString(('`u{',$emojiHex,'}' -join ''))
    } catch {
        $null
    }
    $emojiNumber = [int]"0x$emojiHex"
    $blockName = "$($blockTable.Select("$emojiNumber >= RangeStart AND $emojiNumber <= RangeEnd").BlockName)"
    $null = $symbolTable.Rows.Add($emojiNumber, $emojiName, $emojiString, $blockName)

    if ($emojiString) {
        [Ordered]@{Name="$emojiName";Hex="$emojiHex";String="$emojiString"}
    }
}) | Export-Csv -Path $allNamedEmojiPath -Force

Get-Item -Path $allNamedEmojiPath
$EmojiXsdPath = Join-Path $DataPath Emoji.xsd
$emojiDataSet.WriteXmlSchema("$EmojiXsdPath")
Get-Item -Path $EmojiXsdPath
$emojiXmlPath = Join-Path $DataPath Emoji.xml
$emojiDataSet.WriteXml("$emojiXmlPath")
Get-Item -Path $emojiXmlPath

#endregion Extract, Transform, and Load Named Emoji

Pop-Location