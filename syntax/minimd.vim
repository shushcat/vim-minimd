" Vim syntax file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("b:current_syntax")
    finish
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

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
syntax match inlineCode "`.*`"  containedin=listItem
highlight default link inlineCode String
syntax region blockCode start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/
syntax region blockCode start=/^```.*$/ end=/^```$/
highlight default link blockCode String

" Block Quotes:
syntax match blockQuote /^>.*\n\(.*\n\@<!\n\)*/ skipnl
highlight default link blockQuote Comment
" Ignored Section:
syn region Function start=/<!--/ end=/-->/
" Trailing Spaces:
syn match Comment /\s\s$/

" Headers:
syn region Header start="^##*" end="\($\|#\+\)"
hi Header cterm=bold term=bold gui=bold

" Inline Footnotes:
syn region PreProc start=/\^\[/ skip=/\[[^]]*\]/ end=/\]/

" Pandoc Citations:
syn region PreProc start="[ ,.?!(\[\n]@" end="[ ,.?!)\]\n]"
syn region PreProc start="[ ,.?!(\[\n][-]@" end="[ ,.?!)\]\n]"

" Pandoc Headers:
syn region Title start=/^---$/ end=/^---$/

" Links:
syn region PreProc start="!\[" skip="\](" end=")\+"
syn region PreProc start="\[" skip="\](" end=")\+"

" Math:
syn match Operator     "\ $\S*\$"
syn region Operator start=/\$\$/ end=/\$\$/ " display math

let b:current_syntax = "minimd"
