return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({
        compile = false,
        transparent = true,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      })
    end,
  },
}
