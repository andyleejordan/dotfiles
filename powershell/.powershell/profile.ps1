function prompt {
    $location = ([string]$(get-location)).Replace($HOME, '~')
   "$location |-/ "
}

Set-Alias g git

function e {
    emacsclient --alternate-editor="" --create-frame $Args
}
