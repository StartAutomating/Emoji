<#
.SYNOPSIS
    Gets an Emoji as HTML 
.DESCRIPTION
    Gets an Emoji as an HTML span
.EXAMPLE
    (Get-Emoji -Name 'Grinning Face').HTML
#>
param()

"<span>$([Web.HttpUtility]::HtmlEncode($this.Emoji))</span>"
