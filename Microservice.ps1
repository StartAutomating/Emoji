if (-not $psNode) {
    $psNode = $emoji.Start()
    # Output the location of the node being served.
    @{serving=$($psNode.Location)} | ConvertTo-Json -Compress | Write-Information    
}

if (-not $psNode) {
    Write-Error "No node was started."
    return
}

# Wait for the node to finish
# (If this is running in a headless web server, it should never finish)
do {
    Wait-Job -Id $psNode.ID -Timeout ([int](Get-Random -Minimum 1067 -Maximum 2971))
    # Write the output of the node to the host
    $psNode | Receive-Job | Out-Host
} while ($psNode.State -eq 'Running')