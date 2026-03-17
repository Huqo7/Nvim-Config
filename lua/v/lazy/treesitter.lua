return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c", "lua", "vim", "vimdoc", "html", "python", "asm", "cmake"
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
