#requires -Module PSSVG

$AssetsPath = $PSScriptRoot | Split-Path | Join-Path -ChildPath "Assets"

if (-not (Test-Path $AssetsPath)) {
    New-Item -ItemType Directory -Path $AssetsPath | Out-Null
}

$fontName = 'Anta'
$fontName = 'Heebo'
$fontName = 'Noto Sans'

svg -content $(
    $commonParameters = [Ordered]@{
        Fill        = '#4488FF'
        # Stroke      = 'black'
        # StrokeWidth = '0.05'
    }

    SVG.GoogleFont -FontName $fontName

    svg.symbol -Id psChevron -Content @(
        svg.polygon -Points (@(
            "40,20"
            "45,20"
            "60,50"
            "35,80"
            "32.5,80"
            "55,50"
        ) -join ' ')
    ) -ViewBox 100, 100


    svg.use -Href '#psChevron' -X -50% -Y 25% @commonParameters -Height 49% -Opacity .9
    svg.text -Text 'emoji' -X 50% -Y 50% -FontSize 4em -FontFamily sans-serif @commonParameters -DominantBaseline 'middle' -TextAnchor 'middle' -Style "font-family:'$fontName'"
    svg.text -Text '😎😉😍🥰🤔😟' -X 50% -Y 80% -FontSize .5em @commonParameters -DominantBaseline 'middle' -TextAnchor 'middle'
) -ViewBox 0, 0, 200, 100 -OutputPath $(
    Join-Path $assetsPath Emoji.svg
)

