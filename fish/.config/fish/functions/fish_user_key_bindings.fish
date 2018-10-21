# Thanks https://swsnr.de/blog/2018/10/05/sudo-fish/
function fish_user_key_bindings
    fish_default_key_bindings

    # Prepend sudo to the command line with M-s
    bind \es sudo-commandline
end
