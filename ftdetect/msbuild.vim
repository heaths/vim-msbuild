" Vim ftdetect plugin file
" Language:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.0
" Repository:   https://github.com/heaths/vim-msbuild
" Vimball:      http://www.vim.org/scripts/script.php?script_id=4422

" Override the default file type setting.
au BufNewFile,BufRead *.*proj,*.props,*.targets set ft=msbuild
