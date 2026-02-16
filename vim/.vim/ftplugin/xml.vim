setlocal foldmethod=expr
setlocal foldexpr=XmlFold(v:lnum)

function! XmlFold(lnum)
  let line = getline(a:lnum)
  if line =~ '<!--'
    return '>1'
  elseif line =~ '-->'
    return '<1'
  endif
  return '='
endfunction

