call plug#begin('~/.local/share/nvim/plugged')

" LSP and completions
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug
Plug 'plasticboy/vim-markdown'
Plug 'bohlender/vim-smt2'

call plug#end()

" Added for v0.10 (https://neovim.io/doc/user/news-0.10.html); remove someday?
colorscheme vim
set notermguicolors

set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

set relativenumber

set scrolloff=5

" Status line
set laststatus=2
set statusline=
set stl+=%f             " relative path to file
set stl+=\ %m           " modified? modifiable?
set stl+=%=             " expanding center space
set stl+=%y\            " [filetype]
set stl+=(%3l,%2c)\     " line and column
set stl+=%P             " percentage

" Shortcuts
command! EV tabe $MYVIMRC
command! EX ! chmod +x %
command! SV source $MYVIMRC
nnoremap U :syntax sync fromstart<cr>
nnoremap <silent> <space> :noh<cr>

" Highlight whitespace
set list
set listchars=tab:>-,trail:-,precedes:>

" Spelling
hi SpellBad cterm=bold,underline gui=bold,undercurl ctermfg=1 ctermbg=0
hi SpellCap cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellRare cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellLocal cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0

" Popup styling
hi Pmenu ctermbg=8 ctermfg=15 cterm=NONE
hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold

" LaTeX
set conceallevel=2
let g:tex_conceal="abdgms"
let g:tex_flavor = "latex"
hi clear Conceal

" Vim Markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 3

" Autoformat
let g:formatdef_rustfmt = '"rustfmt --edition 2018"'
let g:formatdef_brittany_hs = '"brittany"'
let g:formatters_haskell = ['brittany_hs']
let g:formatters_python = ['black']
let g:python_highlight_all = 1
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
"let g:autoformat_verbosemode=1

function Sfmt()
    let line=getline('.')
    echom line
    let newline=system("sfmt", line)
    call setline(".", newline)
endfunction
command! Sfmt call Sfmt()


lua <<EOF
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
}, {
  { name = 'buffer' },
})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig = require'lspconfig'
lspconfig['pylsp'].setup { capabilities = capabilities }
lspconfig['rust_analyzer'].setup { capabilities = capabilities }
lspconfig['texlab'].setup { capabilities = capabilities, handlers = { ['textDocument/publishDiagnostics'] = function() end } }

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
-- vim.lsp.set_log_level("debug")
EOF
