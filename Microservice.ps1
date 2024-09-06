if (-not $psNode) {
    $psNode = $emoji.Start()
    # Output the location of the node being served.
    @{serving=$($psNode.Location)} | ConvertTo-Json -Compress | Out-Host    
}

if (-not $psNode) {
    Write-Error "No node was started."
    return
}