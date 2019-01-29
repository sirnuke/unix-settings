" Vim syntax file for the Soar production language
"
" Language:    Soar
" Maintainer:  Alex Crowell (alex.crowell@soartech.com)
" Last Change: May  4, 2018

setlocal iskeyword+=-
setlocal iskeyword+=94

syn keyword soarCommentTodo TODO FIXME XXX TBD NOTE contained

syn cluster soarRelationalTest contains=soarRelation,@soarSingleTest

syn cluster soarSingleTest contains=soarVariable,@soarConstant

syn match soarVariable "\(\|\^\|.\|\s\|(\)<[a-zA-Z0-9$%&*+\-/:<=?_]\+>" contained

syn cluster soarConstant contains=soarSimpleConstant,soarComplexConstant
syn match soarSimpleConstant "\s[a-zA-Z0-9$%&*+\-/:=?_]\+" contained
"syn match soarSimpleConstant "\s[a-zA-Z0-9$%&*+/:=>?_][a-zA-Z0-9$%&*+\-/:<=>?_]\*" contained
syn region soarComplexConstant start=/|/ skip=/\\|/ end=/|/ contained

syn keyword soarCommand pushd popd source multi-attributes learn watch indifferent-selection state write

syn region soarProduction matchgroup=soarProdBraces start=/^\s*[gs]p\s*{/ end=/}/ contains=soarProductionName,soarDocumentation,soarFlags,@soarConditionSide,soarArrow,@soarActionSide fold

