" Vim plugin file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:
function! minimd#ManualFold()
  let l:pos1 = getpos(".")
  if foldlevel(l:pos1[1]) != 0
    execute 'silent! normal! zd'
  else
    let l:synID1 = synIDtrans(hlID("mdHeader"))
    let l:synID2 = synIDtrans(synID(line("."), 1, 1))
    if l:synID1 != l:synID2
      call minimd#HeaderMotion('B')
      let l:pos1 = getpos(".")
    endif
    call minimd#HeaderMotion('F')
    let l:pos2 = getpos(".")
    if l:pos2[1] == line('$')
      execute l:pos1[1] ',' l:pos2[1] 'fold'
    else
      execute l:pos1[1] ',' l:pos2[1]-1 'fold'
    endif
    call setpos('.', l:pos1)
  endif
endfunction

" Task Toggling:
function! minimd#TaskToggle()
    let b:line = getline(".")
    let b:linenum = line(".")
    if b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) \[ \] .*$'
        let b:newline = substitute(b:line, '\[ \] ', '\[X\] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) \[X\] .*$'
        let b:newline = substitute(b:line, '\[X\] ', '\[ \] ', "")
        call setline(b:linenum, b:newline)
    elseif b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) .*$'
        let b:newline = substitute(b:line, '\(^\s*\)\(-\|*\|+\|\d\+\.\)\s', '\1\2 \[ \] ', "")
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

" Header Motion:
function! minimd#HeaderMotion(dir)
  let l:synID1 = synIDtrans(hlID("mdHeader"))
  while 1
    let l:pos1 = getpos(".")
    if a:dir ==# 'B'
      execute "normal! k"
    else
      execute "normal! j"
    endif
    let l:pos2 = getpos(".")
    let l:synID2 = synIDtrans(synID(line("."), 1, 1))
    if  l:synID1 == l:synID2 || l:pos1 == l:pos2
      call setpos('.', l:pos2)
      break
    endif
  endwhile
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
