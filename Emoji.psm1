$CommandsPath = Join-Path $PSScriptRoot Commands
:ToIncludeFiles foreach ($file in (Get-ChildItem -Path "$CommandsPath" -Filter "*-*.ps1" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    foreach ($exclusion in '\.[^\.]+\.ps1$') {
        if (-not $exclusion) { continue }
        if ($file.Name -match $exclusion) {
            continue ToIncludeFiles  # Skip excluded files
        }
    }     
    . $file.FullName
}

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
