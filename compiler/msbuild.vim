" Vim compiler file
" Compiler:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.0

if exists("current_compiler")
  finish
endif
let current_compiler = "msbuild"

if exists(":CompilerSet") != 2
    " Older vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=\ %#%f(%l\\\,%c):\ %m
CompilerSet makeprg=msbuild\ \"%\"\ /nologo\ /v:q\ /property:GenerateFullPaths=true\ $*
