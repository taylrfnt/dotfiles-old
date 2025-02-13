-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.comment.mini-comment" },
  -- packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.swift" },
  { import = "astrocommunity.pack.helm" },
  -- java... see https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack/java
  -- { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.templ" },
  -- misc
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },

  -- import/override with your plugins folder
}
