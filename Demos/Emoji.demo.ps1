#1. 😎

# Emoji is a cute little module to work with Emoji.

# It has every named character in the unicode dataset.

# Find-Emoji lets us search by keyword.
Find-Emoji "sunglasses"

# (that's why it's also called Search-Emoji).
Search-Emoji "boat"

# Get-Emoji can get emoji by name.
Get-Emoji -Name "sailboat"

#2. 😉

# Find-Emoji is more powerful than it looks.

# By default, it uses a regular expression.

# Let's find all emoji ending in cat or dog
Find-Emoji "(?>Cat|Dog)$"

# We can also narrow it down with -Word, which will only look for whole words
Find-Emoji "(?>Lion|Tiger|Bear)" -Word

# Don't like regex?  Just use -like:
Find-Emoji -Like "*left*arrow*"

#3. 😍

# We can also get all of the character blocks:

Get-Emoji -Block

# Or see a specific block
Get-Emoji -BlockName Emoticons

# Don't forget the object pipeline, it's your friend:

Get-Emoji -Block |
    Where-Object BlockName -like '*box*' | 
    Get-Emoji
    
#4. 🥰

# Emoji are playful.

# Here are a few games we can play with Emoji.

# Cards:
Search-Emoji "Playing Card" 

# Chess:
Search-Emoji "chess"  | 
    Where-Object Number -lt 10kb

# Dominos:
Search-Emoji "Domino"

# Mahjong:
Get-Emoji -BlockName 'Mahjong Tiles'

# Emoji can make music:
Get-Emoji -BlockName 'Musical Symbols'

# It can even show you how the Ancient Greeks made music:
Get-Emoji -BlockName 'Ancient Greek Musical Notation'

# Or we could learn some alchemy:
Get-Emoji -BlockName 'Alchemical Symbols'

# Maybe try to learn Hieroglyphs?
Get-Emoji -BlockName 'Egyptian Hieroglyphs'

# Not ancient enough for you?
# How about some Linear A / Linear B:
Get-Emoji -Block |
    Where-Object BlockName -like 'Linear *' |
    Get-Emoji

# There are a lot of Emoji to play with.

# Of course, the Emoji module can do more than just search Emoji.