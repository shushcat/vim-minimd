" Vim plugin file
" Language:     Minimal Markdown
" Author:       John O Brickley
" Derived from Plasticboy's Markdown folding
" which was derived from Steve Losh's.

func! Foldexpr_text(lnum)

    let l1 = getline(a:lnum)

    let l2 = getline(a:lnum+1)

    " Fold and nest level 1, 2, and 3 headers.
    if  l2 =~ '^====\+\s*'
        return '>1'
    elseif l2 =~ '^----\+\s*'
        return '>2'
    elseif l1 =~ '^# '
        return '>1'
    elseif l1 =~ '^## '
        return '>2'
    elseif l1 =~ '^### '
        return '>3'
    else
        return '='
    endif
endfunc

if !exists("g:vim_text_folding_disabled")
  setlocal foldexpr=Foldexpr_text(v:lnum)
  setlocal foldmethod=expr

  setlocal foldenable
  setlocal foldlevel=1
  setlocal foldcolumn=0
  set foldopen-=search
endif
