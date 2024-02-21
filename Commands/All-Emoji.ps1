function Emoji {

    <#
    .SYNOPSIS
        ⟩⚡PowerShell Emoji 😎😉😍🥰 🤔😟
    .DESCRIPTION
        Helps you work with Emoji in PowerShell.        
    #>
    [Alias(
        'Get-Emoji','Set-Emoji',
        'Find-Emoji', 'Search-Emoji',
        'Import-Emoji', 'Export-Emoji'
    )]
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess,SupportsPaging)]
    param()

    dynamicParam {
        $myName = $MyInvocation.InvocationName
        $myVerb, $myNoun = 
            if ($myName -match '-') { $myName -split '-',2 }
            else { $myName -split '\p{P}',2 }
            
        if (-not $myNoun) {
            $myNoun = $myVerb
            $myVerb = "Get"
        }    

        if (-not $myNoun) { return }

        $nounTypeData = Get-TypeData -TypeName $myNoun

        $DynamicParameters = [Management.Automation.RuntimeDefinedParameterDictionary]::new()

        $typeDataForVerb = $nounTypeData.Members[$myVerb]        
        if (
            ($typeDataForVerb -is [Management.Automation.Runspaces.AliasPropertyData]) -and
            ($nounTypeData.Members[$typeDataForVerb.ReferencedMemberName] -is
                [Management.Automation.Runspaces.ScriptMethodData])
        ) {
            $typeDataForVerb = $nounTypeData.Members[$typeDataForVerb.ReferencedMemberName]
        }

        if ($typeDataForVerb -is [Management.Automation.Runspaces.ScriptMethodData]) {
            $function:TempFunction = $typeDataForVerb.Script
            $tempFunctionMetadata = [Management.Automation.CommandMetadata]$ExecutionContext.SessionState.InvokeCommand.GetCommand('TempFunction','Function')
            foreach ($functionParameter in $tempFunctionMetadata.Parameters.Values) {
                $DynamicParameters.Add($functionParameter.Name, 
                    [Management.Automation.RuntimeDefinedParameter]::new(
                        $functionParameter.Name,$functionParameter.ParameterType, @(
                            $functionParameter.Attributes
                        )
                    )
                )
            }
        }
        return $DynamicParameters
    }

    process {
        $myName = $MyInvocation.InvocationName
        $myVerb, $myNoun = $myName -split '-',2
        if (-not $myNoun) {
            $myNoun = $myVerb
            $myVerb = "Get"
        }
        if (-not $myNoun) { 
            return $Emoji
        }
        $nounTypeData = Get-TypeData -TypeName $myNoun
        $typeDataForVerb = $nounTypeData.Members[$myVerb]
        if (
            ($typeDataForVerb -is [Management.Automation.Runspaces.AliasPropertyData]) -and
            ($nounTypeData.Members[$typeDataForVerb.ReferencedMemberName] -is
                [Management.Automation.Runspaces.ScriptMethodData])
        ) {
            $typeDataForVerb = $nounTypeData.Members[$typeDataForVerb.ReferencedMemberName]
        }
        if (-not $typeDataForVerb) { return }
        $parametersForScript = [Ordered]@{} + $PSBoundParameters
        $function:InnerCommand = $typeDataForVerb.Script
        $innerCommandMetadata = $ExecutionContext.SessionState.InvokeCommand.GetCommand('InnerCommand','Function') -as 
            [Management.Automation.CommandMetadata]
        foreach ($parameterName in @($parametersForScript.Keys)) {
            if (-not $innerCommandMetadata.Parameters[$parameterName]) {
                $parametersForScript.Remove($parameterName)
            }
        }
        if ($innerCommandMetadata.SupportsPaging) {
            if ($PSBoundParameters.First) {
                $parametersForScript.First = $PSBoundParameters.First
            }
            if ($PSBoundParameters.Skip) {
                $parametersForScript.Skip = $PSBoundParameters.Skip
            }
        }
        & $typeDataForVerb.Script @parametersForScript
    }

}

