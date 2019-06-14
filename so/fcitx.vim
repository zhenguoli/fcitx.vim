" fcitx.vim  记住插入模式小企鹅输入法的状态
" Author:       lilydjwg
" Maintainer:   lilydjwg
" Note:         另有使用 Python3 接口的新版本
" ---------------------------------------------------------------------
" Load Once:
if (has("win32") || has("win95") || has("win64") || has("win16"))
  " Windows 下不要载入
  finish
endif
if !(exists('$DISPLAY') || has('gui_macvim')) || exists('$SSH_TTY')
  finish
endif
if &cp || exists("g:loaded_fcitx") || !executable(g:fcitx_remote)
  finish
endif
let s:keepcpo = &cpo
let g:loaded_fcitx = 1
set cpo&vim
" ---------------------------------------------------------------------
" Functions:
function Fcitx2en()
  let b:inputstatus = system(g:fcitx_remote)
  call system(g:fcitx_remote . ' -s fcitx-keyboard-us')
endfunction

function Fcitx2Origin()
  try
    if b:inputstatus == 1
      call system(g:fcitx_remote . ' -c')
    elseif b:inputstatus == 2
      call system(g:fcitx_remote . ' -o')
    endif
  catch /inputstatus/
    let b:inputstatus = system(g:fcitx_remote)
  endtry
endfunction
" ---------------------------------------------------------------------
" Autocmds:
au InsertLeave * call Fcitx2en()
au InsertEnter * call Fcitx2Origin()
" ---------------------------------------------------------------------
"  Restoration And Modelines:
let &cpo=s:keepcpo
unlet s:keepcpo
" vim:fdm=expr:fde=getline(v\:lnum-1)=~'\\v"\\s*-{20,}'?'>1'\:1
