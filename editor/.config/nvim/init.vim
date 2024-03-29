call plug#begin('~/.local/share/nvim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'

" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete-file.vim'
" Plug 'yami-beta/asyncomplete-omni.vim'
"Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'

" TeX
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug

" DSLs
Plug 'plasticboy/vim-markdown'
Plug 'bohlender/vim-smt2'
Plug 'petRUShka/vim-sage'


call plug#end()

set mouse=a

" Spaces
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

set relativenumber

set scrolloff=5
set hlsearch

hi Search cterm=NONE ctermfg=grey ctermbg=lightblue
"nnoremap <space> :noh<cr>:pc<cr>

" Highlight whitespace
set list
set listchars=tab:>-,trail:-,precedes:>

" Status line
set laststatus=2
set statusline=
set stl+=%f             " relative path to file
set stl+=\ %m           " modified? modifiable?
set stl+=%=             " expanding center space
set stl+=%y\            " [filetype]
"set stl+=0x%B\          " current byte (hex)
set stl+=(%3l,%2c)\     " line and column
set stl+=%P             " percentage

" Shortcuts
command! EV tabe $MYVIMRC
command! SV source $MYVIMRC
command! C set cursorline cursorcolumn
nnoremap <silent> <space> :noh<cr>

let g:ale_c_build_dir_names = ['build', 'target', 'debug', 'prod']
hi ALEWarning cterm=bold,underline gui=bold
hi SpellBad cterm=bold,underline gui=bold,undercurl ctermfg=1 ctermbg=0
hi SpellCap cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellRare cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellLocal cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi Pmenu ctermbg=8 ctermfg=15 cterm=NONE
hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold

let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"

" Vim Markdown
set conceallevel=2
let g:tex_conceal="abdgms"
hi clear Conceal
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 3

" Vimdiff
hi DiffAdd      ctermfg=2   ctermbg=none
hi DiffChange   ctermfg=7   ctermbg=none
hi DiffDelete   ctermfg=9   ctermbg=none
hi DiffText     ctermfg=11  ctermbg=none
if &diff
    syntax off
endif

" GNU Plot
au! BufRead,BufNewFile *.gnuplot    set filetype=gnuplot
au! BufRead,BufNewFile *.pl         set filetype=prolog

" LaTeX
let g:tex_flavor = "latex"

" Don't create .netrwhist
let g:netrw_dirhistmax = 0

" Format with cargo-fmt so that formatting is edition aware
let g:formatdef_rustfmt = '"rustfmt --edition 2018"'
let g:formatdef_brittany_hs = '"brittany"'
let g:formatters_haskell = ['brittany_hs']
let g:formatters_python = ['black']
let g:python_highlight_all = 1
"let g:autoformat_verbosemode=1
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" Debugging
" Show syntax stack
nmap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" LFSC
" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
au BufRead,BufNewFile *.plf set filetype=lisp

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" 
" if executable('pylsp')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pylsp',
"         \ 'cmd': {server_info->['pylsp']},
"         \ 'allowlist': ['python'],
"         \ })
" else
"     throw 'Missing pyls'
" endif
" if executable('rust-analyzer')
"   au User lsp_setup call lsp#register_server({
"         \   'name': 'Rust Analyzer',
"         \   'cmd': {server_info->['rust-analyzer']},
"         \   'whitelist': ['rust'],
"         \   'initialization_options': { 'completion': {'detailedLabel': v:false}},
"         \   'gook': { 'completion': {'detailedLabel': v:false}}
"         \ })
" else
"     throw 'Missing rust-analyzer'
" endif
" if executable('texlab')
"   au User lsp_setup call lsp#register_server({
"         \   'name': 'TexLab Language Server',
"         \   'cmd': {server_info->['texlab']},
"         \   'whitelist': ['tex'],
"         \ })
" else
"     throw 'Missing Texlab'
" endif
" if executable('ccls')
"   au User lsp_setup call lsp#register_server({
"         \   'name': 'CC Language Server',
"         \   'cmd': {server_info->['ccls']},
"         \   'whitelist': ['cpp', 'c'],
"         \ })
" else
"     throw 'Missing ccls'
" endif
" if executable('haskell-language-server-wrapper')
"   au User lsp_setup call lsp#register_server({
"         \   'name': 'HS-LS',
"         \   'cmd': {server_info->['haskell-language-server-wrapper']},
"         \   'root_uri':{server_info->lsp#utils#path_to_uri(
"         \    lsp#utils#find_nearest_parent_file_directory(
"         \      lsp#utils#get_buffer_path(),
"         \      ['hie.yaml', 'stack.yaml', '.git/']
"         \    ))},
"         \   'whitelist': ['haskell'],
"         \ })
" else
"     throw 'Missing haskell-language-server-wrapper'
" endif
" if executable('bash-language-server')
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'bash-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
"         \ 'allowlist': ['sh', 'zsh'],
"         \ })
" endif
" 
" "let g:asyncomplete_log_file = "./autocomplete.log"
" 
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'allowlist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))
" 
" function! s:on_lsp_buffer_enabled() abort
"     echom "LSP enabled"
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gs <plug>(lsp-document-symbol-search)
"     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     "nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     inoremap <buffer> <expr><c-f> lsp#scroll(+4)
"     inoremap <buffer> <expr><c-d> lsp#scroll(-4)
" 
"     let g:lsp_document_highlight_enabled = 0
" 
"     let g:lsp_format_sync_timeout = 1000
"     " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
"     " refer to doc to add more commands
" endfunction
" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

nnoremap U :syntax sync fromstart<cr>


" builtin lsp
lua << EOF
-- Compe setup
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };
  source = {
    path = true;
    nvim_lsp = true;
    buffer = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- --This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pylsp', 'rust_analyzer', 'ccls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp['texlab'].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = { ['textDocument/publishDiagnostics'] = function() end }
}
--vim.lsp.set_log_level("DEBUG")
--print(vim.lsp.get_log_path())
EOF
