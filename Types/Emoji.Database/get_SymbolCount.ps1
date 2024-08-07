<#
.SYNOPSIS
    Gets the count of Emoji Symbols
.DESCRIPTION
    Gets the number of Emoji Symbols in the database
#>
param()
return $this.Tables['Symbol'].Rows.Count