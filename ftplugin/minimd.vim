" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       John O Brickley

if exists("g:minimd_plugin_loaded")
    finish
endif
let g:minimd_plugin_loaded = 1

" Avoid wrapping at one-letter words.
setlocal formatoptions=1
" Softwrap lines.
setlocal wrap
setlocal wrapmargin=0
setlocal textwidth=0
" `list` disables `linebreak`.
setlocal nolist
setlocal linebreak
" Wrap only at spaces (the escaped space) and tabs.
set breakat=\ ^I
setlocal display=lastline
setlocal autoindent
setlocal shiftwidth=4

" KEYBINDINGS

" Navigate soft-wrapped lines visually.
map j gj
map k gk
map 0 g0
map ^ g^
map $ g$

" Cycle through headers.
nmap <TAB> /^\s*#<CR><C-l>
nmap <S-TAB> ?^\s*#<CR><C-l>

" Get a word count.
nmap <Leader>wc :! wc -w "%"<CR>

:nmap <Leader>tt :s/^\(\s*\)\-/\1- [ ]/<CR><C-l>
:nmap <Leader>tf :s/^\(\s*\)\- \[ \]/\1- [X]/<CR><C-l>
:nmap <Leader>tu :s/^\(\s*\)\- \[X\]/\1- [ ]/<CR><C-l>

" Compile markdown as HTML.
:nnoremap <silent> <LocalLeader>html :!pandoc --bibliography="$SyncFolder/Bibliography.bib" -f markdown -t html "%" > ./"%".html<CR><CR>

" Compile markdown as PDF via LaTeX.
:nnoremap <silent> <LocalLeader>pdf :!pandoc --bibliography="$SyncFolder/Bibliography.bib" --latex-engine=/usr/local/texlive/2013/bin/x86_64-darwin/xelatex -o ./"%".pdf "%"<CR><CR>
