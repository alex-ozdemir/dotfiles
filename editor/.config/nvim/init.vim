call plug#begin('~/.local/share/nvim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vito-c/jq.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'
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
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
            \ 'c': ['ccls'],
            \ 'cpp': ['ccls'],
            \ 'objc': ['ccls'],
            \ }

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
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 3

" LaTeX
let g:tex_flavor = "latex"

" Don't create .netrwhist
let g:netrw_dirhistmax = 0
