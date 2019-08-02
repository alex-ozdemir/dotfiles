call plug#begin('~/.local/share/nvim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'junegunn/fzf'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'

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
let g:deoplete#enable_at_startup = 1

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
nnoremap <space> :noh<cr>:pc<cr>

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
nnoremap <silent> <space> :noh<cr>:pc<cr>

" Completion
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'c': ['ccls'],
            \ 'cpp': ['ccls'],
            \ 'objc': ['ccls'],
            \ 'python': ['pyls'],
            \ }
let g:ale_c_build_dir_names = ['build', 'target', 'debug', 'prod']
autocmd BufEnter *.hh ALEDisable
autocmd BufEnter *.cc ALEDisable

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" <TAB>: completion.
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?"\<C-n>":"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

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
