" Vim plugin file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:
function! minimd#MarkdownLevel()
    let theline = getline(v:lnum)
    if theline =~ '^# '
        return ">1"
    elseif theline =~ '^## '
        return ">2"
    elseif theline =~ '^### '
        return ">3"
    else
        return "="
    endif
endfunction
function! minimd#CycleFolding()
    if &foldlevel
      setlocal foldlevel=0
    else
      setlocal foldlevel=3
    endif
endfunction

" Task Toggling:
function! minimd#TaskToggle()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^\s*\(-\|\d\+\.\) \[ \] .*$'
        let b:newline = substitute(b:line, '\[ \] ', '\[X\] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*\(-\|\d\+\.\) \[X\] .*$'
        let b:newline = substitute(b:line, '\[X\] ', '\[ \] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*\(-\|\d\+\.\) .*$'
        let b:newline = substitute(b:line, '\(-\|\d\+\.\) ', '\1 \[ \] ', "")
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
function! minimd#ReturnWordCount()
  return b:word_count
endfunction
function! minimd#UpdateWordCount()
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
   let b:word_count = s:word_count
endfunction
autocmd InsertLeave * call minimd#UpdateWordCount()
autocmd TextChanged * call minimd#UpdateWordCount()
autocmd BufEnter * call minimd#UpdateWordCount()
