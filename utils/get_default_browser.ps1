$DefaultSettingPath = 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
$DefaultBrowserName = (Get-Item $DefaultSettingPath | Get-ItemProperty).ProgId

if ($DefaultBrowserName -eq 'AppXq0fevzme2pys62n3e0fbqa7peapykr8v') {
    $DefaultBrowserExeName = "msedge.exe"
    $DefaultBrowserPath = (Get-Command $DefaultBrowserExeName).Source
} else {
    try {
        $null = New-PSDrive -PSProvider registry -Root 'HKEY_CLASSES_ROOT' -Name 'HKCR'
        
        # Get the default browser executable command/path
        $DefaultBrowserOpenCommand = (Get-Item "HKCR:\$DefaultBrowserName\shell\open\command" | Get-ItemProperty).'(default)'
        $DefaultBrowserPath = [regex]::Match($DefaultBrowserOpenCommand, '\".+?\"').Value.Trim('"')

        # Extract the .exe name from the path
        $DefaultBrowserExeName = [System.IO.Path]::GetFileNameWithoutExtension($DefaultBrowserPath)
    } catch {
        Throw $_.Exception
    } finally {
        # Clean up PSDrive for 'HKEY_CLASSES_ROOT'
        Remove-PSDrive -Name 'HKCR'
    }
}

# Return the default browser .exe name and full path
return @{
    BrowserExeName = $DefaultBrowserExeName
    BrowserPath    = $DefaultBrowserPath
}
