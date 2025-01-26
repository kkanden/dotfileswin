# MODULES 

## omp
oh-my-posh init pwsh --config ~/.config/.my-omp.omp.json | Invoke-Expression

## PSReadLine - autocompletion
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

## Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# EXTRA VARIABLES
$csconf = "$env:C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"
$Env:KOMOREBI_CONFIG_HOME = "$env:USERPROFILE\.config"
$Env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
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
