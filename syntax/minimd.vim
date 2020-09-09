" Vim syntax file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("b:current_syntax")
    finish
endif

syntax spell toplevel
syntax case ignore
syntax sync minlines=100

" Lists:
syntax match  listItem "^\s*\(-\|*\|+\|\d\+\.\)\s.*$"
highlight default link listItem Normal
syntax match  listMarker "^\s*\(-\|*\|+\|\d\+\.\)\s" contained containedin=listItem
syntax match  listMarker "^\s*\(-\|*\|+\|\d\+\.\)\s\(\[ \]\|\[x\]\)" contained containedin=listItem
highlight default link listMarker LineNr
syntax match  taskBox "\[ \]" contained containedin=listMarker
highlight default link taskBox Todo
syntax match  doneBox "\[x\]" contained containedin=listMarker
highlight default link doneBox Comment

" Code:
syntax region inlineCode start=/`/ end=/\(`\|\n\)/  containedin=listItem
highlight default link inlineCode String
syntax region blockCode start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/
syntax region blockCode start=/^\s*```.*$/ end=/^\s*```$/
syntax region blockCode start=/^\s*\~\~\~.*$/ end=/^\s*\~\~\~$/
highlight default link blockCode String

" Block Quotes:
syntax match blockQuote /^>.*\n\(.*\n\@<!\n\)*/ skipnl
highlight default link blockQuote Comment

" Ignored Section:
syntax region mdComment start=/<!--/ end=/-->/
highlight default link mdComment Comment

" Headers:
syntax match mdHeader /^##*.*$/
highlight default link mdHeader Title

" Title Metadata Blocks:
syntax region titleBlock start=/\%1l^---$/ end=/^\(---\|...\)$/
syntax region titleBlock start=/\%1l%/ end=/\(^$\|^\(%\|\s\)\@!\)/
highlight default link titleBlock Header

" Brackets:
syntax match squareBrackets "\[" containedin=listItem
syntax match squareBrackets "\]" containedin=listItem
highlight default link squareBrackets PreProc

let b:current_syntax = "minimd"
