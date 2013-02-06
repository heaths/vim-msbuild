" Vim indent file
" Language:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.0
" Repository:   https://github.com/heaths/vim-msbuild
" Vimball:      http://www.vim.org/scripts/script.php?script_id=4422

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use XML formatting rules.
runtime! indent/xml.vim
