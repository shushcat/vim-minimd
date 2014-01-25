" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       John O Brickley

if exists("g:minimd_plugin_loaded")
    finish
endif

" Fold Settings:"{{{
if !exists("g:minimd_folding_disabled")
  setlocal foldexpr=minimd#MarkdownLevel()
  setlocal foldmethod=expr
  setlocal foldenable
  setlocal foldlevel=1
  setlocal foldcolumn=0
  set foldopen-=search
endif"}}}

" Line Visability And Wrapping:"{{{
" Avoid wrapping at one-letter words.
setlocal formatoptions=1
" TODO Recognize dash and plus lists as well.
"setlocal formatlistpat="^\s*\d\+[\]:.)}\t ]\s*"
setlocal wrap
setlocal wrapmargin=0
setlocal textwidth=0
" `list` disables `linebreak`.
setlocal nolist
setlocal linebreak
" Wrap only at spaces and tabs.
set breakat=\ ^I
setlocal display=lastline"}}}

" Auto Formatting Behavior:"{{{
setlocal autoindent
setlocal nosmartindent
setlocal comments=""
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=2
setlocal formatoptions+=n
setlocal nocindent
setlocal shiftwidth=4"}}}

" KEYBINDINGS:"{{{

" Line Motion:"{{{
map j gj
map k gk
map 0 g0
map ^ g^
map $ g$"}}}

" Header Motion:"{{{
nmap <TAB> /^\s*#<CR><C-l>
nmap <S-TAB> ?^\s*#<CR><C-l>
"}}}

" Header Levels:"{{{
nnoremap <silent> = :call minimd#PromoteHeader()<CR>
nnoremap <silent> - :call minimd#DemoteHeader()<CR>
"}}}

" Task Toggle:"{{{
nnoremap <silent> <Space> :call minimd#TaskToggle()<CR>"}}}

" Task Highlight:{{{
nnoremap <silent> <Leader>t /^\s*- \[ \].*$<CR>"}}}

" Word Count:"{{{
nmap <Leader>wc :call minimd#WordCount()<CR>
function! minimd#WordCount ()
    exec '!wc -w "%"'
endfunction"}}}

" Pandoc:"{{{
if !exists("g:pandoc_options")
    let g:pandoc_options = ""
endif
" Compile markdown as HTML.
:nnoremap <LocalLeader>html :<C-\>e'execute '.string(getcmdline()).'."!pandoc " g:pandoc_options "-f markdown -t html" "\"%\"" "> ./out.html"'<CR><CR>
" Compile markdown as PDF via LaTeX.
:nnoremap <silent> <LocalLeader>pdf :<C-\>e'execute '.string(getcmdline()).'."!pandoc " g:pandoc_options "-o ./out.pdf " "\"%\""'<CR><CR>
"}}}
"}}}

let g:minimd_plugin_loaded = 1
