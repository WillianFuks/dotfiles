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

### DAP Configurations

By default, on each BufWinEnter (as defined in `lua/user/autocmds.lua`), a search for the file "launch.json" is performed right at the
`cwd` of lvim or at `cwd .. /.vscode/launch.json`. If it returns true, then the configs in the file are also loaded for the respective
filetype.

An example of setting a custom configuration for a Flask debugger:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "python",
      "request": "launch",
      "name": "Flask Debugger",
      "module": "flask",
      "cwd": "${fileDirname}",
      "env": {
          "FLASK_APP": "app.py",
          "FLASK_DEBUG": "1"
      },
      "args": [
        "run",
        "--no-debugger",
        "--no-reload"
      ],
      "jinja": true,
      "justMyCode": true
    }
  ]
}
```

It's possible to add as many configs as desired in the `configurations` list entry.
