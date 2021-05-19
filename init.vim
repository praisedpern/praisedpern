" praisedpern's custom init.vim

" TO DO: I'd like a sequence at the top of this file where first it checks for
" to see if plug is installed, then installs plug if it hasn't been already.
" This will be handy for installing nvim setup quickly on other machines. I'd
" also like to get this script to install the plugins that are listed if they
" haven't been already.

" tabs and indenting
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" look for .nvimrc in current directory on startup (for instance if you want
" custom init for specific project folders) 
set exrc

" set relative line numbers
set relativenumber
set nu
set signcolumn=yes
set cmdheight=2

" nohlsearch automatically clears highlighted search when finished; incsearch
" searches as you type, updating with each keypress
set nohlsearch
set incsearch

" retain hidden buffer (default it to abandon)
set hidden

" searches aren't case sensitive unless a capital letter is included
set smartcase

" writebackup makes a backup of a file before it is overwritten, deletes the
" backup on successful completion; undodir sets the directory where undo files
" are saved, . being the working directory
set writebackup
set undodir=.

" scrolls before you reach the bottom of the screen
set scrolloff=8

" colour customisation
set termguicolors

" load plugins
call plug#begin()
    Plug 'gruvbox-community/gruvbox'
call plug#end()

" set colorscheme
colorscheme gruvbox

" switches to absolute line numbers during insert mode
augroup toggleLineNumber
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

augroup saveLineNumber
    autocmd BufReadPost *
        \ if line("'\'") > 0 && line("'\'") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END
