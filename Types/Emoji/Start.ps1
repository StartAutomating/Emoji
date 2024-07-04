<#
.SYNOPSIS
    Starts a Emoji server.
.DESCRIPTION
    Starts a server for Emoji.    
#>  
param(
# The URL to serve the server on.
[string]
$ServerUrl,

# The local root path to serve files from.
# If this is not provided, the root directory of Emoji will be used.
[string]
$RootPath,

# The port to serve on.  If this is not provided, a random port will be used.
[int]
$Port,

# The scriptblock used to serve requests.
[ScriptBlock]
$Server
)

if ((-not $this) -and $MyInvocation.MyCommand.ScriptBlock.Module) {
    $this = $MyInvocation.MyCommand.ScriptBlock.module
}

$environmentVariables = Get-ChildItem env:

if (-not $ServerUrl) {    
    $myServerUrl = $environmentVariables | 
        Where-Object Name -eq "$($this.Name)_URL" | 
        Select-Object -ExpandProperty Value
    
    
    $serverUrl = $(if (-not $myServerUrl) {
        if ($PSVersionTable.Platform -eq 'Unix') {
            if (-not $port) { $port = 80}
            "http://*:$port/"
        } else {
            if (-not $port) { $port = $(Get-Random -Min 4000 -Max 8000)}
            "http://localhost:$port/$($this.Name)/"
        }    
    } else {
        $myServerUrl
    })
}

if (-not $serverUrl) {
    return
}

if (-not $RootPath) {
    $myServerRoot = $environmentVariables | 
        Where-Object Name -eq "$($this.Name.ToUpper())_ROOT" | 
        Select-Object -ExpandProperty Value

    $RootPath = 
        if (-not $myServerRoot) {
            $this | Split-Path
        } else {
            $myServerRoot
        }
}

if (-not $Server -and $this.Serve.Script) {
    $server = $this.Serve.Script
}

if (-not $server) { throw "No server script provided." ; return }

# Start the node, passing the current script block and the Emoji module
return @(Start-PSNode -Server $serveUrl -Command $Server -ImportModule $this,"Emoji" -Name "$this") -ne $null