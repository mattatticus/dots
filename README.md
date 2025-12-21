# My configuration files

- Bar: [`Waybar`](https://github.com/Alexays/Waybar)
- Shell: [`Fish`](https://github.com/fish-shell/fish-shell)
- Editor: [`Neovim`](https://github.com/neovim/neovim)
- Terminal emulator: [`Kitty`](https://github.com/kovidgoyal/kitty)
- Wayland compositor: [`Niri`](https://github.com/YaLTeR/niri)
- Misc:
[`eza`](https://github.com/eza-community/eza),
[`zoxide`](https://github.com/ajeetdsouza/zoxide),
[`fzf`](https://github.com/junegunn/fzf),
[`ripgrep`](https://github.com/BurntSushi/ripgrep),
[`fd`](https://github.com/sharkdp/fd),
[`Kanata`](https://github.com/jtroo/kanata)

>[!NOTE]
>_Dotfiles are managed using GNU Stow_\
>_Neovim is built from source_

## Preparation

### Arch 

#### Install neovim from source (or use the AUR)
    I'll leave this to you :)
#### Install the required packages
    sudo pacman -S waybar stow niri kitty fish eza zoxide ripgrep fd

### Other flavours
#### Perform similar steps to install the required packages

## Install
    stow . -t ~/.config

## Uninstall
    stow -D . -t ~/.config
