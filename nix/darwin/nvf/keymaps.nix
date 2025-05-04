[
  # NeoTree keymaps
  {
    key = "<leader>e";
    mode = "n";
    silent = true;
    # action = ":Neotree toggle<CR>";
    action = ":NvimTreeToggle<CR>";
    desc = "Toggle Explorer";
  }
  # This is a neo-tree mapping.  TODO: convert to nvimtree
  # {
  #   key = "<leader>o";
  #   mode = "n";
  #   silent = true;
  #   lua = true;
  #   action = ''
  #     function()
  #       if vim.bo.filetype == "neo-tree" then
  #         vim.cmd.wincmd "p"
  #       else
  #         vim.cmd.Neotree "focus"
  #       end
  #     end
  #   '';
  #   desc = "Toggle Explorer Focus";
  # }
  # easy quit keymap
  {
    key = "<leader>q";
    mode = "n";
    silent = true;
    action = ":q<CR>";
    desc = "Quit Current Window";
  }

  # smart-splits
  {
    key = "<C-h>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').move_cursor_left";
    lua = true;
    desc = "Move to left split";
  }
  {
    key = "<C-j>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').move_cursor_down";
    lua = true;
    desc = "Move to below split";
  }
  {
    key = "<C-k>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').move_cursor_up";
    lua = true;
    desc = "Move to above split";
  }
  {
    key = "<C-l>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').move_cursor_right";
    lua = true;
    desc = "Move to right split";
  }
  {
    key = "<A-h>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').resize_left";
    lua = true;
    desc = "Resize split left";
  }
  {
    key = "<A-j>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').resize_down";
    lua = true;
    desc = "Resize split down";
  }
  {
    key = "<A-k>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').resize_up";
    lua = true;
    desc = "Resize split up";
  }
  {
    key = "<A-l>";
    mode = "n";
    silent = true;
    action = "require('smart-splits').resize_right";
    lua = true;
    desc = "Resize split right";
  }

  # ToggleTerm keymaps
  {
    key = "<leader>tf";
    mode = "n";
    silent = true;
    action = ":ToggleTerm direction=float<CR>";
    desc = "ToggleTerm float";
  }
  {
    key = "<leader>th";
    mode = "n";
    silent = true;
    action = ":ToggleTerm direction=horizontal<CR>";
    desc = "ToggleTerm horizontal";
  }
  {
    key = "<leader>tv";
    mode = "n";
    silent = true;
    action = ":ToggleTerm direction=vertical<CR>";
    desc = "ToggleTerm vertical";
  }
  {
    key = "<leader>tl";
    mode = "n";
    silent = true;
    action = ":TermExec direction=float cmd=lazygit<CR>";
    desc = "ToggleTerm lazygit";
  }
  {
    key = "<leader>tk";
    mode = "n";
    silent = true;
    action = ":TermExec direction=float cmd=k9s<CR>";
    desc = "ToggleTerm k9s";
  }
]
