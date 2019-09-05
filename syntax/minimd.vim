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
syn region String start=/`/ end=/`/
" Code Blocks:
syn region String start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/

syn region String start=/\s*``[^`]*/ skip=/`/ end=/[^`]*``\s*/
"" Block Quotes:
syn match Comment /^>.*\n\(.*\n\@<!\n\)*/ skipnl
" Ignored Section:
syn region Function start=/<!--/ end=/-->/
" Trailing Spaces:
syn match Comment /\s\s$/

<<<<<<< HEAD
" Headings:
syn region Header start="^##*" end="$"
=======
" Headers:
syn region Header start="^##*" end="\($\|#\+\)"
hi Header cterm=bold term=bold gui=bold
>>>>>>> 5f9dcb01c8a54a40ffe2362e3ca253dc94715d4d

" Inline Footnotes:
syn region Comment start=/\^\[/ skip=/\[[^]]*\]/ end=/\]/

" Pandoc Citations:
syn region Comment start="[ ,.?!(\[\n]@" end="[ ,.?!)\]\n]"
syn region Comment start="[ ,.?!(\[\n][-]@" end="[ ,.?!)\]\n]"

" Pandoc Headers:
syn match Identifier /\%^\(%.*\n\)\{1,3}$/ skipnl

" Links:
" TODO Make the match non-greedy.
syn region Comment start="\[" skip="\](" end=")"

" Math:
syn match Operator     "\ $\S*\$"
syn region Operator start=/\$\$/ end=/\$\$/ " display math

let b:current_syntax = "minimd"