syn match  soarProdStart /^\s*[gs]p\s*{/ nextgroup=soarProductionName contained skipwhite

syn match soarProductionName /[-_\*a-zA-Z0-9]\+\s*$/ nextgroup=soarDocumentation,soarFlags,@soarConditionSide contained skipwhite skipnl

syn region soarDocumentation start=/"/ end=/"/ contains=@Spell,soarCommentTodo nextgroup=soarFlags,@soarConditionSide contained skipwhite skipnl

syn match  soarFlags /:\(o-support\|i-support\|chunk\|default\|template\|interrupt\)/ nextgroup=@soarConditionSide contained skipwhite skipnl

" Soar Condition Side:
syn cluster soarConditionSide contains=@soarCond

syn cluster soarCond contains=soarPosNegCond,soarGroupCond

syn region soarPosNegCond matchgroup=soarCondParen start=/-\?(/ end=/)/ nextgroup=@soarCond,soarArrow contains=soarVariable,@soarRelationalTest,soarCondAttrStart,soarCondAttrDot,soarCondAttrConstant,soarConjunctiveTest,soarDisjunctionTest,soarOperator,soarCondQualifier,@soarCondBadVariable contained skipwhite skipnl

syn region soarGroupCond matchgroup=soarGroupCond start=/-\?{/ end=/}/ nextgroup=@soarCond,soarArrow contains=@soarCond contained skipwhite skipnl

syn keyword soarCondQualifier state impasse

syn match soarCondAttrStart /-\?\^[a-zA-Z0-9$%&*+\-/:<=?_{]/me=e-1 nextgroup=soarCondAttrConstant contained
syn match soarCondAttrDot "\.[a-zA-Z0-9$%&*+\-/:\<=>?_{]"me=e-1 nextgroup=soarCondAttrConstant contained
syn match soarCondAttrConstant "[a-zA-Z0-9$%&*+\-/:=>?_]\+" contained

syn cluster soarCondBadVariable contains=soarCondBadVariableEOL,soarCondBadVariableEOC
syn match soarCondBadVariableEOL "<[a-zA-Z0-9$%&*+\-/:=?_]\+$" contained
syn match soarCondBadVariableEOC "<[a-zA-Z0-9$%&*+\-/:=?_]\+)"me=e-1 contained

syn match  soarComment /#.*/ contains=@Spell,soarCommentTodo containedin=ALL

syn region soarConjunctiveTest start=/{/ end=/}/ contains=soarDisjunctionTest,@soarRelationalTest

syn region soarDisjunctionTest start=/<</ end=/>>/ contains=@soarConstant

syn match soarArrow /-->/ nextgroup=soarRhsAction,soarFuncCall skipwhite skipnl contained

" Soar Action Side:
syn cluster soarActionSide contains=soarRhsAction,soarFuncCall
",soarFuncCall

syn region soarRhsAction matchgroup=soarActionParen start=/(\s*</rs=s+1 end=/)/ nextgroup=@soarActionSide contains=soarFuncCall,soarVariable,soarActAttrStart,soarActAttrDot,soarActAttrConstant,@soarConstant,soarVariable contained skipwhite skipnl

syn region soarFuncCall matchgroup=soarFuncParen start=/(\s*[a-zA-Z0-9@*+\-/]/rs=s+1 end=/)/ nextgroup=soarRhsAction,soarFuncCall contains=soarFuncName,@soarRhsValue,soarFuncCall contained skipwhite skipnl


syn cluster soarRhsValue contains=soarComplexConstant,soarSimpleConstant,soarVariable

syn match soarActAttrStart /\^[a-zA-Z0-9$%&*+\-/:<=?_]/me=e-1 nextgroup=soarActAttrConstant contained
syn match soarActAttrDot "\.[a-zA-Z0-9$%&*+\-/:\<=>?_]"me=e-1 nextgroup=soarActAttrConstant contained
syn match soarActAttrConstant "[a-zA-Z0-9$%&*+\-/:=>?_]\+" contained

"syn region soarAttrValueMake start=/\^/ end=/\s+/ nextgroup=soarVariable contains=soarVariable,soarAttrValueMake contained skipwhite skipnl

syn keyword soarOperator ^operator

syn keyword soarFuncName halt interrupt wait write crlf log
syn keyword soarFuncName + - * / div mod abs atan2 sqrt sin cos min max int float ifeq 
syn keyword soarFuncName capitalize-symbol compute-heading compute-range concat deep-copy
syn keyword soarFuncName dc @ link-stm-to-ltm make-constant-symbol
syn keyword soarFuncName rand-float rand-int round-off round-off-heading size strlen
syn keyword soarFuncName timestamp trim

syn keyword soarFuncName exec cmd dont-learn force-learn

syn keyword soarRelation <> < > <= >= = <=>

syn keyword soarPreference + - ! ~ < = >

syntax sync fromstart

hi def link soarCommentTodo Todo

"
"syn region soarMathExp start=/(/ end=/)/ contains=soarMathExp contained containedin=soarCond1,soarActionI
"syn region soarConjTest start=/{/ end=/}/ containedin=soarCond1,soarActionI

"hi soarProdStart  guifg=Red    ctermfg=Red     term=bold    gui=bold

"hi soarCommand        guifg=Red          ctermfg=Red
hi soarComment         guifg=Blue         ctermfg=Blue
"hi soarSimpleConstant  guifg=green        ctermfg=blue
hi soarComplexConstant guifg=darkred      ctermfg=darkred
hi soarProdStart      guifg=White        ctermfg=White
hi soarProdBraces     guifg=Blue         ctermfg=Blue
hi soarProductionName       guifg=Purple       ctermfg=Magenta
hi soarArrow          guifg=Purple       ctermfg=Magenta
hi soarCondParen      guifg=Blue         ctermfg=Blue
hi soarGroupCond      guifg=Orange         ctermfg=Green
hi soarActionParen    guifg=Yellow       ctermfg=Yellow
hi soarFuncParen    guifg=Cyan       ctermfg=Cyan
hi soarFuncName    guifg=Cyan   ctermfg=Cyan

hi soarOperator        guifg=DarkBlue     ctermfg=DarkBlue    

hi soarCondQualifier  guifg=DarkBlue     ctermfg=DarkBlue
hi soarCondAttrStart ctermfg=DarkGreen
hi soarCondAttrDot ctermfg=DarkGreen
hi soarCondAttrConstant ctermfg=DarkGreen

"hi soarCondBadVariableEOC ctermfg=White ctermbg=DarkRed
"hi soarCondBadVariableEOL ctermfg=White ctermbg=DarkRed

hi soarActAttrConstant ctermfg=DarkGreen
hi soarActAttrStart ctermfg=DarkGreen
hi soarActAttrDot ctermfg=DarkGreen

hi soarRhsValue     ctermfg=DarkGreen
hi soarDisjunctionTest ctermfg=DarkMagenta
hi soarConjunctiveTest ctermfg=DarkYellow
hi soarAttrValueJoiner      ctermfg=Red
"hi soarDotConst ctermfg=green
"hi soarDotDot ctermfg=green

" only for debugging
"hi soarCond ctermbg=Gray
"hi soarAction ctermbg=Blue
"hi soarMathExp ctermbg=Red

hi link soarCommand     Keyword
hi link soarProductionName    Function
hi link soarFlags    Keyword
hi link soarDocumentation         String
hi link soarVariable         Identifier
hi link soarDotConst       Type
hi link soarDotDot         Type
hi link soarComment     Comment
hi link soarConstant    String

