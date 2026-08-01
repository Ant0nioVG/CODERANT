return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>f1",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.expand("~") })
      end,
      desc = "Search on any route (Home)",
    },
    {
      "<leader>sA",
      function()
        require("telescope.builtin").find_files({ cwd = "/" })
      end,
      desc = "Search from system root",
    },
  },
}
