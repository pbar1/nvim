-- Install packer if not already installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- FIXME: Expand this to be any file in the project
-- Run :PackerCompile if this file is modified
vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]])

-- Initialize packer
local packer = require("packer")
packer.init({
	enable = true, -- Enable profiling with :PackerCompile profile=true
	threshold = 0, -- Amount in ms that a plugin load time must exceed to be included in profile
})
local use = packer.use
packer.reset()

-- Convenience function for importing plugin config from a module.
-- Intended for Packer `config` parameter of the `use` function.
-- FIXME: How does the returned string get coerced into executable code?
local function get_config(name)
	return string.format('require("config/%s")', name)
end

-- Load plugins
use("wbthomason/packer.nvim") -- Package manager
use("tpope/vim-fugitive") -- Git commands in nvim
use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
--use("ludovicchabant/vim-gutentags") -- Automatic tags management
-- UI to select things (files, grep results, open buffers...)
use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
use("mjlbach/onedark.nvim") -- Theme inspired by Atom
use({ "nvim-lualine/lualine.nvim", config = get_config("lualine") }) -- Fancier statusline
-- Add indentation guides even on blank lines
use("lukas-reineke/indent-blankline.nvim")
-- Add git related info in the signs columns and popups
use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
-- Highlight, edit, and navigate code using a fast incremental parsing library
use("nvim-treesitter/nvim-treesitter")
-- Additional textobjects for treesitter
use("nvim-treesitter/nvim-treesitter-textobjects")
use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
use("hrsh7th/nvim-cmp") -- Autocompletion plugin
use("hrsh7th/cmp-nvim-lsp")
use("saadparwaiz1/cmp_luasnip")
use("L3MON4D3/LuaSnip") -- Snippets plugin
