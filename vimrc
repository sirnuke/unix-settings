set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

Bundle 'kchmck/vim-coffee-script'

syntax enable
filetype plugin indent on
" End vundle configuration

" Highlighting, colors, visual, wrapping, etc
colors dante
syn on
set guifont=Monaco\ 10
set tags=tags;/
set nowrapscan
set number
set lbr
set formatoptions=nlro
set backspace=indent,start
set mouse=a
let mapleader=" "
let g:load_doxygen_syntax=1

" Indenting
set autoindent
set tabstop=4 shiftwidth=4 softtabstop=4 smarttab expandtab

" Visual move configuration
vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> D       DVB_Duplicate()
let g:DVB_TrimWS=1

set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

func ExecuteCurrentFile()
    silent! :bdelete! ~/.vim/output
    w
    silent !%:p >~/.vim/output 2>&1
    botright :vsplit ~/.vim/output
    redraw!
endfunction

" Helper function to execute the current file
com Exec call ExecuteCurrentFile()

" Override s/S to insert/append a single character
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" Set YCM Goto
nnoremap <leader>jl :YcmCompleter GoTo<CR>
inoremap <C-j>l :YcmCompleter GoTo<CR>

" Specific filetype options
autocmd BufNewFile,BufRead *.lisp
    \ set lisp

autocmd BufNewFile,BufRead *.py,SConstruct,SConscript,wscript,wscript_build
    \ set syntax=python filetype=python
    \ list listchars=tab:>-
    \ tabstop=4 shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.hx
    \ set syntax=haxe filetype=haxe cindent

autocmd BufNewFile,BufRead *.php,*.inc
    \ set syntax=php filetype=php

autocmd BufNewFile,BufRead *.txt,bzr_log.*,.git/COMMIT_EDITMSG
    \ set spell

autocmd BufNewFile,BufRead CMakeLists.txt
    \ set nospell

autocmd BufNewFile,BufRead *.m,*.j
    \ set syntax=objc filetype=objc

autocmd BufNewFile,BufRead *.mako
    \ set syntax=mako filetype=mako

autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead,BufNewFile *.vala
    \ set syntax=vala filetype=vala cindent
autocmd BufRead,BufNewFile *.vapi
    \ set syntax=vala filetype=vala cindent

autocmd BufRead,BufNewFile *.json
    \ set syntax=javascript filetype=javascript

autocmd BufRead,BufNewFile Makefile
    \ set noexpandtab

autocmd BufRead,BufNewFile *.md
    \ set syntax=markdown filetype=markdown spell

autocmd BufRead,BufNewFile *.cs
    \ set nobomb

autocmd BufRead,BufNewFile pom.xml
    \ set shiftwidth=4 tabstop=4 softtabstop=4

autocmd FileType java
    \ setlocal omnifunc=javacomplete#Complete

autocmd BufRead,BufNewFile *.rs
    \ set tabstop=4 shiftwidth=4 softtabstop=4
