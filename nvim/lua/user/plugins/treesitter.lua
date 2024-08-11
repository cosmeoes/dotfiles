require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = { 'NvimTree' },
    additional_vim_regex_highlighting = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ['ia'] = '@parameter.inner',
        ['aa'] = '@parameter.outer',
      },
    },
  },
  -- context_commentstring = {
  --   enable = true,
  -- },
})

-- require('ts_context_commentstring').setup({})
-- vim.g.skip_ts_context_commentstring_module = true
