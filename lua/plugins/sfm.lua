require("sfm").setup({
  view = {
    side = "left", -- side of the tree, can be `left`, `right`
    width = 30
  },
  mappings = {
    custom_only = false,
    list = {
      -- user mappings go here
    }
  },
  renderer = {
    icons = {
      file = {
        default = "",
        symlink = "",
      },
      folder = {
        default = "",
        open = "",
        symlink = "",
        symlink_open = "",
      },
      indicator = {
        folder_closed = "",
        folder_open = "",
        file = " ",
      }
    }
  }
})
