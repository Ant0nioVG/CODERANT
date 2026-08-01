return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {

        width = 60,
        row = nil,
        col = nil,
        pane_gap = 4,
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        preset = {

          pick = nil,
          keys = {
            {
              action = ": lua LazyVim.pick()()",
              desc = "Find File",
              icon = " ",
              key = "f",
            },
            {
              action = ": ene | startinsert",
              desc = "New File",
              icon = " ",
              key = "n",
            },
            {
              action = ': lua LazyVim.pick("oldfiles")()',
              desc = "Recent Files",
              icon = " ",
              key = "r",
            },
            {
              action = ': lua LazyVim.pick("live_grep")()',
              desc = "Find Text",
              icon = " ",
              key = "g",
            },
            {
              action = function()
                require("yazi").yazi("~/.config/nvim")
              end,
              desc = "Config",
              icon = " ",
              key = "c",
            },
            {
              action = ': lua require("persistence").load()',
              desc = "Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = ": LazyExtras",
              desc = "Lazy Extras",
              icon = " ",
              key = "x",
            },
            {
              action = ": Lazy",
              desc = "Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = "Quit",
              icon = " ",
              key = "q",
            },
          },
          header = [[]],
        },
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return Snacks.dashboard.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
  },
}
