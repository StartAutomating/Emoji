<#
#>
param()

if (-not $this.'.DB') {
    if (-not $DataPath) {
        $DataPath = $this | 
            Split-Path | 
            Join-Path -ChildPath Data
    }
    $emojiXsd = Join-Path $DataPath "Emoji.xsd"
    $emojiXml = Join-Path $DataPath "Emoji.xml"
    $emojiDataSet = [Data.DataSet]::new('Emoji')
    $emojiDataSet.ReadXmlSchema($emojiXsd)
    $null = $emojiDataSet.ReadXml($emojiXml)
    $emojiDataSet.pstypenames.insert(0,'Emoji.Database')
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".DB" -Value $emojiDataSet
}
return $this.'.DB'
