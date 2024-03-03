<#
.SYNOPSIS
    Gets Emoji Sequences
.DESCRIPTION
    Gets all loaded Emoji Sequences
#>
param()
foreach ($property in $this.psobject.properties) {
    if (-not $property.IsInstance) { continue }
    if ($property -isnot [psnoteproperty]) { continue }
    $property.Value
}