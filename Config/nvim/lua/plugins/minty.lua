return {
  {
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    config = function()
      require("minty").setup()
    end,
  },
}
