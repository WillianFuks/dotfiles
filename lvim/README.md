# General

### Initialization

To begin on a new environment, git clone the repository "dotfiles" and create a symlink to the `$HOME/.config/lvim` folder, like so:

    cd ~/.config
    ln -s ~/Documents/repos/dotfiles/lvim/ .


### Plugins

Add a new plugin in the file `get_config_dir() .. lua/user/plugins.lua` like so:

```lua
lvim.plugins = {
  
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  }
}
```

Then run `:LvimReload` which syncs Packer appropriately. Restart nvim and you are good to go.
