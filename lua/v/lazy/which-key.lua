return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },

  opts = {
    preset = "modern",
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    defer = { gc = "Comments" },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },

    show_help = true,
    show_keys = true,

    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "g",        mode = "n" },
      { "[",        mode = "n" },
      { "]",        mode = "n" },
    },

    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }
}
