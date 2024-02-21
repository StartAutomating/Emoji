<#
.SYNOPSIS
    Gets the paging parameters
.DESCRIPTION
    Gets the paging parameters as a Dictionary for Select-Object.
.LINK
    Select-Object
#>
param(
$Parameter
)

$SelectParameters = [Ordered]@{}

if ($Parameter.First -as [int]) {
    $SelectParameters.First = $Parameter.First -as [int]
}

if ($Parameter.Skip -as [int]) {
    $SelectParameters.Skip = $Parameter.Skip -as [int]
}

return $SelectParameters



