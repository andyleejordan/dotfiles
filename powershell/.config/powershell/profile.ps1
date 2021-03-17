# NOTE: Debug with `Set-PsDebug -Trace 1`

if ($PSVersionTable.PSVersion -lt "6.0") {
  $global:IsWindows = $true
}

if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
  Set-PSReadLineOption -Colors @{
    "Command"            = [ConsoleColor]::DarkBlue
    "Default"            = [ConsoleColor]::Blue
    "Member"             = [ConsoleColor]::DarkYellow
    "Number"             = [ConsoleColor]::Magenta
    "Operator"           = [ConsoleColor]::DarkGreen
    "Parameter"          = [ConsoleColor]::DarkCyan
    "Type"               = [ConsoleColor]::DarkMagenta
    "Variable"           = [ConsoleColor]::DarkGreen
    "ContinuationPrompt" = [ConsoleColor]::DarkGray
  }
}

Set-Alias g git # NOTE: Must be set before importing posh-git.
Set-Alias grep Select-String
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive

function Test-IsAdmin {
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
$hostname = $(hostname -s)
try {
  Import-Module -Name posh-git -MinimumVersion 1.0.0 -ErrorAction Stop
  # Use a minimalish Git status.
  $GitPromptSettings.BeforeStatus = ""
  $GitPromptSettings.AfterStatus = ""
  $GitPromptSettings.PathStatusSeparator = ""
  $GitPromptSettings.BranchIdenticalStatusSymbol.ForegroundColor = [ConsoleColor]::DarkGreen
  $GitPromptSettings.BranchAheadStatusSymbol.ForegroundColor = [ConsoleColor]::DarkYellow
  $GitPromptSettings.BranchBehindAndAheadStatusSymbol.ForegroundColor = [ConsoleColor]::DarkMagenta
} catch {
  Write-Warning "posh-git is not installed! Try:"
  Write-Warning "Install-Module -Name posh-git -AllowPrerelease -Scope CurrentUser"
}

function prompt {
  # Save the status before overwriting it.
  $originalLastExitCode = $global:LASTEXITCODE

  # Abbreviate home in the current path.
  # TODO: Limit the path length displayed.
  $regex = "^" + [regex]::Escape($HOME)
  $path = $executionContext.SessionState.Path.CurrentLocation.Path -replace $regex, '~'
  $path = $path.Replace('\', '/')
  $pathLength = 32
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

  # TODO: Use green if SSH connection.
  $prompt += Write-Prompt "@" -ForegroundColor ([ConsoleColor]::DarkBlue)
  $prompt += Write-Prompt "$hostname "
  $prompt += Write-Prompt "$path " -ForegroundColor ([ConsoleColor]::DarkBlue)
  $prompt += Write-VcsStatus
  $promptColor = if ($isAdmin) { [ConsoleColor]::Red } else { [ConsoleColor]::DarkCyan }
  $prompt += Write-Prompt "`n>" -ForegroundColor $promptColor

  $global:LASTEXITCODE = $originalLastExitCode

  # Always return a space even if Write-Prompt uses Write-Host.
  return "$prompt "
}

function Update-Profile {
  . $PROFILE.CurrentUserAllHosts
}

<#
.SYNOPSIS
  Initialize the 1Password CLI.
.DESCRIPTION
  This sets the necessary environment variable after using their CLI to
  interactively login. Combined with
  https://github.com/cdhunt/SecretManagement.1Password this provides secrets!
#>
function Initialize-1Password {
  $env:OP_SESSION_my = op signin my --raw
}

function Find-Command { (Get-Command @args).Source }

function ls {
  if ($IsWindows) {
    Get-ChildItem
  } elseif ($IsMacOS) {
    & gls --color @args
  } else {
    & /bin/ls --color @args
  }
}

function New-Symlink {
  param([string]$target, [string]$link)
  New-Item -ItemType SymbolicLink -Target $target -Name $link
}

function Show-Colors {
  $colors = [Enum]::GetValues([ConsoleColor])
  $max = ($colors | ForEach-Object { "$_ ".Length } | Measure-Object -Maximum).Maximum
  foreach ($color in $colors) {
    Write-Host (" {0,2} {1,$max} " -f [int]$color, $color) -NoNewline
    Write-Host "$color" -Foreground $color
  }
}

<#
.SYNOPSIS
  Idempotently add/move paths to the front/back of your PATH.
.DESCRIPTION
  Will only add the path if it exists (but does not error). Defaults to adding
  to the back as this is safer. Can be called repeatedly (such as in a profile)
  but will always result in the same output (idempotent).
#>
function Edit-Path {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidateScript({ Test-Path -Path $_ -IsValid })]
    # List of paths to add.
    [string[]]$Path,
    # Switch to add paths to the front instead of the back.
    [switch]$Front = $false
  )
  begin { $acc = [Collections.Generic.List[string]]::new() }
  process {
    $Path | Where-Object { Test-Path $_ } |
      ForEach-Object { $acc.Add([string](Resolve-Path $_)) }
  }
  end {
    $old = $env:PATH.split([IO.Path]::PathSeparator) | Where-Object { $_ -notin $acc }
    $new = if ($Front) { @($acc; $old) } else { @($old; $acc) }
    $p = $new -join [IO.Path]::PathSeparator
    if ($PSCmdlet.ShouldProcess("Updating PATH from:`n$env:PATH`nto:`n$p", $env:PATH, $p)) {
      $env:PATH = $p
    }
  }
}

Edit-Path -Front /sbin, /usr/sbin, /usr/local/sbin, /usr/local/bin, /usr/bin, /bin
Edit-Path ~/bin, ~/.local/bin, ~/.poetry/bin, ~/.cargo/bin, ~/.dotnet/tools, /usr/local/share/dotnet, /usr/local/microsoft/powershell/7

# macOS
Edit-Path -Front /opt/homebrew/bin
Edit-Path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

$local = "$PSScriptRoot/profile_local.ps1"
(Test-Path $local) -And (. $local) > $null
