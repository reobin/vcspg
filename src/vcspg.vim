" TODO: convert color names to color codes via $VIMRUNTIME/rgb.txt

function! GetColorValue() abort
  let l:synID = synID(line("."), col("."), 1)
  let l:name = synIDattr(l:synID, "name")
  let l:color = synIDattr(synIDtrans(l:synID), "fg")
  if l:name == ""
    let l:name = "Normal"
  endif
  if l:color == ""
    let l:color = synIDattr(hlID("Normal"), "fg")
  endif
  return {"group": l:name, "color": l:color}
endfunction

function! GetCursorColors() abort
  return [
        \ {"group": "Cursor", "color": synIDattr(hlID("Cursor"), "bg")}
        \ , {"group": "CursorLine", "color": synIDattr(hlID("CursorLine"), "bg")}
        \ , {"group": "CursorLineNr", "color": synIDattr(hlID("CursorLineNr"), "fg")}
        \ , {"group": "CursorColumn", "color": synIDattr(hlID("CursorColumn"), "bg")}
        \ , {"group": "MatchParen", "color": synIDattr(hlID("MatchParen"), "bg")}
        \ ]
endfunction

function! GetStatusBarColors() abort
  " insert mode colors could also be fetched using:
  " :startinsert
  " get colors
  " :stopinsert
  return [
        \ {"group": "StatusLine", "color": synIDattr(hlID("StatusLine"), "fg")}
        \ , {"group": "StatusLineBackground", "color": synIDattr(hlID("StatusLine"), "bg")}
        \ ]
endfunction

function! GetSpecialColors() abort
  return [
        \ {"group": "LineNr", "color": synIDattr(hlID("LineNr"), "fg")}
        \ , {"group": "VertSplitFg", "color": synIDattr(hlID("VertSplit"), "fg")}
        \ , {"group": "VertSplitBg", "color": synIDattr(hlID("VertSplit"), "bg")}
        \ , {"group": "FoldedFg", "color": synIDattr(hlID("Folded"), "fg")}
        \ , {"group": "FoldedBg", "color": synIDattr(hlID("Folded"), "bg")}
        \ ]
endfunction

" Get the last line # of the entire file
function! GetLastLine() abort
  return line("$")
endfunction

" Get the last column # of the given line
function! GetLastCol(line) abort
  call cursor(a:line, 1)
  return col("$")
endfunction

" get color values of all words in the file + some more
function! GetColorValues() abort
  let l:lastline = GetLastLine()

  let l:currentline = 1

  let l:values = []
  while l:currentline <= l:lastline
    let l:lastcol = GetLastCol(l:currentline)
    let l:currentcol = 1
    while l:currentcol <= l:lastcol
      call cursor(l:currentline, l:currentcol)
      let l:values += [GetColorValue()]
      let l:currentcol += 1
    endwhile
    let l:currentline += 1
  endwhile

  let l:values += GetCursorColors()
  let l:values += GetStatusBarColors()
  let l:values += [{"group": "Background", "color": synIDattr(hlID("Normal"), "bg")}]
  let l:values += GetSpecialColors()

  call sort(l:values)
  call uniq(l:values)

  return l:values
endfunction

function WriteColorValues() abort
  let l:defaultbackgroundvalue = synIDattr(hlID("Normal"), "bg")
  call writefile([json_encode(GetColorValues())], "default.json")

  set background=light
  let l:lightbackgroundvalue = synIDattr(hlID("Normal"), "bg")
  if l:defaultbackgroundvalue != l:lightbackgroundvalue
    call writefile([json_encode(GetColorValues())], "light.json")
  endif

  set background=dark
  let l:darkbackgroundvalue = synIDattr(hlID("Normal"), "bg")
  if l:defaultbackgroundvalue != l:darkbackgroundvalue
    call writefile([json_encode(GetColorValues())], "dark.json")
  endif
endfunction
