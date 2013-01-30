" Vim filetype plugin file
" Language:	MSBuild
" Maintainer:	Heath Stewart <heaths@outlook.com>
" Last Change:	2013 Jan 29

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

" Enable opening include files.
setl isfname+=(,)
setl includeexpr=substitute(v:fname,'\\$(\\(\\w\\+\\))','\\=expand(\"$\".submatch(1))','g')

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
let b:undo_ftplugin = "unlet! b:browsefilter | " . s:undo_ftplugin

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet s:save_cpo
