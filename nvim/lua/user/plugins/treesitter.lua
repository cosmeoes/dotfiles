
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    cond = function(lang, bufnr) -- Disable in large C++ buffers
      return not (vim.api.nvim_buf_line_count(bufnr) > 50000)
    end,
    disable = { 'NvimTree' },
    additional_vim_regex_highlighting = false,
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

