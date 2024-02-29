<#
.SYNOPSIS
    Gets one or more Emoji
.DESCRIPTION
    Gets Emoji by exact name or number.

    If neither name or number is provided, returns the Emoji module.
#>
[CmdletBinding(SupportsPaging)]
param(
# One or more specific Emoji names
[ArgumentCompleter({
    param ( $commandName,$parameterName,$wordToComplete,$commandAst, $fakeBoundParameters )
        
    if (-not $script:EmojiNames) {
        $script:EmojiNames = @(Import-Emoji| Select-Object -ExpandProperty Name)
    }
    if ($wordToComplete) {            
        $toComplete = $wordToComplete -replace "^'" -replace "'$"
        return @($script:emojiNames -like "$toComplete*" -replace '^', "'" -replace '$',"'")
    } else {            
        return @($script:emojiNames -replace '^', "'" -replace '$',"'")
    }
})]
[Alias('String')]
[string[]]
$Name,

# One or more specific emoji numbers
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('Range')]
[int[]]
$Number,

# If set, will get Emoji blocks
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('AllBlock','AllBlocks','ListBlock','ListBlocks')]
[switch]
$Block,

# One or more block names
[Parameter(ValueFromPipelineByPropertyName)]
[ValidateSet('Basic Latin','Latin-1 Supplement','Latin Extended-A','Latin Extended-B','IPA Extensions','Spacing Modifier Letters','Combining Diacritical Marks','Greek and Coptic','Cyrillic','Cyrillic Supplement','Armenian','Hebrew','Arabic','Syriac','Arabic Supplement','Thaana','NKo','Samaritan','Mandaic','Syriac Supplement','Arabic Extended-B','Arabic Extended-A','Devanagari','Bengali','Gurmukhi','Gujarati','Oriya','Tamil','Telugu','Kannada','Malayalam','Sinhala','Thai','Lao','Tibetan','Myanmar','Georgian','Hangul Jamo','Ethiopic','Ethiopic Supplement','Cherokee','Unified Canadian Aboriginal Syllabics','Ogham','Runic','Tagalog','Hanunoo','Buhid','Tagbanwa','Khmer','Mongolian','Unified Canadian Aboriginal Syllabics Extended','Limbu','Tai Le','New Tai Lue','Khmer Symbols','Buginese','Tai Tham','Combining Diacritical Marks Extended','Balinese','Sundanese','Batak','Lepcha','Ol Chiki','Cyrillic Extended-C','Georgian Extended','Sundanese Supplement','Vedic Extensions','Phonetic Extensions','Phonetic Extensions Supplement','Combining Diacritical Marks Supplement','Latin Extended Additional','Greek Extended','General Punctuation','Superscripts and Subscripts','Currency Symbols','Combining Diacritical Marks for Symbols','Letterlike Symbols','Number Forms','Arrows','Mathematical Operators','Miscellaneous Technical','Control Pictures','Optical Character Recognition','Enclosed Alphanumerics','Box Drawing','Block Elements','Geometric Shapes','Miscellaneous Symbols','Dingbats','Miscellaneous Mathematical Symbols-A','Supplemental Arrows-A','Braille Patterns','Supplemental Arrows-B','Miscellaneous Mathematical Symbols-B','Supplemental Mathematical Operators','Miscellaneous Symbols and Arrows','Glagolitic','Latin Extended-C','Coptic','Georgian Supplement','Tifinagh','Ethiopic Extended','Cyrillic Extended-A','Supplemental Punctuation','CJK Radicals Supplement','Kangxi Radicals','Ideographic Description Characters','CJK Symbols and Punctuation','Hiragana','Katakana','Bopomofo','Hangul Compatibility Jamo','Kanbun','Bopomofo Extended','CJK Strokes','Katakana Phonetic Extensions','Enclosed CJK Letters and Months','CJK Compatibility','CJK Unified Ideographs Extension A','Yijing Hexagram Symbols','CJK Unified Ideographs','Yi Syllables','Yi Radicals','Lisu','Vai','Cyrillic Extended-B','Bamum','Modifier Tone Letters','Latin Extended-D','Syloti Nagri','Common Indic Number Forms','Phags-pa','Saurashtra','Devanagari Extended','Kayah Li','Rejang','Hangul Jamo Extended-A','Javanese','Myanmar Extended-B','Cham','Myanmar Extended-A','Tai Viet','Meetei Mayek Extensions','Ethiopic Extended-A','Latin Extended-E','Cherokee Supplement','Meetei Mayek','Hangul Syllables','Hangul Jamo Extended-B','High Surrogates','High Private Use Surrogates','Low Surrogates','Private Use Area','CJK Compatibility Ideographs','Alphabetic Presentation Forms','Arabic Presentation Forms-A','Variation Selectors','Vertical Forms','Combining Half Marks','CJK Compatibility Forms','Small Form Variants','Arabic Presentation Forms-B','Halfwidth and Fullwidth Forms','Specials','Linear B Syllabary','Linear B Ideograms','Aegean Numbers','Ancient Greek Numbers','Ancient Symbols','Phaistos Disc','Lycian','Carian','Coptic Epact Numbers','Old Italic','Gothic','Old Permic','Ugaritic','Old Persian','Deseret','Shavian','Osmanya','Osage','Elbasan','Caucasian Albanian','Vithkuqi','Linear A','Latin Extended-F','Cypriot Syllabary','Imperial Aramaic','Palmyrene','Nabataean','Hatran','Phoenician','Lydian','Meroitic Hieroglyphs','Meroitic Cursive','Kharoshthi','Old South Arabian','Old North Arabian','Manichaean','Avestan','Inscriptional Parthian','Inscriptional Pahlavi','Psalter Pahlavi','Old Turkic','Old Hungarian','Hanifi Rohingya','Rumi Numeral Symbols','Yezidi','Arabic Extended-C','Old Sogdian','Sogdian','Old Uyghur','Chorasmian','Elymaic','Brahmi','Kaithi','Sora Sompeng','Chakma','Mahajani','Sharada','Sinhala Archaic Numbers','Khojki','Multani','Khudawadi','Grantha','Newa','Tirhuta','Siddham','Modi','Mongolian Supplement','Takri','Ahom','Dogra','Warang Citi','Dives Akuru','Nandinagari','Zanabazar Square','Soyombo','Unified Canadian Aboriginal Syllabics Extended-A','Pau Cin Hau','Devanagari Extended-A','Bhaiksuki','Marchen','Masaram Gondi','Gunjala Gondi','Makasar','Kawi','Lisu Supplement','Tamil Supplement','Cuneiform','Cuneiform Numbers and Punctuation','Early Dynastic Cuneiform','Cypro-Minoan','Egyptian Hieroglyphs','Egyptian Hieroglyph Format Controls','Anatolian Hieroglyphs','Bamum Supplement','Mro','Tangsa','Bassa Vah','Pahawh Hmong','Medefaidrin','Miao','Ideographic Symbols and Punctuation','Tangut','Tangut Components','Khitan Small Script','Tangut Supplement','Kana Extended-B','Kana Supplement','Kana Extended-A','Small Kana Extension','Nushu','Duployan','Shorthand Format Controls','Znamenny Musical Notation','Byzantine Musical Symbols','Musical Symbols','Ancient Greek Musical Notation','Kaktovik Numerals','Mayan Numerals','Tai Xuan Jing Symbols','Counting Rod Numerals','Mathematical Alphanumeric Symbols','Sutton SignWriting','Latin Extended-G','Glagolitic Supplement','Cyrillic Extended-D','Nyiakeng Puachue Hmong','Toto','Wancho','Nag Mundari','Ethiopic Extended-B','Mende Kikakui','Adlam','Indic Siyaq Numbers','Ottoman Siyaq Numbers','Arabic Mathematical Alphabetic Symbols','Mahjong Tiles','Domino Tiles','Playing Cards','Enclosed Alphanumeric Supplement','Enclosed Ideographic Supplement','Miscellaneous Symbols and Pictographs','Emoticons','Ornamental Dingbats','Transport and Map Symbols','Alchemical Symbols','Geometric Shapes Extended','Supplemental Arrows-C','Supplemental Symbols and Pictographs','Chess Symbols','Symbols and Pictographs Extended-A','Symbols for Legacy Computing','CJK Unified Ideographs Extension B','CJK Unified Ideographs Extension C','CJK Unified Ideographs Extension D','CJK Unified Ideographs Extension E','CJK Unified Ideographs Extension F','CJK Unified Ideographs Extension I','CJK Compatibility Ideographs Supplement','CJK Unified Ideographs Extension G','CJK Unified Ideographs Extension H','Tags','Variation Selectors Supplement','Supplementary Private Use Area-A','Supplementary Private Use Area-B')]
[string[]]
$BlockName
)

$allNamedEmoji = Import-Emoji

if (-not $this) {
    $this = Get-Module Emoji
}

if ($BlockName) {
    foreach ($nameOfBlock in $BlockName) {
        $blockRange = $this.Blocks[$nameOfBlock].Range
        if ($blockRange) {
            $number += $blockRange
        }        
    }
}

if ($Name) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Name -In $Name
}
if ($Number) {
    $allNamedEmoji = $allNamedEmoji | Where-Object Number -In $Number
}

$selectSplat = $Emoji.GetPagingParameters($PSCmdlet.PagingParameters)
if ($name -or $number) {
    if ($selectSplat.Count -gt 1) {
        $allNamedEmoji  | Select-Object @selectSplat
    } else {
        $allNamedEmoji
    }
} 
elseif ($Block) {
    if ($selectSplat.Count) {
        $emoji.Blocks.Values | Select-Object @selectSplat
    } else {
        $emoji.Blocks.Values
    }    
}
else {
    $Emoji
}

