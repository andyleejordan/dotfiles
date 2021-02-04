# Set-PsDebug -Trace 1

if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
}

function Update-Profile() {
  . $PROFILE.CurrentUserAllHosts
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

$isAdmin = Test-IsAdmin
$hostname = $(hostname)
try {
  Import-Module -Name posh-git -MinimumVersion 1.0.0 -ErrorAction Stop
  # Use a minimalish Git status.
  $GitPromptSettings.BeforeStatus = ""
  $GitPromptSettings.AfterStatus = " "
  $GitPromptSettings.PathStatusSeparator = ""
  $GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::DarkGreen
} catch {
  Write-Warning "posh-git is not installed! Try:"
  Write-Warning "Install-Module -Name posh-git -AllowPrerelease -Scope CurrentUser"
}

function prompt() {
  # Save the status before overwriting it.
  $originalLastExitCode = $global:LASTEXITCODE

  # Abbreviate home in the current path.
  # TODO: Limit the path length displayed.
  $regex = "^" + [regex]::Escape($HOME)
  $path = $executionContext.SessionState.Path.CurrentLocation.Path -replace $regex, '~'
  $path = $path.Replace('\', '/')
  $pathLength = 24
  if ($path.Length -gt $pathLength) {
    $path = "..." + $path.Substring($path.Length - $pathLength)
  }

  # Uncolored prompt string since posh-git is missing.
  if (!(Get-Command Write-Prompt)) {
    $global:LASTEXITCODE = $originalLastExitCode
    return "@$hostname $path $ "
  }

  # Otherwise build a colorized prompt string.
  $prompt = ""

  if (Test-Path variable:/PSDebugContext) {
    $prompt += Write-Prompt "[DBG] " -ForegroundColor ([ConsoleColor]::Yellow)
  }

  # Only print non-zero exit codes.
  if ($originalLastExitCode -ne 0) {
    $prompt += Write-Prompt "$originalLastExitCode " -ForegroundColor ([ConsoleColor]::Magenta)
  }

  $userColor = if ($isAdmin) { [ConsoleColor]::Red } else { [ConsoleColor]::DarkBlue }
  $prompt += Write-Prompt "@" -ForegroundColor $userColor
  $prompt += Write-Prompt "$hostname "
  $prompt += Write-Prompt "$path " -ForegroundColor ([ConsoleColor]::DarkBlue)
  $prompt += Write-VcsStatus
  $prompt += Write-Prompt "$" -ForegroundColor ([ConsoleColor]::DarkCyan)

  $global:LASTEXITCODE = $originalLastExitCode

  # Always return a space even if Write-Prompt uses Write-Host.
  return "$prompt "
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
