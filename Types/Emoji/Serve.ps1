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
        $this.'.RequestCache'["$($Request.Url.LocalPath)"]
        return
    }
    $this.'.RequestCache'["$($Request.Url.LocalPath)"] = @(
        foreach ($segment in @($request.Url.Segments -replace '^/' -replace '\?.+$' -ne '')) {
            $segment = @([Web.HttpUtility]::urlDecode($segment) -split ',')
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

    $hasSomething = $this.'.RequestCache'[$Request.Url.LocalPath]

    if ($hasSomething.Length -le 0) {
        $response.ContentType = "text/plain"
        return $this.404
    } else {
        if ($response) {
            $response.ContentType = "text/html"
            $responseMessage = $outputEncoding.GetBytes(@"
<!DOCTYPE html>
<html>
    <title>$([Web.HttpUtility]::htmlEncode($Request.Url))</title>
    <style>html, body { font-size: 2em; height:100% }</style>
    <body>
        <svg width="100%" height="100%" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
            <foreignObject width="100%" height="100%">                
            $(
                $xhtml = 
                @(
                    "<body class='markdown-svg' xmlns='http://www.w3.org/1999/xhtml'>"
                    foreach ($somethingFound in $hasSomething) {
                        $somethingFound.Html
                    }
                    "</body>"
                ) -as [xml]
                $xhtml.OuterXml
            )
            </foreignObject>
        </svg>
    </body>
</html>
"@)
            $response.OutputStream.Write($responseMessage, 0, $responseMessage.Length)         
        }
        

        return 
    }        
}
