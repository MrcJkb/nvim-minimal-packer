-- Minimal nvim config with packer
-- Assumes a directory in $NVIM_DATA_MINIMAL
-- Start with nvim -u <path-to-this-config>
-- Then exit out of neovim and start again.


-- Ignore default config
local fn = vim.fn
local config_path = fn.stdpath('config') 
vim.opt.runtimepath:remove(config_path)

-- Ignore default plugins
local data_path = fn.stdpath('data')
local pack_path = data_path .. '/site'
vim.opt.packpath:remove(pack_path)

-- append temporary config and pack dir
local test_dir = os.getenv('NVIM_DATA_MINIMAL')
if not data_path then
  error('$NVIM_DATA_MINIMAL environment variable not set!')
end
vim.opt.runtimepath:append(test_dir)
vim.opt.packpath:append(test_dir)

-- bootstrap packer
local packer_install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.cmd('!git clone git@github.com:wbthomason/packer.nvim ' .. packer_install_path)
  vim.cmd('packadd packer.nvim')
  install_plugins = true
else
  vim.cmd('packadd packer.nvim')
end

local packer = require('packer') 

packer.init({
  package_root = test_dir .. '/pack',
  compile_path = test_dir .. '/plugin/packer_compiled.lua'
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  if install_plugins then
    packer.sync()
  end
end)

