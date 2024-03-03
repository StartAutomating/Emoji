<#
.SYNOPSIS
    Gets an Emoji's PowerShell string
.DESCRIPTION
    Gets a PowerShell string that would reproduce the Emoji.

    These strings will only work on PowerShell Core.
#>
param()
'"`u{' + $this.Hex + '}"'