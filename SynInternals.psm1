Get-ChildItem *.ps1 -Path export,private -Recurse | ForEach-Object{
    . $_.FullName
    }
    
Get-ChildItem *.ps1 -Path export -Recurse | ForEach-Object{
    Export-ModuleMember $_.BaseName
    }