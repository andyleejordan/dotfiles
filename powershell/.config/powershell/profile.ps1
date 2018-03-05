if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
}

Import-Module posh-git -ErrorAction SilentlyContinue
function prompt {
  # save the status before overwriting it
  $last_status = $LASTEXITCODE

  if (Test-Path variable:/PSDebugContext) {
    Write-Host "[DBG] " -ForegroundColor Yellow -NoNewLine
  }

  # only print non-zero exit codes
  if ($last_status -ne 0) {
    Write-Host "$last_status " -ForegroundColor Magenta -NoNewLine
  }

  # red @ for root, otherwise blue
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal] $identity
  if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $at_color = "Red"
  } else {
    $at_color = "Blue"
  }

  Write-Host "@" -ForegroundColor $at_color -NoNewLine
  Write-Host "$(hostname)" -NoNewLine

  # print git info if available
  if (Get-Module posh-git) {
    $GitPromptSettings.BeforeText = ' ('
    $GitPromptSettings.BeforeForegroundColor = [ConsoleColor]::DarkBlue
    $GitPromptSettings.AfterText = ')'
    $GitPromptSettings.AfterForegroundColor = [ConsoleColor]::DarkBlue
    $GitPromptSettings.BranchForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BranchGoneStatusForegroundColor = [ConsoleColor]::Red
    $GitPromptSettings.BranchIdenticalStatusToForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BranchAheadStatusForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BranchBehindStatusForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BranchBehindAndAheadStatusForegroundColor = [ConsoleColor]::DarkRed

    Write-VcsStatus
  }

  Write-Host " $(Get-Location)" -ForegroundColor Blue # NewLine
  Write-Host ">" -ForegroundColor Cyan -NoNewLine
  $LASTEXITCODE = $last_status
  return " " # satisfy the `prompt` function
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

if (Get-Command -Name hub -ErrorAction SilentlyContinue) {
    alias g hub
} else {
    alias g git
}

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
