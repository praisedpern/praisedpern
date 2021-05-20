" praisedpern's custom init.vim

" Detects if vim is running from Windows. If so, sets shell to PowerShell and
" the flags to make it work as per shell-powershell. Then installs vim-plug 
" https://github.com/junegunn/vim-plug via PowerShell method detailed in their
" README.md
if has('win32')
    set shell=powershell shellpipe=\| shellxquote= 
	set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
	set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif

let l = string(filter(split(execute(':scriptname'), "\n"), 'v:val =~? "plug.vim"'))
if l !~# "plug.vim"
    if has('win32')
        call system('iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force')
    elseif has('unix')
        call system("sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
               https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'")
    endif
endif

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

" retain hidden buffer (default is to abandon)
set hidden

" searches aren't case sensitive unless a capital letter is included
set smartcase

" writebackup makes a backup of a file before it is overwritten, then deletes 
" the backup on successful completion; undodir sets the directory where undo 
" files are saved, "." being the working directory
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

" Opens files in the place where you were last
augroup saveLineNumber
    autocmd BufReadPost *
        \ if line("'\'") > 0 && line("'\'") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END


