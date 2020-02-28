" Vim syntax file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("b:current_syntax")
    finish
endif

syntax spell toplevel
syntax case ignore
syntax sync linebreaks=1

" Lists:
syntax match  listItem "^\s*\(-\|\d\+\.\)\s.*$" contains=listMarker
highlight default link listItem Normal
syntax match  listMarker "^\s*\(-\|\d\+\.\)\s" contained containedin=listItem
highlight default link listMarker LineNr
syntax match  taskBox "\[ \]" contained containedin=listItem
highlight default link taskBox Todo
syntax match  doneBox "\[X\]" contained containedin=listItem
highlight default link doneBox Comment

" Code:
syntax region inlineCode start=/`/ end=/\(`\|\n\)/  containedin=listItem
highlight default link inlineCode String
syntax region blockCode start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/
syntax region blockCode start=/^```.*$/ end=/^```$/
syntax region blockCode start=/^\~\~\~.*$/ end=/^\~\~\~$/
highlight default link blockCode String

" Block Quotes:
syntax match blockQuote /^>.*\n\(.*\n\@<!\n\)*/ skipnl
highlight default link blockQuote Comment
" Ignored Section:
syntax region Function start=/<!--/ end=/-->/
" Trailing Spaces:
syntax match Comment /\s\s$/

" Headers:
syntax region mdHeader start="^##*" end="\($\|#\+\)"
highlight default link mdHeader Title

" Reference Material:
syntax region PreProc start=/\^\[/ skip=/\[[^]]*\]/ end=/\]/

" Pandoc Citations:
syntax region citation start="[ ,.?!(\[\n]@" end="[ ,.?!)\]\n]"
syntax region citation start="[ ,.?!(\[\n][-]@" end="[ ,.?!)\]\n]"
highlight default link citation PreProc

" Title Metadata Blocks:
syntax region titleBlock start=/\%1l^---$/ end=/^\(---\|...\)$/
syntax region titleBlock start=/\%1l%/ end=/\(^$\|^\(%\|\s\)\@!\)/
highlight default link titleBlock Header

" Links:
syntax region PreProc start="!\[" skip="\](" end=")\+"
syntax region PreProc start="\[" skip="\](" end=")\+"

" Math:
syntax match Operator     "\ $\S*\$"
syntax region Operator start=/\$\$/ end=/\$\$/ " display math

let b:current_syntax = "minimd"
