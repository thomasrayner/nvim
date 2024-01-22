
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
})

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_cmds,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs, des)
      vim.keymap.set(mode, lhs, rhs, {buffer = true, desc=des})
    end

    bufmap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Show hover tooltip')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Find references')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature help')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format text')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Open diagnostic float')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Goto prev')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Goto next')
  end
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'html',
    'cssls',
    'omnisharp',
    'powershell_es'
  },
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = lsp_capabilities,
      })
    end,
    ['tsserver'] = function()
      lspconfig.tsserver.setup({
        capabilities = lsp_capabilities,
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })
    end
  }
})
