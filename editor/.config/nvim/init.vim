call plug#begin('~/.local/share/nvim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'git@framagit.org:alex-ozdemir/coquille.git'

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

let g:ale_c_build_dir_names = ['build', 'target', 'debug', 'prod']
hi ALEWarning cterm=bold,underline gui=bold
hi SpellBad cterm=bold,underline gui=bold,undercurl ctermfg=1 ctermbg=0
hi SpellCap cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellRare cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi SpellLocal cterm=bold,underline gui=bold,undercurl ctermfg=4 ctermbg=0
hi Pmenu ctermbg=0 ctermfg=15 cterm=bold

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
let b:formatdef_rustfmt = '"rustfmt --edition 2018"'
let g:python_highlight_all = 1

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

"let g:autoformat_verbosemode=1

" Coq
au FileType coq call coquille#FNMapping()

