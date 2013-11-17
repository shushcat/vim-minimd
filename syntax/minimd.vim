" Vim syntax file
" Language:     Minimal Markdown
" Author:       John O Brickley

if exists("b:current_syntax")
    finish
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

" Bullet Points:
syn match  Identifier "^\s*[-*+]\s\+"
" Check Boxes:
syn match  Identifier "^\s*- \[ \]\s\+"
syn match  Comment "^\s*- \[X\]\s.*$"
" Numbered Lists:
syn match  Identifier "^\s*\d\+\.\s\+"

" Inline Code:
syn region Operator start=/`/ end=/`/
" Code Blocks:
syn region Operator start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/

"syn region Operator start=/\s*``[^`]*/ skip=/`/ end=/[^`]*``\s*/
" Block Quotes:
syn match Comment /^>.*\n\(.*\n\@<!\n\)*/ skipnl
" Ignored Section:
syn region Function start=/<!--/ end=/-->/
" Trailing Spaces:
syn match Comment /\s\s$/

" Headings:
syn region Header start="^##*" end="\($\|#\+\)"
syn match  Header /^.\+\n=\+$/
syn match  Header /^.\+\n-\+$/

" Inline Footnotes:
syn region Comment start=/\^\[/ skip=/\[[^]]*\]/ end=/\]/

" Pandoc Citations:
syn region Comment start="[ ,.?!(\[\n]@" end="[ ,.?!)\]\n]"
syn region Comment start="[ ,.?!(\[\n][-]@" end="[ ,.?!)\]\n]"

" Pandoc Headers:
syn match Identifier /\%^\(%.*\n\)\{1,3}$/ skipnl

" Links:
" TODO Make the match non-greedy.
"syn region Comment start="\[" skip="\](" end=")"

" Math:
" Inline:
syn match Operator     "\ $.*\$"
" Block:
syn region Operator start=/\$\$/ end=/\$\$/ " display math

" Bold Headers:
hi Header cterm=bold term=bold gui=bold

let b:current_syntax = "minimd"
