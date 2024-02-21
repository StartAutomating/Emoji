# Emoji
⟩⚡PowerShell Emoji 😎😉😍🥰🤔😟

Emoji is a little PowerShell module to help you work with Emoji.

It is built from the Unicode Character Dataset, which includes `>{@(Import-Emoji).Length}<` Emoji

## Installing and Importing

Emoji is on the PowerShell Gallery.

You can install and import Emoji by using:

~~~PowerShell
Install-Module Emoji -Scope CurrentUser -Force
Import-Module Emoji
~~~

## Searching Emoji

Search-Emoji or Find-Emoji can be used to search loaded Emoji

~~~PowerShell
# Find all of the Emoji faces
Find-Emoji -Pattern "Face"
~~~

~~~PowerShell
# Search all emoji ending in cats and dogs
Search-Emoji -Pattern "(Cat|Dog)$"
~~~

~~~PowerShell
# Find all emoji grins
Find-Emoji -Pattern "*grin*" -Like
~~~