local options = {
  clipboard = "unnamedplus",
  cmdheight = 0,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = false,
  ignorecase = true,                       -- ignore case in search patterns
  laststatus = 3,
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  relativenumber = true,
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  signcolumn = "yes",
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  timeoutlen = 200,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 100,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  number = true,                           -- set numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  virtualedit = "onemore",
  wrap = false,
  whichwrap = "<,>,[,]",
}

vim.wo.fillchars = 'eob: '

-- if vim.fn.has('wsl') == 1 then
--   vim.g.clipboard = {
--     name = 'WslClipboard',
--     copy = {
--       ['+'] = '/mnt/c/Windows/System32/clip.exe',
--       ['*'] = '/mnt/c/Windows/System32/clip.exe',
--     },
--     paste = {
--       ['+'] =
--       '/mnt/c/Windows/System32/WindowsPowershell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--       ['*'] =
--       '/mnt/c/Windows/System32/WindowsPowershell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enabled = 0,
--   }
-- end

for k, v in pairs(options) do
  vim.opt[k] = v
end
