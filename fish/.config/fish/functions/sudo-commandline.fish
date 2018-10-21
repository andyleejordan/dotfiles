function sudo-commandline -d "Insert sudo at the beginning of the command line"
    set -l cmdline (commandline)
    commandline -r -- "sudo $cmdline"
end
