return {
  "folke/tokyonight.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("tokyonight").setup({
      style = "night",     -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true,  -- Enable this to disable setting the background color
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
