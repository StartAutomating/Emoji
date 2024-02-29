<#
.SYNOPSIS
    Removes an Emoji sequence
.DESCRIPTION
    Removes an Emoji sequence from the cache
#>
param(
# The emoji sequence
[string]
$EmojiSequence
)

if (-not $this.$EmojiSequence) { return }
$this.psobject.properties.Remove($EmojiSequence)