<#
.SYNOPSIS
    Gets the count of Emoji Blocks
.DESCRIPTION
    Gets the number of Emoji Blocks in the database
#>
param()
return $this.Tables['Block'].Rows.Count