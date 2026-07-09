filetype plugin indent on
syntax on

set nocompatible

colorscheme torte

let mapleader = " "

" Appearance
set title
" set laststatus=2
" set statusline=
" set statusline+=%<%f\ %h%w%m%r%=
" set statusline+=\ %{&ff}
" set statusline+=\ %{&fileencoding}
" set statusline+=%14.(%l:%c%V%)
" set statusline+=\ %P

" Utils
set ruler
set showcmd
set wildmenu

" Line numbers
set number
set relativenumber
set numberwidth=4

" Tabs and indentation
set autoindent
set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Scroll off
set scrolloff=4
set sidescrolloff=8

" Line wrap
set nowrap
set breakindent
set formatoptions=l
set lbr

" Key code timeout and tty speed
set ttimeout
set ttimeoutlen=100
set ttyfast

" Disable swap files and backups
set noswapfile
set nobackup
set nowritebackup

" Spellcheck
set nospell
set spelllang=en_us

" Paste in visual mode without overwriting the yank register
vnoremap p "_dP

" Disable single 'q' recording, use 'qq' instead
nnoremap q <Nop>
nnoremap qq q

" Clear trailing white space on write
autocmd BufWritePre * %s/\s\+$//e

" Buffer navigation keymaps
noremap gb :bn<CR>
noremap gB :bp<CR>
autocmd filetype netrw nmap <buffer> gb :bn<CR>
autocmd filetype netrw nmap <buffer> gB :bp<CR>
nnoremap <Leader>b :ls<CR>:b<Space>

" Toggle line numbers
noremap <leader>r :set relativenumber!<CR>
noremap <leader>R :set relativenumber! number!<CR>

" Toggle colorcolumn
nnoremap <silent> <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? "100" : "")<CR>

" Netrw
let g:netrw_banner=0
let g:netrw_bufsettings='number relativenumber'
autocmd FileType netrw setlocal nocursorline

