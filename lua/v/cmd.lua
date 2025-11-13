local filename = ".rules.verible_lint"

vim.api.nvim_create_user_command("VerilogConfig", function()
  local cwd = vim.fn.getcwd()
  local path = cwd .. "/" .. filename

  local exists = vim.fn.filereadable(path) == 1
  local size = vim.fn.getfsize(path)

  if exists and size > 0 then
    return
  end

  local lines = {
    "parameter-name-style=localparam_style:ALL_CAPS",
    "-always-comb",
    "-explicit-parameter-storage-type",
    "-unpacked-dimensions-range-ordering",
  }

  vim.fn.writefile(lines, path)
end, {})
