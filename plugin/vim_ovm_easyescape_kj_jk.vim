" Escape from Insert Mode By Typing ``jk`` or ``kj``
" Author: Landon Bouma <https://tallybark.com/>
" Online: https://github.com/landonb/vim-ovm-easyescape-kj-jk
" License: https://creativecommons.org/publicdomain/zero/1.0/
"  vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" Copyright © 2020 Landon Bouma.

" ########################################################################

" DEV: Uncomment the 'unlet', then <F9> to reload this file.
"       https://github.com/landonb/vim-source-reloader
"  silent! unlet g:loaded_ovm_easyescape_kj_jk

if exists("g:loaded_ovm_easyescape_kj_jk") || &cp
  finish
endif
let g:loaded_ovm_easyescape_kj_jk = 1

" ########################################################################

function! s:clear_bindings_easyescape_kj_jk()
  silent! cunmap kj
  silent! cunmap jk
endfunction

" From:
"   https://github.com/zhou13/vim-easyescape/
" Says:
"   Usage: Configuration 1: map of jk and kj (recommended) >>
function! s:setup_bindings_easyescape_kj_jk()
  let g:easyescape_chars = { "j": 1, "k": 1 }
  let g:easyescape_timeout = 100
  cnoremap kj <ESC>
  cnoremap jk <ESC>
endfunction

function! s:reset_bindings_easyescape_kj_jk()
  call <SID>clear_bindings_easyescape_kj_jk()
  call <SID>setup_bindings_easyescape_kj_jk()
endfunction

" ########################################################################

call <SID>reset_bindings_easyescape_kj_jk()

" ########################################################################

