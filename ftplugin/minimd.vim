" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("b:minimd_plugin_loaded")
  finish
endif
let b:minimd_plugin_loaded = 1

" Folding:
setlocal foldmethod=manual
setlocal foldopen-=search
setlocal foldtext=minimd#FoldText()
setlocal fillchars=fold:\ 
nmap <silent><buffer> <Space> :<C-u>call minimd#ToggleFold(v:count)<CR>

" Formatting:
setlocal formatoptions+=1tcqljn 
setlocal formatoptions-=ro
setlocal formatlistpat="^\s*\(-\|*\|+\|\d\+\.\)\s"
setlocal wrap
setlocal wrapmargin=0
setlocal textwidth=0
setlocal nolist
setlocal linebreak
setlocal breakat&vim
setlocal display=lastline
setlocal autoindent
setlocal nosmartindent
setlocal comments=fb:*,fb:+,fb:-,n:>
setlocal commentstring=<!--%s-->
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=2
setlocal formatoptions+=n
setlocal nocindent
setlocal number
setlocal shiftwidth=4

" Headers:
command! MiniMDNext call minimd#HeaderMotion('F')
command! MiniMDPrev call minimd#HeaderMotion('B')
nmap <silent><buffer> <Tab> :MiniMDNext<CR>
nmap <silent><buffer> <S-Tab> :MiniMDPrev<CR>
nmap <silent><buffer> ]h :MiniMDNext<CR>
nmap <silent><buffer> [h :MiniMDPrev<CR>
command! MiniMDPromote call minimd#PromoteHeader()
command! MiniMDDemote call minimd#DemoteHeader()
nnoremap <silent><buffer> = :MiniMDPromote<CR>
nnoremap <silent><buffer> - :MiniMDDemote<CR>

" Motion:
nmap j gj
nmap k gk

" Tasks:
command! MiniMDToggle call minimd#TaskToggle()
nmap <silent><buffer> <CR> :MiniMDToggle<CR>
vmap <silent><buffer> <CR> :MiniMDToggle<CR>

" Word Count:
let b:word_count = minimd#UpdateWordCount()
setlocal statusline=%<%f\ wc:%{minimd#ReturnWordCount()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P
