function! snips#utils#get_indent()
  if !&expandtab
    return "\t"
  endif
  if &shiftwidth
    return repeat(' ', &shiftwidth)
  endif
  return repeat(' ', &tabstop)
endfunction

function! snips#utils#compute_pos(offsetpos, pos_in_text, text)
  let l:lines = split(strpart(a:text, 0, a:pos_in_text), "\n")

  let l:lnum_in_text = len(l:lines) - 1
  let l:col_in_text = strlen(l:lines[-1])

  let l:lnum = a:offsetpos[0] + l:lnum_in_text
  let l:col = (l:lnum_in_text == 0 ? a:offsetpos[1] : 1) + l:col_in_text

  return [l:lnum, l:col]
endfunction

function! snips#utils#curpos()
  let l:pos = getcurpos()
  return [l:pos[1], l:pos[2]]
endfunction

function! snips#utils#get(dict, keys, def)
  let l:target = a:dict
  for l:key in a:keys
    if type(l:target) != v:t_dict | return a:def | endif
    let _ = get(l:target, l:key, v:null)
    unlet! l:target
    let l:target = _
    if l:target is v:null | return a:def | endif
  endfor
  return l:target
endfunction

function! snips#utils#resolve_prefixes(prefixes)
  let l:prefixes = []
  for l:prefix in a:prefixes
    call add(l:prefixes, l:prefix)
    if l:prefix =~# '^\a\w\+\%(-\w\+\)\+$'
      call add(l:prefixes, join(map(split(l:prefix, '-'), { i, v -> v[0] }), ''))
    endif
  endfor
  return l:prefixes
endfunction

