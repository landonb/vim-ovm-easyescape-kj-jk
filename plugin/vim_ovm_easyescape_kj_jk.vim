" vim:tw=0:ts=2:sw=2:et:norl
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/vim-ovm-easyescape-kj-jk
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Escape from Insert Mode By Typing `kj` or `jk`
" Requires: https://github.com/escape-vim/vim-async-map
" Copyright © 2020, 2024 Landon Bouma.

" -------------------------------------------------------------------

" USAGE: After editing this plugin, you can reload it on the fly with
"        https://github.com/landonb/vim-source-reloader#↩️
" - Uncomment this `unlet` (or disable the `finish`) and hit <F9>.
"
" silent! unlet g:loaded_vim_ovm_easyescape_kj_jk_plugin

if exists("g:loaded_vim_ovm_easyescape_kj_jk_plugin") || &cp
  finish
endif
let g:loaded_vim_ovm_easyescape_kj_jk_plugin = 1

" -------------------------------------------------------------------

" Wire 'kj' and 'jk' magic insert mode maps using vim-async-map:
"   https://github.com/embrace-vim/vim-async-map/
"
" Which is a fork/was inspired by the venerable vim-easyescape:
"   https://github.com/zhou13/vim-easyescape/
"
" When typed, either sequenbce exits insert mode.
"
" Note vim-async-map avoids editing buffer unnecessarily after
" the sequence is typed and processed. (Whereas vim-easyescape uses
" <BS> to remove typed sequence, which leaves buffer edited, thus
" requires user to undo, save, or don't-save.)
"
" Here we also add command mode maps for same key sequences (which
" is trivial and doesn't require much magic to work).

" -------------------------------------------------------------------

function! s:unmap_bindings_command_mode_kj_jk()
  silent! cunmap kj
  silent! cunmap jk
endfunction

function! s:remap_bindings_command_mode_kj_jk()
  cnoremap kj <ESC>
  cnoremap jk <ESC>
endfunction

function! s:setup_bindings_command_mode_kj_jk()
  call s:unmap_bindings_command_mode_kj_jk()
  call s:remap_bindings_command_mode_kj_jk()
endfunction

" -------------------------------------------------------------------

" HSTRY/2024-12-08: The vim-easyescape approach:
"
"   function! s:configure_plugin_vim_easyescape()
"     let g:easyescape_chars = { 'j': 1, 'k': 1 }
"     let g:easyescape_timeout = 100
"   endfunction

" CXREF/2024-12-14:
" ~/.vim/pack/embrace-vim/start/vim-async-map/autoload/embrace/async_map.vim

function! s:setup_bindings_insert_mode_kj_jk()
  call g:embrace#async_map#RegisterInsertModeMap("kj", "\<ESC>")
  call g:embrace#async_map#RegisterInsertModeMap("jk", "\<ESC>")
endfunction

" -------------------------------------------------------------------

" These bindings make 'jk'/'kj' toggleable, so you can bop between
" normal mode and insert mode.
" - Not *super* helpful, as 'i' is right above 'j' and 'k' on an
"   English keyboard, which enter insert mode.
"   - But parity can also be fun, and it shows off the flexibility
"     of vim-async-map.
" - Note that j/k is down/up, and since plugin does not wait for sequence
"   to be input, we will 'undo' previous press once seq. detected.
"   - E.g., if user presses 'kj', 'k' moves cursor up one line, then the
"   plugin captures 'j' and runs the map_command, which we set to 'ji' so
"   that cursor is moved down one line, then mode changes to insert mode.
"
" BWARE: The vim-async-map does not detect when *other* characters
" are typed within the sequence, e.g., if you type `juk` (down, undo,
" up) within the timeout (g:vim_async_map_timeout) for each press,
" the plugin will detect the `jk` sequence!
function! s:setup_bindings_normal_mode_kj_jk()
  if exists("g:vim_ovm_easyescape_kj_jk_add_normal_mode_maps")
      \ && !g:vim_ovm_easyescape_kj_jk_add_normal_mode_maps

    return
  endif

  call g:embrace#async_map#RegisterNormalModeMap("kj", "ji")
  call g:embrace#async_map#RegisterNormalModeMap("jk", "ki")
endfunction

" -------------------------------------------------------------------

function! s:setup_bindings_all_modes_kj_jk()
  " The plugin alerts and hints at fixes if Python 3 is not installed.
  if !exists("g:vim_async_map_timeout")

    let g:vim_async_map_timeout = 100
  endif

  " DUNNO: These maps run the command on `kj`/`jk` rather than cancel
  " it (which is what <Esc> does). They also temporarily scramble the
  " surrounding few characters until the timeout fixes it. Kinda weird.
  " Also don't remember why I ever added this binding, or if it ever
  " helped in any way. (Also who starts command mode and then wants
  " out with quickly? I'll just hit <Esc> to cancel.)
  "
  "  call s:setup_bindings_command_mode_kj_jk()

  try
    call s:setup_bindings_insert_mode_kj_jk()
    call s:setup_bindings_normal_mode_kj_jk()
	catch /^Vim\%((\a\+)\)\=:E117:/
    " E.g., E117: Unknown function: foo#bar#baz

    echom "ALERT: Please install embrace-vim/vim-async-map to enable "
      \ .. "`kj`/`jk` insert and normal mode maps"
  endtry
endfunction

call s:setup_bindings_all_modes_kj_jk()

" -------------------------------------------------------------------

