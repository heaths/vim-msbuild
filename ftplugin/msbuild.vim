" Vim filetype plugin file
" Language:     MSBuild
" Maintainer:   Heath Stewart <heaths@outlook.com>
" Version:      1.1
" Repository:   https://github.com/heaths/vim-msbuild
" Vimball:      http://www.vim.org/scripts/script.php?script_id=4422

" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin") | finish | endif

" Make sure the continuation lines below do not cause problems in compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

" Define some defaults in case the included ftplugins don't set them.
let s:undo_ftplugin = ""

" Source the XML plugins for this buffer.
runtime! ftplugin/xml.vim ftplugin/xml_*.vim ftplugin/xml/*.vim

" Don't load another plugin for this buffer.
let b:did_ftplugin = 1

" Override our defaults if these were set by an included ftplugin.
if exists("b:undo_ftplugin")
    let s:undo_ftplugin = b:undo_ftplugin
endif

" Set up global reserved properties.
setl iskeyword+=(,)

if !exists("g:msbuild_reserved") && exists("$ProgramFiles")
    let g:msbuild_reserved = {}
    if !exists("$ProgramFiles(x86)") || expand("$ProgramFiles") == expand("$ProgramFiles(x86)")
        let g:msbuild_reserved.MSBuildProgramFiles32 = expand('$ProgramFiles\')
        let g:msbuild_reserved.MSBuildProgramFiles = g:msbuild_reserved.MSBuildProgramFiles32
    else
        let g:msbuild_reserved.MSBuildProgramFiles32 = expand('$ProgramFiles(x86)\')
        let g:msbuild_reserved.MSBuildProgramFiles64 = expand('$ProgramFiles\')
        let g:msbuild_reserved.MSBuildProgramFiles = g:msbuild_reserved.MSBuildProgramFiles64
    endif

    let g:msbuild_reserved.MSBuildExtensionsPath32 = g:msbuild_reserved.MSBuildProgramFiles32 . 'MSBuild\'
    let g:msbuild_reserved.MSBuildExtensionsPath = g:msbuild_reserved.MSBuildProgramFiles . 'MSBuild\'

    if get(g:msbuild_reserved, "MSBuildProgramFiles64")
        let g:msbuild_reserved.MSBuildExtensionsPath64 = g:msbuild_reserved.MSBuildProgramFiles64 . 'MSBuild\'
    endif

    lockv! g:msbuild_reserved
endif

" Set up buffer-specific reserved properties.
let b:msbuild_reserved = {}
let b:msbuild_reserved.MSBuildThisFile = expand("%:t")
let b:msbuild_reserved.MSBuildThisFileDirectory = expand("%:p:h") . '\'
let b:msbuild_reserved.MSBuildThisFileDirectoryNoRoot = substitute(expand("%:p:h"), '\w:', "", "") . '\'
let b:msbuild_reserved.MSBuildThisFileExtension = expand("%:e")
let b:msbuild_reserved.MSBuildThisFileFullPath = expand("%:p")
let b:msbuild_reserved.MSBuildThisFileName = expand("%:t:r")

if expand("<afile>:e") =~ ".*proj$"
    let b:msbuild_reserved.MSBuildProjectFile = b:msbuild_reserved.MSBuildThisFile
    let b:msbuild_reserved.MSBuildProjectDirectory = b:msbuild_reserved.MSBuildThisFileDirectory
    let b:msbuild_reserved.MSBuildProjectDirectoryNoRoot = b:msbuild_reserved.MSBuildThisFileDirectoryNoRoot
    let b:msbuild_reserved.MSBuildProjectExtension = b:msbuild_reserved.MSBuildThisFileExtension
    let b:msbuild_reserved.MSBuildProjectFullPath = b:msbuild_reserved.MSBuildThisFileFullPath
    let b:msbuild_reserved.MSBuildProjectName = b:msbuild_reserved.MSBuildThisFileName
endif

" Merge global reserved properties and lock.
if exists("g:msbuild_reserved")
    let b:msbuild_reserved = extend(b:msbuild_reserved, g:msbuild_reserved)
endif

lockv! b:msbuild_reserved

" Define the function to resolve path variables.
func! MSBuildResolvePath(var)
    let properties = copy(b:msbuild_reserved)

    " Merge user-defined global properties, which may have changed.
    if exists("g:msbuild_properties") && type(g:msbuild_properties) == type({})
        let properties = extend(properties, g:msbuild_properties, "keep")
    endif

    " Merge user-defined buffer properties, which may have changed.
    if exists("b:msbuild_properties") && type(b:msbuild_properties) == type({})
        let properties = extend(properties, b:msbuild_properties, "keep")
    endif

    return get(properties, a:var, expand("$" . a:var))
endf

" Enable opening include files.
setl isfname+=(,)
setl includeexpr=simplify(substitute(v:fname,'\\$(\\(\\w\\+\\))','\\=MSBuildResolvePath(submatch(1))','g'))

" Set compiler options.
compiler msbuild

" Change the browse dialog on Win32 to show mainly MSBuild files
if has("gui_win32")
    let b:browsefilter = 
        \ "All MSBuild Files (*.*proj, *.props, *.targets)\t*.*proj;*.props;*.targets\n" .
        \ "MSBuild Project Files (*.*proj)\t*.*proj\n" .
        \ "MSBuild Import Files (*.props, *.targets)\t*.props;*.targets\n" .
        \ "All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed.
let b:undo_ftplugin =
    \ "unlockv! b:msbuild_reserved | " .
    \ "unlet! b:browsefilter b:msbuild_reserved | " .
    \ "setlocal iskeyword< isfname< includeexpr< | " .
    \ s:undo_ftplugin

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet! s:save_cpo
