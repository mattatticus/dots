#   ／l、             
# （ﾟ､ ｡ ７         
#   l  ~ヽ       
#   じしf_,)ノ
if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_command_not_found;
    __fish_default_command_not_found_handler $argv
end

function fish_greeting;
end

function e;
    exa --icons $argv
end

function ea;
    exa -a --icons $argv
end

function el;
    exa -l --icons $argv
end

function eal;
    exa -a -l --icons $argv
end

function vi;
    nvim $argv
end

zoxide init fish | source
starship init fish | source

fish_hybrid_key_bindings
bind -M insert ctrl-n down-or-search

set -gx EDITOR nvim
set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
