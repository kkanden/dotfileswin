$startTime = Get-Date
# MODULES 

## omp
oh-my-posh init pwsh --config "$env:USERPROFILE/.config/.my-omp.omp.json" | Invoke-Expression

## PSReadLine - autocompletion
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyhandler -Chord "Ctrl+b" -Function AcceptSuggestion
Set-PSReadLineKeyhandler -Chord "Ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyhandler -Chord "Ctrl+p" -Function HistorySearchBackward


## Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

## Terminal Icons
Import-Module Terminal-Icons

# EXTRA VARIABLES
$csconf = "$env:C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"
$Env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$Env:KOMOREBI_CONFIG_HOME = "$env:USERPROFILE\.config\komorebi"
$Env:WHKD_CONFIG_HOME = "$env:USERPROFILE\.config\whkd"
$Env:RIPGREP_CONFIG_PATH = "$env:USERPROFILE\.config\.ripgrep"

# ALIASES
Del Alias:r
Set-Alias -Name R -Value 'R.exe'
Set-Alias -Name r -Value 'R.exe'

# EXTRA FUNCTIONS

## fzf into nvim

function gs {
    git status
}

function nvimf {
    $file = fzf --preview="bat --color=always {}"
    if ($file) {
        nvim $file
    }
}

function dotfiles {
    pushd $env:USERPROFILE\.config
    gs
}

function nvimconf {
    pushd $env:USERPROFILE\.config\nvim\
    git status
}

## imitate unix `which`
function which ($command) { 
  Get-Command -Name $command -ErrorAction SilentlyContinue | 
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
}


### ENABLE ZOXIDE - must be on the end
Invoke-Expression (& { (zoxide init powershell | Out-String) })


$version = $PSVersionTable.PSVersion
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
"PowerShell $($version.Major).$($version.Minor).$($version.Patch) took $($elapsedTime.TotalMilliseconds) ms" | cowsay | meow
