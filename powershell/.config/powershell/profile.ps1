if (Get-Module PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
}

Import-Module posh-git -ErrorAction SilentlyContinue
if (Get-Module posh-git) {
  $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
}

Set-Alias alias Set-Alias
alias g git
alias grep Select-String
alias less more
alias zip Compress-Archive
alias unzip Expand-Archive

function which { (Get-Command @args).Source }
function find { rg -i -uuu -l @args }
function rg { rg.exe -i --colors 'path:bg:white' @args }

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
