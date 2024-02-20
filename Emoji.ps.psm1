$CommandsPath = Join-Path $PSScriptRoot Commands
[include('*-*.ps1')]$CommandsPath

$myModule = $MyInvocation.MyCommand.ScriptBlock.Module
$myModule.pstypenames.insert(0,$myModule.Name)
Set-Item -Path "variable:$($myModule.Name)" -Value $myModule

$newDriveCommonParameters =
    @{PSProvider='FileSystem';Scope='Global';ErrorAction='Ignore'}
New-PSDrive -Name $myModule.name @newDriveCommonParameters -Root ($myModule | Split-Path)

if ($home) {
    $MyMyModule= "My$($myModule.name)"
    New-PSDrive -Name $MyMyModule @newDriveCommonParameters -Root (Join-Path $home $MyMyModule)
}


Export-ModuleMember -Function * -Alias * -Variable $myModule.Name