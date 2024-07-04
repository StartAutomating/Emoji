return @"
$((Get-Emoji -BlockName Emoticons | Get-Random).Html)
<br/>
File Not Found
<br/>
$($request.Url.LocalPath)
"@