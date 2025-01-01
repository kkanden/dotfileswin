param (
    [string]$ProcessName,  # The name of the process (e.g., "WindowsTerminal")
    [string]$LaunchCommand, # Command to launch the process if not running (e.g., "wt")
    [string]$LaunchArguments # Arguments for the command (e.g., --processStart Discord.exe)
)

function Focus-Or-Launch {
param (
        [string]$ProcessName,
        [string]$LaunchCommand,
        [string]$LaunchArguments
    )
    # Get all processes with the specified name
    $processes = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

    if (-not $processes) {
        # If no process is found, launch it with arguments
        if ($LaunchArguments) {
            Start-Process -FilePath $LaunchCommand -ArgumentList $LaunchArguments
        } else {
            Start-Process -FilePath $LaunchCommand
        }
    } else {
        # Find the first process with a valid MainWindowHandle
        foreach ($process in $processes) {
            if ($process.MainWindowHandle -ne [IntPtr]::Zero) {
                # Add User32.dll for window focusing
                Add-Type @"
using System;
using System.Runtime.InteropServices;
public class User32 {
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    public const int SW_RESTORE = 9;
}
"@
                # Restore the window if minimized and set it to the foreground
                [User32]::ShowWindow($process.MainWindowHandle, [User32]::SW_RESTORE) | Out-Null
                [User32]::SetForegroundWindow($process.MainWindowHandle) | Out-Null
                return
            }
        }
        Write-Host "No valid window found for process '$ProcessName'."
    }
}
# Call the function
Focus-Or-Launch -ProcessName $ProcessName -LaunchCommand $LaunchCommand
