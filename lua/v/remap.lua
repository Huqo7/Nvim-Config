local wk = require("which-key")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(event)
    local buf = event.buf

    -- Normal-mode LSP maps (buffer-local)
    wk.add({
      -- g-keys
      { "gd",         vim.lsp.buf.definition,       desc = "Go to definition" },
      { "gl",         vim.diagnostic.open_float,    desc = "Line diagnostics" },

      -- hover
      { "K",          vim.lsp.buf.hover,            desc = "Hover" },

      -- diagnostics navigation (]d = next, [d = prev)
      { "]d",         vim.diagnostic.goto_next,     desc = "Next diagnostic" },
      { "[d",         vim.diagnostic.goto_prev,     desc = "Prev diagnostic" },

      -- <leader>l group
      { "<leader>l",  group = "LSP" },
      { "<leader>la", vim.lsp.buf.code_action,      desc = "Code action" },
      { "<leader>lr", vim.lsp.buf.references,       desc = "References" },
      { "<leader>ln", vim.lsp.buf.rename,           desc = "Rename" },
      { "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol" },
      { "<leader>ld", vim.diagnostic.open_float,    desc = "Diagnostics (float)" },
    }, { mode = "n", buffer = buf })

    -- Insert-mode map (buffer-local)
    wk.add({
      { "<C-h>", vim.lsp.buf.signature_help, desc = "Signature help" },
    }, { mode = "i", buffer = buf })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({ async = false, id = event.data.client_id })
      end,
    })
  end,
})

wk.add({
  -- leader group
  { "<leader>e",  function() vim.cmd.Ex() end,                              desc = "Open file explorer" },
  { "<leader>p",  "\"_dP",                                                  desc = "Paste without overwrite" },
  { "<leader>/",  "<Plug>(comment_toggle_linewise_current)",                desc = "Toggle comment",                    remap = true },
  { "<leader>s",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],   desc = "Search & replace word under cursor" },

  -- non-leader
  { "J",          "mzJ`z",                                                  desc = "Join lines and keep cursor" },
  { "<C-d>",      "<C-d>zz",                                                desc = "Half page down & center" },
  { "<C-u>",      "<C-u>zz",                                                desc = "Half page up & center" },
  { "n",          "nzzzv",                                                  desc = "Next search result & center" },
  { "N",          "Nzzzv",                                                  desc = "Prev search result & center" },
  { "Q",          "<nop>",                                                  desc = "Disable Ex mode" },

  -- Telescope group + mappings
  { "<leader>f",  group = "Find" },
  { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
  { "<leader>fg", function() require("telescope.builtin").git_files() end,  desc = "Find git files" },
  { "<leader>fl", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },

  -- Symbols Outline
  { "<leader>o",  "<cmd>SymbolsOutline<CR>",                                desc = "Toggle Symbols Outline" },
}, { mode = "n" })
