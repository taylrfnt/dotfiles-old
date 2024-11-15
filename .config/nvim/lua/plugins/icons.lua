return {
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup({
        -- Overrides can be specified by types (https://github.com/nvim-tree/nvim-web-devicons/blob/19d257cf889f79f4022163c3fbb5e08639077bd8/lua/nvim-web-devicons.lua#L146)
        --  override = {
        --    gitignore = {
        --      icon = "󰊢",
        --      color = "#ffb58a",
        --      name = "Gitignore"
        --    }
        --  },

        -- You can also override by filenames rather than types 
        override_by_filename = {
          [ ".gitignore" ] = {
            icon = "󰊢",
            color = "#ffb58a",
            name = "Gitconfig"
          },
          [ ".gitconfig" ] = {
            icon = "󰊢",
            color = "#ffb58a",
            name = "Gitconfig"
          },
        },
      })
    end,
  }
}
