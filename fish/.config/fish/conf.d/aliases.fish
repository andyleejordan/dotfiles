if type -q hub
    alias g hub
    complete --command hub --wraps git
    complete --command g --wraps hub
else
    alias g git
    complete --command g --wraps git
end

alias e 'emacsclient --alternate-editor="" --no-wait'
alias ec 'e --create-frame'

alias p package

alias rg 'rg --smart-case'
