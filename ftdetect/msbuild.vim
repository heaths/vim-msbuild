" Vim ftdetect plugin file
" Language:	MSBuild
" Maintainer:	Heath Stewart <heaths@outlook.com>
" Last Change:	2013 Jan 29

" Override the default file type setting.
au BufNewFile,BufRead *.*proj,*.props,*.targets set ft=msbuild
