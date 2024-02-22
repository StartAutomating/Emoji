param(
[Parameter(ValueFromPipelineByPropertyName)]
[string[]]
$EmojiSequence,

[PSObject]
$Value
)

$joinedSequence = $EmojiSequence -join ''

$dynamicModule = 
    if ($joinedSequence -and $value -is [ScriptBlock]) {        
        New-Module -Name $joinedSequence -ScriptBlock ([ScriptBlock]::Create(
            "function $JoinedSequence {
                . `${$JoinedSequence}
            }

            `${$JoinedSequence} = `$args[0]

            Export-ModuleMember -Function * -Variable * -Alias *"
        )) -ArgumentList $value    
    }     
    else {
        New-Module -Name $joinedSequence -ScriptBlock ([ScriptBlock]::Create(
            "`${$JoinedSequence} = `$args[0]
            Export-ModuleMember -Function * -Variable * -Alias *"
        )) -ArgumentList $value                
    }

if ($dynamicModule) {
    $dynamicModule | Import-Module -Global -Force -DisableNameChecking -PassThru
}


    

