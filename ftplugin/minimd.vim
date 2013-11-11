" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       John O Brickley

if exists("g:minimd_plugin_loaded")
    finish
endif
let g:minimd_plugin_loaded = 1

if !exists("g:minimd_folding_disabled")
  setlocal foldexpr=minimd#MarkdownLevel()
  setlocal foldmethod=expr

  setlocal foldenable
  setlocal foldlevel=1
  setlocal foldcolumn=0
  set foldopen-=search
endif

" Softwrap lines.
" Avoid wrapping at one-letter words.
setlocal formatoptions=1
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
setlocal nosmartindent

setlocal comments=""
" Don't auto-insert comment leaders.
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=2
setlocal formatoptions+=n
setlocal nocindent
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

" Promote Header
nmap = 0i#<ESC><C-l>
" Demote Header
nmap - :s/##/#/1<CR><C-l>

nmap <Leader><Space> :call minimd#TaskToggle()<CR>

" Get a word count.
nmap <Leader>wc :! wc -w "%"<CR>

:nmap <Leader>tt :s/^\(\s*\)\-/\1- [ ]/<CR><C-l>
:nmap <Leader>tf :s/^\(\s*\)\- \[ \]/\1- [X]/<CR><C-l>
:nmap <Leader>tu :s/^\(\s*\)\- \[X\]/\1- [ ]/<CR><C-l>

" Compile markdown as HTML.
:nnoremap <silent> <LocalLeader>html :!pandoc --bibliography="$SyncFolder/Bibliography.bib" -f markdown -t html "%" > ./out.html<CR><CR>

" Compile markdown as PDF via LaTeX.
:nnoremap <silent> <LocalLeader>pdf :!pandoc --bibliography="$SyncFolder/Bibliography.bib" --latex-engine=/usr/local/texlive/2013/bin/x86_64-darwin/xelatex -o ./out.pdf "%"<CR><CR>
