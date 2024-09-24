<#
.SYNOPSIS
    Gets an Emoji as HTML 
.DESCRIPTION
    Gets an Emoji as an HTML span
.EXAMPLE
    (Get-Emoji -Name 'Grinning Face').HTML
#>
param()

"<span title=`"$([Web.HttpUtility]::HtmlAttributeEncode($this.Name))`">$([Web.HttpUtility]::HtmlEncode($this.Emoji))</span>"
