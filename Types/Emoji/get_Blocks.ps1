if (-not $this.'.Blocks') {        
    Add-Member -InputObject $this -MemberType NoteProperty -Force -Name ".Blocks" -Value (,$this.DB.Block)
}

$this.'.Blocks'