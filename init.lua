local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  end
  vim.opt.rtp:prepend(lazypath)

  require("core.keymaps")
  require("core.settings")
  require("lazy").setup("core.plugins")

  pcall(require, "godot.init")
  pcall(require, "go.init")
