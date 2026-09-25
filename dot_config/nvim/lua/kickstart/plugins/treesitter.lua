return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    -- Nvim 0.12 requires the new `main` branch (a full rewrite with a new API).
    -- The archived `master` branch is incompatible with 0.12 and crashes on
    -- markdown fenced code blocks with "attempt to call method 'range' (a nil
    -- value)" (nvim-treesitter#8618, neovim#39032).
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    config = function()
      require('nvim-treesitter').setup {
        -- Explicit so the dir is prepended to 'runtimepath' (default value)
        install_dir = vim.fn.stdpath('data') .. '/site',
      }
      -- Install parsers (no-op if already installed; runs asynchronously).
      -- Full list of previously installed languages (tmux is no longer
      -- supported upstream; its old parser .so keeps working as-is).
      require('nvim-treesitter').install {
        'bash', 'c', 'css', 'desktop', 'diff', 'dockerfile', 'gitcommit', 'gitignore', 'html', 'hyprlang',
        'ini', 'json', 'luadoc', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'requirements',
        'ssh_config', 'toml', 'typescript', 'vimdoc', 'vim', 'xml', 'yaml',
      }
      -- Treesitter highlighting is provided by Neovim itself; start it for
      -- buffers whose filetype has a parser installed (no-op otherwise).
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function(ev)
          vim.treesitter.start(ev.buf)
          -- Treesitter highlighting disables regex syntax by default; keep it
          -- for ruby (was `additional_vim_regex_highlighting = { 'ruby' }` on
          -- the old master branch).
          if vim.bo[ev.buf].filetype == 'ruby' then
            vim.bo[ev.buf].syntax = 'ON'
          end
          -- Treesitter indentation (experimental), previously
          -- `indent = { enable = true, disable = { 'ruby' } }` on master.
          if vim.bo[ev.buf].filetype ~= 'ruby' then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few of them and see what interests you:
    --
    --    - Incremental selection: Included in `:help nvim-treesitter-incremental-selection-mod`
    --    - Show current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
