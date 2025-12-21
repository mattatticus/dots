if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

alias vi nvim
alias e 'eza --icons'
alias ea 'eza --icons -a'
alias el 'eza --icons -la'

set -gx EDITOR nvim

zoxide init fish | source
