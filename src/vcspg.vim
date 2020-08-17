" TODO: convert color names to color codes via $VIMRUNTIME/rgb.txt

function! GetColorValue() abort
  let l:synID = synID(line("."), col("."), 1)
  let l:name = synIDattr(l:synID, "name")
  let l:color = synIDattr(l:synID, "fg")
  if l:name == ""
    let l:name = "Normal"
  endif
  if l:color == ""
    let l:color = synIDattr(hlID("Normal"), "fg")
  endif
  return {l:name: l:color}
endfunction

function! GetCursorColors() abort
  " there are also lCursor and CursorIM, but i don't know when they are used
  return [ {"Cursor": synIDattr(hlID("Cursor"), "bg")}
        \ , {"CursorLine": synIDattr(hlID("CursorLine"), "bg")}
        \ , {"CursorLineNr": synIDattr(hlID("CursorLineNr"), "fg")}
        \ , {"CursorColumn": synIDattr(hlID("CursorColumn"), "bg")}
        \ , {"MatchParen": synIDattr(hlID("MatchParen"), "bg")}
        \ ]
endfunction

function! GetSpecialColors() abort
  return [ {"LineNr": synIDattr(hlID("LineNr"), "fg")}
        \ , {"VertSplitFg": synIDattr(hlID("VertSplit"), "fg")}
        \ , {"VertSplitBg": synIDattr(hlID("VertSplit"), "bg")}
        \ , {"FoldedFg": synIDattr(hlID("Folded"), "fg")}
        \ , {"FoldedBg": synIDattr(hlID("Folded"), "bg")}
        \ ]
  " Maybe also Directory, DiffStuff, IncSearch, Search, Pmenu, PmenuSel
  " A lot of interesting things in *highlight-default*
endfunction

" get color values of all words in the file + some more
function! GetColorValues() abort
  call cursor(1, 1)

  let l:index = 0
  let l:values = []
  while l:index < 26 " FIXME
    let l:values += [GetColorValue()]
    normal! w
    let l:index += 1
  endwhile

  " add cursor colors as well
  let l:values += GetCursorColors()

  " add background color
  let l:values += [{"Background": synIDattr(hlID("Normal"), "bg")}]

  " add other important colors
  let l:values += GetSpecialColors()

  " Note: most colorschemes have a problem that when you move a cursor on a
  " brace, the highlight of it and the matching brace are just awful, to the
  " point where I can't find where the cursor is at all. The colors are
  " captured as MatchParen, but i don't know how to show them

  call sort(l:values)
  call uniq(l:values)

  return l:values
endfunction

function WriteColorValues() abort
  call writefile([json_encode(GetColorValues())], "data.json")
endfunction
