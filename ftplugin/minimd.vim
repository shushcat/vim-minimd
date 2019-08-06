" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       John O. Brickley

if exists("g:minimd_plugin_loaded")
    finish
endif

" Folding:
if !exists("g:minimd_folding_disabled")
  setlocal foldexpr=minimd#MarkdownLevel()
  setlocal foldmethod=expr
  setlocal foldenable
  setlocal foldlevel=0
  setlocal foldcolumn=0
  set foldopen-=search
endif
nmap <silent> <Space> za
vmap <silent> <Space> za

" Formatting:
setlocal formatoptions=1
" TODO Recognize dash and plus lists as well.
"setlocal formatlistpat="^\s*\d\+[\]:.)}\t ]\s*"
setlocal wrap
setlocal wrapmargin=0
setlocal textwidth=0
setlocal nolist
setlocal linebreak
set breakat=\ ^I
setlocal display=lastline
setlocal autoindent
setlocal nosmartindent
setlocal comments=""
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=2
setlocal formatoptions+=n
setlocal nocindent
setlocal shiftwidth=4

" Headers:
nnoremap <silent> <TAB> :call minimd#HeaderNext()<CR>
function! minimd#HeaderNext ()
    normal! ^
    /^\s*#
endfunction
nnoremap <silent> <S-TAB> :call minimd#HeaderPrev()<CR>
function! minimd#HeaderPrev ()
    normal! ^
    ?^\s*#
endfunction
nnoremap <silent> = :call minimd#PromoteHeader()<CR>
nnoremap <silent> - :call minimd#DemoteHeader()<CR>

" Motion:
nmap j gj
nmap k gk

" Pandoc Export:
if !exists("g:pandoc_options")
    let g:pandoc_options = ""
endif
if !exists("g:pandoc_options_html")
    let g:pandoc_options_html = ""
endif
if !exists("g:pandoc_options_latex")
    let g:pandoc_options_latex = ""
endif
:nmap <LocalLeader>ch :<C-\>e'execute '.string(getcmdline()).'."!pandoc " g:pandoc_options g:pandoc_options_html "-f markdown -t html" "\"%\"" "> ./out.html"'<CR><CR>
:nmap <silent> <LocalLeader>cp :<C-\>e'execute '.string(getcmdline()).'."!pandoc " g:pandoc_options g:pandoc_options_latex "-o ./out.pdf " "\"%\""'<CR><CR>

" Tasks:
nmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>
vmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>
" Highlight Unfinished Tasks:
nnoremap <silent> <Leader>t %/^\s*- \[ \].*$<CR>

" Word Count: (TODO integrate live wordcount function for status line)
nmap <Leader>wc :call minimd#WordCount()<CR>
function! minimd#WordCount ()
    exec '!wc -w "%"'
endfunction

let g:minimd_plugin_loaded = 1
