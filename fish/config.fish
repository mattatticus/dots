if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

alias vi nvim

alias e "eza --icons"
alias ea "eza --icons -a"
alias el "eza --icons -la"

set -gx EDITOR nvim

set -gx FZF_DEFAULT_OPTS "\
--color=spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS -m --preview='sh ~/.config/fzf_preview.sh {}'"

set -gx GOPATH "$XDG_DATA_HOME"/go
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx ZIG_LOCAL_CACHE_DIR "/tmp/zig-cache"
set -gx PARALLEL_HOME "$XDG_CONFIG_HOME"/parallel
set -gx NODE_REPL_HISTORY "$XDG_STATE_HOME"/node_repl_history
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

zoxide init fish | source
starship init fish | source
