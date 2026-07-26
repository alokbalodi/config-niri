return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,

    opts = {
      flavour = "mocha",
      transparent_background = true,
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
