-- https://github.com/BattleCh1cken/nvim-dotfiles/blob/master/lua/init.lua
local cmd = vim.cmd
local ok, packer = pcall(require, 'packer')

if not ok then
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    vim.fn.delete(install_path, 'rf')
    vim.fn.system {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}

    cmd 'packadd packer.nvim'
    packer_cloned, packer = pcall(require, 'packer')
    if not packer_cloned then
        error('Failed to clone packer.nvim')
    end

    _sync_packer = true
end

packer.init {
    compile_path = vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float {
                border = 'single'
            }
        end,
        prompt_border = 'single'
    },
    git = {
        clone_timeout = 600
    },
    ensure_dependencies = true,
    auto_clean = true,
    autoremove = true,
    compile_on_sync = true,
    auto_reload_compiled = true,
    luarocks = {
        python_cmd = vim.env.HOMEBREW_PREFIX .. '/bin/python3' -- Set the python command to use for running hererocks
    }
}

return packer
