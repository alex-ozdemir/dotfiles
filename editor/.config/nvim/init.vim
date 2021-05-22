call plug#begin('~/.local/share/nvim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
"Plug 'prabirshrestha/asyncomplete-buffer.vim'

" TeX
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug

" DSLs
Plug 'plasticboy/vim-markdown'
Plug 'vito-c/jq.vim'
Plug 'iden3/vim-circom-syntax'
Plug 'wizicer/vim-jison'
Plug 'tomlion/vim-solidity'
Plug 'vim-scripts/gnuplot.vim'
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
nnoremap <silent> <space> :noh<cr>:pc<cr>

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

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
if executable('pylsp')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
else
    throw 'Missing pyls'
endif
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
else
    throw 'Missing rust-analyzer'
endif
if executable('texlab')
  au User lsp_setup call lsp#register_server({
        \   'name': 'TexLab Language Server',
        \   'cmd': {server_info->['texlab']},
        \   'whitelist': ['tex'],
        \ })
else
    throw 'Missing Texlab'
endif

"let g:asyncomplete_log_file = "./autocomplete.log"

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

function! s:on_lsp_buffer_enabled() abort
    echom "LSP enabled"
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_document_highlight_enabled = 0

    let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

nnoremap U :syntax sync fromstart<cr>

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
