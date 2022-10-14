## Caveats

Apparently, `eslint_d` may not work on first try on js/ts projects. Simply go to the local `node_modules/eslint_d` folder and run

    ./eslint_d stop && ./eslint_d start

This restarting of the eslint_d server will make the linter work.

## References
https://github.com/nanotee/nvim-lua-guide#defining-mappings
https://github.com/NvChad/NvChad/tree/main
https://github.com/LunarVim/LunarVim/tree/rolling
https://github.com/LunarVim/Neovim-from-scratch
