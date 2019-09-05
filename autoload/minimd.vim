" Vim plugin file
" Language:     Minimal Markdown
" Author:       John O Brickley

" Folding:
function! minimd#MarkdownLevel()
    let theline = getline(v:lnum)
    let nextline = getline(v:lnum+1)
    if theline =~ '^# '
        return ">1"
    elseif theline =~ '^## '
        return ">2"
    elseif theline =~ '^### '
        return ">3"
    elseif theline =~ '^#### '
        return ">4"
    elseif theline =~ '^##### '
        return ">5"
    elseif theline =~ '^###### '
        return ">6"
    else
        return "="
    endif
endfunction

" Task Toggling:
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

" Header Promotion:
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

" Header Demotion:
function! minimd#DemoteHeader()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^##* .*$'
        let b:newline = substitute(b:line, '##', '#', "")
        call setline(b:linenum, b:newline)
    endif
endfunction
