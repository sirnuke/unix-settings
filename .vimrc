colors dante
syn on
set guifont=Monaco\ 10
set autoindent
set tags=tags;/
set nowrapscan
set number
set formatoptions=l
set lbr
set tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab
filetype indent on

func ExecuteCurrentFile()
    silent! :bdelete! ~/.vim/output
    w
    silent !%:p >~/.vim/output 2>&1
    botright :vsplit ~/.vim/output
    redraw!
endfunction

com Exec call ExecuteCurrentFile()

nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

autocmd BufNewFile,BufRead *.lisp
    \ set lisp

autocmd BufNewFile,BufRead *.py,SConstruct,SConscript,wscript,wscript_build
    \ set syntax=python filetype=python
    \ list listchars=tab:>-

autocmd BufNewFile,BufRead *.hx
    \ set syntax=haxe filetype=haxe cindent

autocmd BufNewFile,BufRead *.php,*.inc
    \ set syntax=php filetype=php

autocmd BufNewFile,BufRead *.txt,bzr_log.*
    \ set spell

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

