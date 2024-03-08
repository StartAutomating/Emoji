<#
.SYNOPSIS
    Gets an Emoji as CSS 
.DESCRIPTION
    Gets an Emoji as a CSS rule
#>
param()

$className = $this.Name.ToLower() -replace '\s','-'
".${className}::before { content: `"$($this.Emoji)`"; }"
