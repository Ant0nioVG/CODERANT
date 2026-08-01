return {
  "b0o/incline.nvim",
  priority = 1000,
  config = function()
    local mode_colors = {
      n = { " NORMAL ", "#a3be8c" },
      i = { " INSERT ", "#ebcb8b" },
      v = { " VISUAL ", "#b48ead" },
      V = { " V-LINE ", "#b48ead" },
      ["\22"] = { " V-BLOCK ", "#b48ead" },
      c = { " COMMAND ", "#88c0d0" },
      s = { " SELECT ", "#bf616a" },
    }
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 1, vertical = 0 },
      },
      render = function(props)
        local mode = vim.fn.mode()
        local current_mode = mode_colors[mode] or { " UNKNOWN ", "#ffffff" }
        local mode_name, mode_bg = current_mode[1], current_mode[2]
        local mode_hl = {
          mode_name,
          guifg = "#1e1e2e",
          guibg = mode_bg,
          gui = "bold",
        }
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local file_hl = {
          " " .. filename .. " ",
          guifg = "#cdd6f4",
          guibg = "#313244",
        }
        return { mode_hl, file_hl }
      end,
    })
  end,
}
