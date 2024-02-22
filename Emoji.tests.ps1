describe Emoji {
    context "Emoji is a PowerShell Emoji Module" {
        it "Can Get-Emoji" {
            Get-Emoji -Name SOLIDUS |
                Select-Object -ExpandProperty String |
                Should -Be '/'
        }

        it "Can Find-Emoji" {
            Find-Emoji -Pattern "Face" | 
                Select-Object -ExpandProperty Name | 
                Should -BeLike '*Face*'
        }
    }
}
