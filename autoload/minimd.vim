" Vim plugin file
" Language:     Minimal Markdown
" Author:       John O Brickley

" Folding:"{{{
" Derived from vim-pandoc's folding.
function! minimd#MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
	if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^=\+$'
		return ">1"
	endif
	if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^-\+$'
		return ">2"
	endif
    return "="
endfunction
"}}}

" Link Following:"{{{
"function! minimd#LinkFollow()
"    let b:line = getline(".")
"    if b:line =~ '^.*\[\[.*\]\].*$'
"        exec gf
"    endif
"endfunction
" }}}

" Task Toggling:"{{{
function! minimd#TaskToggle()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^\s*- \[ \] .*$'
        let b:newline = substitute(b:line, '- \[ \] ', '- \[X\] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*- \[X\] .*$'
        let b:newline = substitute(b:line, '- \[X\] ', '- \[ \] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*- .*$'
        let b:newline = substitute(b:line, '- ', '- \[ \] ', "")
        call setline(b:linenum, b:newline)
    endif
endfunction
"}}}

" Header Promotion:"{{{
function! minimd#PromoteHeader()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^#* .*$'
        let b:newline = substitute(b:line, '#', '##', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^.*$'
        let b:newline = substitute(b:line, '^', '# ', "")
        call setline(b:linenum, b:newline)
    endif
endfunction
"}}}

" Header Demotion:"{{{
function! minimd#DemoteHeader()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^##* .*$'
        let b:newline = substitute(b:line, '##', '#', "")
        call setline(b:linenum, b:newline)
    endif
endfunction
"}}}
