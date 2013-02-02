" Vim ftdetect plugin file
" Language:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.0

" Override the default file type setting.
au BufNewFile,BufRead *.*proj,*.props,*.targets set ft=msbuild
