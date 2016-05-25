function prompt {
    $location = ([string]$(get-location)).Replace($HOME, '~')
   "$location |-/ "
}

Set-Alias g git

function e {
    emacsclient --alternate-editor="" $Args
}

$local = "$PSScriptRoot/profile_local.ps1"
(Test-Path $local) -And (. $local) > $null
