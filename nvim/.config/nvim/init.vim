-- https://gitlab.com/-/snippets/4797133

--[[
    
This file goes in ${HOME}/.config/nvim/init.lua:

curl -fLo $HOME/.config/nvim/init.lua --create-dirs \
        https://gitlab.com/-/snippets/4797133/raw/main/init.lua

Before running nvim straight after downloading this file:

- install vim-plug:

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

- install the plugins, possibly setting the environment variable NVIM_MINIMAL
  to anything in order to install only basic plugins

nvim --headless +PlugInstall +qall

]]--

local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'polirritmico/monokai-nightasty.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    if not os.getenv("NVIM_MINIMAL") then
        Plug 'echasnovski/mini.nvim'
        Plug 'nvim-treesitter/nvim-treesitter'
    end
vim.call('plug#end')

vim.opt.background = "dark"
-- my favourite theme :)
require("monokai-nightasty").load()

-- powerline like
require('lualine').setup()
-- indent matching
require('ibl').setup()

if not os.getenv("NVIM_MINIMAL") then
    -- minimal completion plugin
    require('mini.completion').setup()
    -- code highlighting and more
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "go", "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "json", "yaml" },
        highlight = {
            enable = true,
        },
        run = ':TSUpdate',
    }
end

-- no mouse integration
vim.opt.mouse = ""
-- show line numbers
vim.opt.number = true
-- tab space 8
vim.opt.ts = 8

-- Ctrl-t - new tab
vim.keymap.set('n', '<C-t>', ':tabe<CR>', { noremap = true, silent = true })
-- Ctrl-left - previous tab
vim.keymap.set('n', '<C-Left>', 'gT', { noremap = true, silent = true })
-- Ctrl-right - next tab
vim.keymap.set('n', '<C-Right>', 'gt', { noremap = true, silent = true })
