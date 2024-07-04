param($Request)

$Query = [Ordered]@{}
if ($Request.Url.Query) {
    $parsedQuery = [Web.HttpUtility]::ParseQueryString($Request.Url.Query)
    foreach ($queryKey in $parsedQuery) {
        $Query[$queryKey] = $parsedQuery[$queryKey]
    }
}

if (-not $this.'.RequestCache') {
    $this | Add-Member -MemberType NoteProperty -Name '.RequestCache' -Value @{} -Force
}

if ($Request.Url.Segments.Count -eq 0) {
    

} else {
    
    if ($this.'.RequestCache'.ContainsKey($Request.Url.LocalPath)) {
        $this.'.RequestCache'[$Request.Url.LocalPath]
        return
    }
    $this.'.RequestCache'[$Request.Url.LocalPath] = @(
        foreach ($segment in $request.Url.Segments -replace '^/') {
            $foundEmoji = Get-Emoji -Name $segment
            if ($foundEmoji) {
                $foundEmoji
                continue
            }
            $foundBlock = Get-Emoji -BlockName $segment
            if ($foundBlock) {
                $foundBlock | Get-Emoji
                continue
            }

            $foundEmoji = Find-Emoji -Word -Pattern ([Regex]::Escape($segment))
            if ($foundEmoji) {
                $foundEmoji
                continue            
            }
        }
    )

    $hasSomething = $this.'.RequestCache'[$Request.Url.LocalPath].Length -gt 0

    if (-not $hasSomething) {
        return $this.404
    } else {
        return $this.'.RequestCache'[$Request.Url.LocalPath]
    }        
}
