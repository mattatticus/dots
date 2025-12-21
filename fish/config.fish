if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

alias vi nvim
alias e 'exa --icons'
alias ea 'exa --icons -a'
alias el 'exa --icons -la'

set -gx EDITOR nvim

zoxide init fish | source
