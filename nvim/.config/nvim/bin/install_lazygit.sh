#!/bin/bash

FILE_PATH=/tmp/lazygit.tar.gz
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')

curl -Lo $FILE_PATH "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar xf $FILE_PATH -C "$HOME/.local/bin"
