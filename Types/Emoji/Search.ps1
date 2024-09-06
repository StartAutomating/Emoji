<#
.SYNOPSIS
    Find Emoji
.DESCRIPTION
    Searches for Emoji
#>
[CmdletBinding(SupportsPaging)]
param(
# One or more search patterns
[Parameter(ValueFromPipelineByPropertyName)]
[string[]]
$Pattern,

# If set, will search using the -like operator.  By default, will search using -match
[Parameter(ValueFromPipelineByPropertyName)]
[switch]
$Like,

# If set, will look for an exact word.  This is not compatible with -Like.
[Parameter(ValueFromPipelineByPropertyName)]
[switch]
$Word
)

if (-not $this) {
    $this = Get-Module Emoji
}

if ($word) {
    $like = $false
    $Pattern = $Pattern -replace '^', '(?<=(?>^|\s))' -replace '$', '(?=(?>$|\s))'
}

$SelectParameters = $Emoji.GetPagingParameters($PSCmdlet.PagingParameters)

@(foreach ($condition in $Pattern) {
    $starCount = @([Regex]::matches($condition, '\*')).Length
    $punctuation = @([Regex]::matches($condition,'\p{P}'))
    if (($like -or -not $punctuation) -and $starCount -eq 0) {
        $condition = "*$condition*"
        $like = $true
    }
    if ($like -and $starCount -le 2) {
        $emoji.DB.Symbol.Select("Name LIKE '$condition'")
    } else {
        foreach ($namedEmoji in $this.Import()) {
            if ($like) {                
                if ($namedEmoji.Name -like $condition) {
                    $namedEmoji
                }
            } elseif ($namedEmoji.Name -match $condition) {
                $namedEmoji
            }
        }
    }        
}) | Select-Object @SelectParameters

