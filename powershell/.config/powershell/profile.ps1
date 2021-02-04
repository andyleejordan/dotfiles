if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
}

function Test-IsAdmin() {
  if ($IsWindows) {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $id
    $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  } else {
    $id = id -u
    $id -eq 0
  }
}

Import-Module posh-git -ErrorAction SilentlyContinue

function prompt() {
  # save the status before overwriting it
  $last_status = $LASTEXITCODE

  if (Test-Path variable:/PSDebugContext) {
    Write-Host "[DBG] " -ForegroundColor ([ConsoleColor]::Yellow) -NoNewLine
  }

  # only print non-zero exit codes
  if ($last_status -ne 0) {
    Write-Host "$last_status " -ForegroundColor ([ConsoleColor]::Magenta) -NoNewLine
  }

  $at_color = if (Test-IsAdmin) { [ConsoleColor]::Red } else { [ConsoleColor]::DarkBlue }
  Write-Host "@" -ForegroundColor $at_color -NoNewLine
  Write-Host "$(hostname) " -NoNewLine
  $regex = "^" + [regex]::Escape($HOME)
  $path = $executionContext.SessionState.Path.CurrentLocation.Path -replace $regex, '~'
  $path = $path.Replace('\', '/')
  Write-Host "$path " -ForegroundColor ([ConsoleColor]::DarkBlue) -NoNewLine
  if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue) {
    $GitPromptSettings.BeforeText = ''
    $GitPromptSettings.AfterText = ' '
    $GitPromptSettings.BranchForegroundColor = [ConsoleColor]::DarkGreen
    $GitPromptSettings.BranchGoneStatusForegroundColor = [ConsoleColor]::DarkRed
    $GitPromptSettings.BranchIdenticalStatusToForegroundColor = [ConsoleColor]::DarkGreen
    $GitPromptSettings.BranchAheadStatusForegroundColor = [ConsoleColor]::DarkGreen
    $GitPromptSettings.BranchBehindStatusForegroundColor = [ConsoleColor]::DarkGreen
    $GitPromptSettings.BranchBehindAndAheadStatusForegroundColor = [ConsoleColor]::DarkRed
     Write-VcsStatus
  }
  Write-Host "$" -ForegroundColor ([ConsoleColor]::DarkCyan) -NoNewLine

  $LASTEXITCODE = $last_status
  return " " # satisfy the `prompt` function
}

Set-Alias g git
Set-Alias grep Select-String
Set-Alias less more
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive

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
  $max = ($colors | ForEach-Object { "$_ ".Length } | Measure-Object -Maximum).Maximum
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
