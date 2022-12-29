require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "c", "java", "lua" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}
