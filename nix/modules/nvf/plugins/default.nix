{pkgs, ...}:
with pkgs.vimPlugins; {
  smart-splits = {
    setup = ''
      require('smart-splits').setup({
        resize_mode = {
          silent = true,
          hooks = {
            on_enter = function()
              vim.notify('Entering resize mode')
            end,
            on_leave = function()
              vim.notify('Exiting resize mode')
            end,
          },
        },
      })
    '';
    package = smart-splits-nvim;
  };
}
