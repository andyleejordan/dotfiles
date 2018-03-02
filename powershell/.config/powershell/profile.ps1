if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
}

Import-Module posh-git -ErrorAction SilentlyContinue
if (Get-Module posh-git) {
  # TODO: Make '@' blue, if possible. Also switch directory and Git info.
  $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
  $GitPromptSettings.DefaultPromptPrefix = '${env:USERNAME}@$(hostname) '
  $GitPromptSettings.DefaultPromptSuffix = '`n$(''>'' * ($nestedPromptLevel + 1)) '
}

$solarized = "$PSScriptRoot/Set-SolarizedDarkColorDefaults.ps1"
if (Test-Path $solarized) {
  . $solarized
  # Fish-like colors
  $options.CommandForegroundColor = 'DarkBlue'
  $options.ContinuationPromptForegroundColor = 'Blue'
  $options.DefaultTokenForegroundColor = 'Cyan'
  $options.EmphasisForegroundColor = 'Cyan'
  $options.StringForegroundColor = 'Yellow'
}

Set-Alias alias Set-Alias
alias g git
alias grep Select-String
alias less more
alias zip Compress-Archive
alias unzip Expand-Archive

function e { emacsclient -n @args }
function which { (Get-Command @args).Source }
function find { rg -i -uuu -l @args }
function rg { rg.exe -i --colors 'path:bg:white' @args }

function ln {
    param([switch]$s, [string]$target, [string]$link)
    New-Item -ItemType SymbolicLink -Target $target -Name $link
}

function Show-Colors() {
  $colors = [Enum]::GetValues([ConsoleColor])
  $max = ($colors | foreach { "$_ ".Length } | Measure-Object -Maximum).Maximum
  foreach ($color in $colors) {
    Write-Host (" {0,2} {1,$max} " -f [int]$color,$color) -NoNewline
    Write-Host "$color" -Foreground $color
  }
}

function path_pop([string]$path) {
  $env:PATH = ($env:PATH.split(';') | ?{ $_ -notmatch [regex]::escape($path) }) -join ';'
}

function path_front([string]$path) {
  path_pop($path)
  $env:PATH = $path,$env:PATH -join ';'
}

function path_back([string]$path) {
  path_pop($path)
  $env:PATH = $env:PATH,$path -join ';'
}

$local = "$PSScriptRoot/profile_local.ps1"
(Test-Path $local) -And (. $local) > $null
