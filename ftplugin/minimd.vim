" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:
if !exists("g:minimd_folding_disabled")
  setlocal foldexpr=minimd#MarkdownLevel()
  setlocal foldmethod=expr
  setlocal foldenable
  setlocal foldlevel=6
  setlocal foldcolumn=0
  set foldopen-=search
endif

if exists("g:minimd_plugin_loaded")
    finish
endif

nmap <silent> <Space> za
vmap <silent> <Space> za
nmap <silent> z<Space> :call minimd#CycleFolding()<CR>
vmap <silent> z<Space> :call minimd#CycleFolding()<CR>

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
nmap <silent> <Tab> :call minimd#HeaderNext()<CR>
function! minimd#HeaderNext ()
    normal! ^
    /^\s*#\+\s
endfunction
nmap <silent> <S-Tab> :call minimd#HeaderPrev()<CR>
function! minimd#HeaderPrev ()
    normal! ^
    ?^\s*#\+\s
endfunction
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
