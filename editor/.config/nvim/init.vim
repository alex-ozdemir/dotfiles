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
