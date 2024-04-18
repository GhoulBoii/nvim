return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function getWords()
        if vim.bo.buftype ~= "nofile" or vim.bo.filetype == "markdown" then
          if vim.fn.wordcount().visual_words == 1 then
            return tostring(vim.fn.wordcount().visual_words) .. " word"
          elseif not (vim.fn.wordcount().visual_words == nil) then
            return tostring(vim.fn.wordcount().visual_words) .. " words"
          else
            return tostring(vim.fn.wordcount().words) .. " words"
          end
        else
          return ""
        end
      end

      require('lualine').setup {
        options = {
          theme = pywal,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'filetype', getWords },
          lualine_z = { 'progress' },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end
  },
}
