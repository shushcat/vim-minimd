" Vim plugin file
" Language:     Minimal Markdown
" Author:       J. O. Brickley

" Folding:

function! minimd#FoldAllHeaders(lvl)
  let l:lnum = line(".")
	let l:hmark = repeat("#", a:lvl)
	normal G$
	silent! normal! zE
	let sflag = "w"
	while search("^" . l:hmark . " ", l:sflag) > 0
		let l:poslvl = minimd#HeaderLevel()
		if l:poslvl == a:lvl
			call minimd#FoldHeader()
		endif
		let sflag = "W"
	endwhile
	execute l:lnum
endfunction

function! minimd#FoldHeader()
	silent! normal! zD
	let l:beg = line(".")
	let l:end = line("$")
	let l:beglvl = minimd#HeaderLevel()
	if l:beglvl == 0
		call minimd#HeaderMotion('B')
		let l:beglvl = minimd#HeaderLevel()
		if l:beglvl == 0
			execute l:beg
			return
		else
			let l:beg = line(".")
		endif
	endif
	while 1
		execute search("^#", "W")
		let l:end = line(".")
		let l:endlvl = minimd#HeaderLevel()
		if l:end == 1
			let l:end = line("$")
			break
		elseif l:endlvl <= l:beglvl && minimd#IsHeader(l:end)
			let l:end = line(".")
			break
		endif
	endwhile
	call minimd#FoldRange(l:beg, l:end)
	execute l:beg
endfunction

function! minimd#UnfoldHeader()
	let l:beg = line(".")
	silent! normal! zo]z
	let l:end = line(".")
	silent! normal! [z
	silent! normal! zD
	let l:hlvl = minimd#HeaderLevel() + 1
	let l:hmark = repeat("#", l:hlvl)
	while line(".") < l:end
		if l:hlvl == minimd#HeaderLevel()
			call minimd#FoldHeader()
		endif
		execute search("^" . l:hmark . " ", "W")
		if line(".") == 1
			break
		endif
	endwhile
	execute l:beg
endfunction

function! minimd#ToggleFold(lvl)
	let l:beg = line(".")
	if a:lvl != 0
		call minimd#FoldAllHeaders(a:lvl)
	elseif foldclosed(l:beg) == -1
		call minimd#FoldHeader()
	else
		call minimd#UnfoldHeader()
	endif
endfunction

function! minimd#HeaderLevel()
  let l:ln = line(".")
	let l:txt = getline(l:ln)
	if (minimd#IsHeader(l:ln)) == 0
		return 0
	else
		return matchend(l:txt, '^#*')
	endif
endfunction

function! minimd#FoldRange(l1, l2)
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

function! minimd#FoldText()
  let line = getline(v:foldstart)
  let folded_line_num = v:foldend - v:foldstart
  let line_text = substitute(line, '\(.\{56\}.\{-\}\)\s.*', '\1', 'g')
  let line_text = substitute(line, '\(.\{64\}\).*', '\1', 'g')
  let line_text = substitute(line_text, '\s*$', '', 'g')
  let fillcharcount = 70 - len(line_text) - len(folded_line_num)
  return line_text . repeat('.', fillcharcount) . '(' . folded_line_num . ' Lines)'
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
	let l:lnum = line(".")
	let l:hlvl = minimd#HeaderLevel()
	if l:hlvl == 0
		return
	elseif l:hlvl == 1
		execute "silent! s/^##/###/"
		execute "silent! normal! zo"
		execute l:lnum
		execute "silent! s/^#/##/"
		execute "silent! normal! zc"
	else
		execute "silent! s/^##/###/"
		execute l:lnum
	endif
	execute "normal! zz"
endfunction

" Header Demotion:

function! minimd#DemoteHeader()
	let l:lnum = line(".")
	let l:hlvl = minimd#HeaderLevel()
	if l:hlvl <= 1
		return
	endif
	execute "silent! s/^##/#/"
	execute l:lnum
	execute "normal! zz"
endfunction

" Header Motion:

function! minimd#HeaderMotion(dir)
	silent! normal! m'
  let l:synID1 = synIDtrans(hlID("mdHeader"))
  while 1
    let l:pos1 = getpos(".")
		" If in a fold
		if foldlevel(l:pos1[1]) != 0
			" and that fold is closed,
			if foldclosed(l:pos1[1]) != -1
				" first move to its beginning or end;
				if a:dir ==# 'B'
					execute 'silent! normal! zo[zzc'
				else
					execute 'silent! normal! zo]zzc'
				endif
			" otherwise, remove the fold;
			else
				silent! normal! zd
			endif
		" and if an unfolded header, move to the first column.
		elseif minimd#IsHeader(l:pos1[1]) == 1
			normal! 0
		endif
    if a:dir ==# 'B'
			execute search("^#", "b", 1)
			silent! normal! zo[zzc
    else
			execute search("^#", 'W')
			" Don't attempt to move beyond EOF.
			if (line('.') == 1)
				execute "normal! G"
			endif
    endif
		execute "silent! normal! zz"
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
