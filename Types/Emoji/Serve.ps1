if (-not $request) { return $this.404 }
if (-not $this) { 
    $this = 
        if ($emoji -is [Management.Automation.PSModuleInfo]) { $emoji }
        else { Get-Module Emoji }
}

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
        foreach ($segment in $request.Url.Segments -replace '^/' -replace '\?.+$' -ne '') {
            $foundEmoji = Get-Emoji -Name $segment
            if ($foundEmoji) {
                $foundEmoji
                continue
            }
            $foundBlock = 
                try { 
                    Get-Emoji -BlockName $segment
                } catch { $null }

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
        if ($response) {
            $response.ContentType = "text/html"
            $responseMessage = $outputEncoding.GetBytes(@"
<!DOCTYPE html>
<html>
    <title>$([Web.HttpUtility]::htmlEncode($Request.Url))</title>
    <style>body { font-size: 2em }</style>
    <body>
        $($this.'.RequestCache'[$Request.Url.LocalPath].Html -join '<br/>')
    </body>
</html>
"@)
            $response.OutputStream.Write($responseMessage, 0, $responseMessage.Length)         
        }
        

        return 
    }        
}
