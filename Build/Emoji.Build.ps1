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
$UCDZipPath = Join-Path $PSScriptRoot "UCD.zip"
$UCDPath    = Join-Path $PSScriptRoot "UCD"
if (-not (Test-path $UCDZipPath)) {
    [IO.File]::WriteAllBytes("$UCDZipPath",$latestUnicodeZip.Content)
    Expand-Archive -Path "$UCDZipPath" -DestinationPath "$UCDPath" -Force
}
#endregion Download Unicode Character Dataset

#region Extract, Transform, and Load Named Emoji
$allNamedEmoji = 
    Get-ChildItem -Path $UCDPath -Recurse -Filter 'DerivedName.txt' |
    Import-Csv -Delimiter ';' -Header HexCode, Name

$allUniquelyNamedEmoji = $allNamedEmoji | 
    Group-Object Name | 
    Where-Object Count -eq 1

$parentPath = $pwd | Split-Path
$DataPath = Join-Path $parentPath "Data"

if (-not (Test-Path $DataPath)) {
    New-Item -ItemType Directory -Path $DataPath -Force | Out-Null
}
$allNamedEmojiPath = (Join-Path $DataPath AllNamedEmoji.csv)
@(foreach ($uniquelyNamedEmoji in $allUniquelyNamedEmoji) {
    $emojiName, $emojiHex = $uniquelyNamedEmoji.Name, "$($uniquelyNamedEmoji.Group[0].HexCode)".Trim()
    if ($emojiHex -match '\..') { continue }
    $emojiString = try {
        $ExecutionContext.InvokeCommand.ExpandString(('`u{',$emojiHex,'}' -join ''))
    } catch {
        $null
    }

    if ($emojiString) {
        [Ordered]@{Name="$emojiName";Hex="$emojiHex";String="$emojiString"}
    }
}) | Export-Csv -Path $allNamedEmojiPath -Force

Get-Item -Path $allNamedEmojiPath
#endregion Extract, Transform, and Load Named Emoji

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
    
    [PSCustomObject][Ordered]@{
        RangeStart = $rangeStart
        RangeEnd = $rangeEnd
        BlockName=$emojiBlock.BlockName
    }
    
}) | Export-Csv -Path $allEmojiBlocksPath

Get-Item $allEmojiBlocksPath
#endregion Extract, Transform, and Load Emoji Categories


Pop-Location