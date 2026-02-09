Installing neovim:


    # download latest release
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

    # make executable
    chmod u+x nvim.appimage

    # optional: move to system path
    sudo mv nvim.appimage /usr/local/bin/nvim

    # verify
    nvim --version
