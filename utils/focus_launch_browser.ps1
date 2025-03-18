$browserInfo = . "$($env:USERPROFILE)\.config\utils\get_default_browser.ps1"
. "$($env:USERPROFILE)\.config\utils\focus_or_launch.ps1" -ProcessName $($browserInfo.BrowserExeName) -LaunchCommand $($browserInfo.BrowserPath)
