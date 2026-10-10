return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load first
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
}
