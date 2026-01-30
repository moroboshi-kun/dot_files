-- ============================================================
-- Plugin management (lazy.nvim)
-- ============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ----------------------------------------------------------
  -- Colorscheme: TokyoNight
  -- ----------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "moon"
      vim.g.tokyonight_terminal_colors = true
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- ----------------------------------------------------------
  -- Statusline: lualine
  -- ----------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          section_separators = "",
          component_separators = "",
          globalstatus = false, -- keep Vim-like behavior
        },
      })
    end,
  },

})

