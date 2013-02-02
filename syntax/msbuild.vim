" Vim syntax file
" Language:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.0
" Repository:   https://github.com/heaths/vim-msbuild
" Vimball:      http://www.vim.org/scripts/script.php?script_id=4422

" Quit when a syntax file was already loaded for this buffer.
if exists("b:current_syntax") | finish | endif

" Make sure the continuation lines below do not cause problems in compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

" Define some defaults in case the included ftplugins don't set them.
let s:undo_ftplugin = ""

" Source the XML syntax for this buffer.
runtime! syntax/xml.vim syntax/xml/*.vim

" Make sure the syntax file is not loaded again for this buffer.
let b:current_syntax = "msbuild"

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet s:save_cpo
