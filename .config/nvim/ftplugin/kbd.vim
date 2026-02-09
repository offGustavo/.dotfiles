" Clear any existing syntax
if exists("b:current_syntax")
  finish
endif

" Ensure syntax highlighting is enabled
syntax enable
" Force load Lisp syntax rules
runtime! syntax/lisp.vim

" ============
" Funções Kanata
" ============

" Desabilita sintaxe padrão que captura átomos após (
syntax clear lispAtom
syntax clear lispNumber
syntax clear LispFunc
syntax clear lispAtomMark

" Captura qualquer função no formato (word
" Usa lookbehind para capturar apenas o nome da função após o (
syntax match kanataFunc /\v\(@<=[A-Za-z0-9_-]{3,}/ containedin=lispExpr,lispList

" Aplica highlight
highlight def link kanataFunc LispFunc

" ============
" Aliases Kanata
" ============

" Captura aliases como @nav, @something, @nav; etc.
" Exclui aliases que estão dentro de comentários usando containedin=ALLBUT
syntax match kanataAlias /@[A-Za-z0-9_\-;.,/]\+/ containedin=ALLBUT,lispComment

" Aplica highlight para aliases
highlight def link kanataAlias Define

syntax match kanataComp /\v\C((S-|RA-)+)([A-Za-z0-9_]+|.)/ containedin=ALLBUT,lispComment
highlight def link kanataComp Constant

" ===============
" Kanata Comments
" ===============
" Remove the old comment rule
syntax clear lispComment
" Match only ;; comments
syntax match lispComment ";;.*" contains=@Spell
" Link to Comment highlight
" Ensure lispComment is allowed inside all lisp regions
highlight def link lispComment Comment
" (including function bodies, lists, etc.)
syntax cluster lispTop add=lispComment
syntax cluster lispExpr add=lispComment

" Define fold regions for top-level forms only
" Isso captura cada bloco (defun ...), (setq ...), etc. separadamente
syntax region kanataFold
  \ start="^\s*(\z(defcfg\|defsrc\|defchordsv2\|defalias\|deflayer\|deflayermap\)\>"
  \ end="^\s*)\s*$"
  \ transparent
  \ fold

" Alternativa mais específica para diferentes tipos de blocos
syntax region kanataDef
  \ start="^\s*(\z(defcfg\|defsrc\|defchordsv2\|defalias\|deflayer\|deflayermap\)"
  \ end="^\s*)"
  \ transparent
  \ fold

setl commentstring=;;\ %s
setl foldmethod=indent

" Syntax groups for different elements
syntax region kanataParens matchgroup=Delimiter start="(" end=")" transparent contains=ALLBUT,kanataError
syntax match kanataComment ";.*$"

" Keywords
syntax keyword kanataKeyword deflayer defcfg defsrc defchordsv2 defalias
syntax keyword kanataKeyword layer-toggle layer-switch deflocalkeys-win deflocalkeys-linux
syntax keyword kanataKeyword tap-hold tap-dance nextgroup=kanataParams skipwhite

" Link to standard highlighting groups
highlight link kanataComment Comment
highlight link kanataKeyword LispFunc

setl lisp
setl define=^\\s*(def\\k*


let b:current_syntax = "kanata"
