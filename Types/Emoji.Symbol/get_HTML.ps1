<#
.SYNOPSIS
    Gets an Emoji as HTML 
.DESCRIPTION
    Gets an Emoji as an HTML span
#>
param()

"<span>$([Web.HttpUtility]::htmlencode($this.Emoji))</span>"
