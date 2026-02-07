# Run

`stow` is necessary:

    sudo apt update
    sudo apt install stow

To run it apparently this is best option:

    stow --dir="$HOME/Documents/repos/dotfiles" --target="$HOME" nvim tmux
