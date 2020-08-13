function GetColorValue()
  let l:synID = synID(line("."), col("."), 1)
  let l:synIDtrans = synIDtrans(l:synID)
  return "{\"group\":\"" . synIDattr(l:synID, "name") . "\",\"color\":\"" . synIDattr(l:synIDtrans, "fg") . "\"}"
endfunction

" get color values of file
function GetColorValues()
  call cursor(1, 1)
  let l:index = 0
  let l:values = "["
  while l:index < 26
    let l:values .= GetColorValue() . ","
    normal! w
    let l:index += 1
  endwhile
  let l:values .= "]"
  call writefile([l:values], "data.json", "b")
endfunction
