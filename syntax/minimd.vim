" Vim syntax file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("g:default_markdown_syntax")
	set syntax=markdown
	finish
elseif exists("b:current_syntax")
    finish
endif

syntax spell toplevel
syntax case match
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
syntax region blockCode start=/^\s*$\n^\s*```.*$/ end=/^\s*```$\n\s*$/
syntax region blockCode start=/^\s*$\n^\s*\~\~\~.*$/ end=/^\s*\~\~\~$\n\s*$/
highlight default link blockCode String

" Block Quotes:
syntax region blockQuote start=/^\s\{0,3\}>\s\?.*\n/ end=/^$/
highlight default link blockQuote Comment

" Ignored Section:
syntax region mdComment start=/<!--/ end=/-->/
highlight default link mdComment Comment

" Headers:
syntax match mdHeader /^ \{0,3\}##*.*$/
highlight default link mdHeader Title

" Title Metadata Blocks:
syntax region titleBlock start=/\%1l^---$/ end=/^\(---\|...\)$/
syntax region titleBlock start=/\%1l%/ end=/\(^$\|^\(%\|\s\)\@!\)/
highlight default link titleBlock Header

" Brackets:
syntax match squareBrackets "\[" containedin=listItem
syntax match squareBrackets "\]" containedin=listItem
highlight default link squareBrackets PreProc

" Keywords:
syntax case ignore
syntax match qqMarker "qq" containedin=listItem
highlight default link qqMarker PreProc
syntax case match
syntax match  actvKeyword "ACTV" containedin=listItem,mdHeader
highlight default link actvKeyword Comment
syntax match  cnclKeyword "CNCL" containedin=listItem,mdHeader
highlight default link cnclKeyword LineNr
syntax match  doneKeyword "DONE" containedin=listItem,mdHeader
highlight default link doneKeyword LineNr
syntax match  todoKeyword "TODO" containedin=listItem,mdHeader
highlight default link todoKeyword Todo
syntax match  waitKeyword "WAIT" containedin=listItem,mdHeader
highlight default link waitKeyword Comment

let b:current_syntax = "minimd"
