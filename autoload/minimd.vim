" Vim plugin file
" Language:     Minimal Markdown
" Author:       John O Brickley

" Folding:
function! minimd#MarkdownLevel()
    let theline = getline(v:lnum)
    let nextline = getline(v:lnum+1)
    if theline =~ '^# '
        return ">1"
<<<<<<< HEAD
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
=======
      elseif getline(v:lnum) =~ '^## .*$'
        return ">2"
      elseif getline(v:lnum) =~ '^### .*$'
        return ">3"
      elseif getline(v:lnum) =~ '^#### .*$'
        return ">4"
      elseif getline(v:lnum) =~ '^##### .*$'
        return ">5"
      elseif getline(v:lnum) =~ '^###### .*$'
        return ">6"
      else
        return "="
    endif
endfunction
function! minimd#CycleFolding()
    if &foldlevel
      setlocal foldlevel=0
    else
      setlocal foldlevel=6
>>>>>>> 5f9dcb01c8a54a40ffe2362e3ca253dc94715d4d
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
    if b:line =~ '^##\+ .*$'
        let b:newline = substitute(b:line, '##', '#', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^# .*$'
        let b:newline = substitute(b:line, '^# ', '', "")
        call setline(b:linenum, b:newline)
    endif
endfunction

" Word Count:
function! minimd#WordCount()
   let s:old_status = v:statusmsg
   let position = getpos(".")
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   if stat != '--No lines in buffer--'
     let s:word_count = str2nr(split(v:statusmsg)[11])
     let v:statusmsg = s:old_status
   end
   call setpos('.', position)
   return s:word_count
endfunction

