param (
    [string]$ProcessName,  # The name of the process (e.g., "WindowsTerminal")
    [string]$LaunchCommand # Command to launch the process if not running (e.g., "wt")
)

function Focus-Or-Launch {
param (
        [string]$ProcessName,
        [string]$LaunchCommand
    )

    # Check if the process is running
    if (-not (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue)) {
        # Launch the process
        Start-Process $LaunchCommand
    } else {
        # Get the main window handle of the process
        $hwnd = (Get-Process -Name $ProcessName).MainWindowHandle
        if ($hwnd) {
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
            [User32]::ShowWindow($hwnd, [User32]::SW_RESTORE) | Out-Null
            [User32]::SetForegroundWindow($hwnd) | Out-Null
        }
    }
}

# Call the function
Focus-Or-Launch -ProcessName $ProcessName -LaunchCommand $LaunchCommand
