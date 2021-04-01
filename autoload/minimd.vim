" Vim plugin file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:

function! minimd#ManualFold()
  let l:pos1 = getpos(".")
  " If folded, just unfold.
  if foldclosed(l:pos1[1]) > 0
    execute 'silent! normal! zd'
  else
		if foldlevel(l:pos1[1]) != 0
			execute 'silent! normal! zd'
		endif
    if !(minimd#IsHeader(line(".")))
      let l:rescuepos = winsaveview()
      call minimd#HeaderMotion('B')
      " Don't attempt folding before the first headline.
      if !(minimd#IsHeader(line(".")))
        call winrestview(l:rescuepos)
        return
      endif
      let l:pos1 = getpos(".")
    endif
    let l:pos1lvl = minimd#HeaderLevel()
    execute 'silent! normal! zd'
    call minimd#HeaderMotion('F')
    let l:pos2 = getpos(".")
    let l:pos2lvl = minimd#HeaderLevel()
    while l:pos1lvl < l:pos2lvl
      execute 'silent! normal! zd'
      call minimd#HeaderMotion('F')
      let l:pos3 = getpos(".")
      if l:pos2[1] == l:pos3[1]
        let l:pos2[1] = l:pos2[1] + 1
        break
      endif
      call minimd#MakeFold(l:pos2[1], l:pos3[1])
      let l:pos2 = getpos(".")
      let l:pos2lvl = minimd#HeaderLevel()
    endwhile
    call minimd#MakeFold(l:pos1[1], l:pos2[1])
    call setpos('.', l:pos1)
  endif
endfunction

function! minimd#HeaderLevel()
  let l:currLine = getline(".")
  return matchend(l:currLine, '^#*')
endfunction

function! minimd#MakeFold(l1, l2)
  if (a:l2 == line('$')) && !(minimd#IsHeader(a:l2))
    execute a:l1 ',' a:l2 'fold'
  elseif ((a:l1 >= a:l2) || (a:l1 == (a:l2 - 1)))
    return
  else
    execute a:l1 ',' a:l2 - 1 'fold'
  endif
endfunction

function! minimd#IsHeader(ln)
  let l:currID = synIDtrans(synID(a:ln, 1, 1))
  let l:headID = synIDtrans(hlID("mdHeader"))
  if l:currID == l:headID
    return 1
  else
    return 0
  endif
endfunction

" Task Toggling:

function! minimd#TaskToggle()
  let b:line = getline(".")
  let b:linenum = line(".")
  if b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) \[ \] .*$'
    let b:newline = substitute(b:line, '\[ \] ', '\[x\] ', "")
    call setline(b:linenum, b:newline)
  elseif b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) \[x\] .*$'
    let b:newline = substitute(b:line, '\[x\] ', '\[ \] ', "")
    call setline(b:linenum, b:newline)
  elseif b:line =~ '^\s*\(-\|*\|+\|\d\+\.\) .*$'
    let b:newline = substitute(b:line, '\(^\s*\)\(-\|*\|+\|\d\+\.\)\s', '\1\2 \[ \] ', "")
    call setline(b:linenum, b:newline)
    execute "normal! 4l"
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
			execute search("^#", "b", 1)
    else
			execute search("^#", 'W')
			" Don't attempt to move beyond EOF.
			if (line('.') == 1)
				execute "normal! G"
			endif
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
  let b:word_count = wordcount()["words"]
endfunction
autocmd InsertLeave * call minimd#UpdateWordCount()
autocmd TextChanged * call minimd#UpdateWordCount()
autocmd BufEnter * call minimd#UpdateWordCount()
