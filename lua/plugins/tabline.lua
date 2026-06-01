-- basically bufferline.nvim but native/simpler
vim.cmd([[
  function! Tabline()
    let s = ''
    for i in range(1, tabpagenr('$'))
      let s .= (i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
      let buflist = tabpagebuflist(i)
      let name = bufname(buflist[0])
      let file = name != '' ? fnamemodify(name, ':t') : '[No Name]'
      let mod = getbufvar(buflist[0], '&modified') ? ' +' : ''
      let s .= ' ' . file . mod . ' '
    endfor
    return s . '%#TabLineFill#%='
  endfunction
  set tabline=%!Tabline()
]])
