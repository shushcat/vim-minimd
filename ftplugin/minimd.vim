" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:
setlocal foldmethod=manual
set foldopen-=search

if exists("g:minimd_plugin_loaded")
    finish
endif

nmap <silent> <Space> :call minimd#ManualFold()<CR>

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
setlocal number
setlocal shiftwidth=4

" Headers:
nmap <silent> <Tab> :call minimd#HeaderMotion('F')<CR>
nmap <silent> <S-Tab> :call minimd#HeaderMotion('B')<CR>
nnoremap <silent> = :call minimd#PromoteHeader()<CR>
nnoremap <silent> - :call minimd#DemoteHeader()<CR>

" Motion:
nmap j gj
nmap k gk

" Tasks:
nmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>
vmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>
" Highlight Unfinished Tasks:
nnoremap <silent> <Leader>t %/^\s*- \[ \].*$<CR>

" Word Count:
let b:word_count = minimd#UpdateWordCount()
set statusline=%<%f\ wc:%{minimd#ReturnWordCount()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:minimd_plugin_loaded = 1
