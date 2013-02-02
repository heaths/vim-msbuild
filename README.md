msbuild.vim
===========

This Vim plugin enables syntax support for all typical MSBuild project and include files matching the following patterns:

* \*.\*proj
* \*.props
* \*.targets

You can also build an open project from within Vim using `:make`. Any warnings or errors can then be opened directly. You can also pass command line parameters to `:make` like you would to msbuild.exe, like:

    :make /t:rebuild

Some items and imported projects or targets can also be opened with `gf`. Any environment variables in the path are expanded automatically if possible.

Installation
------------

To keep up-to-date with changes, I recommend using Git and installing [pathogen.vim](https://github.com/tpope/vim-pathogen) so you can clone this repo or your own fork like so:

    mkdir %USERPROFILE%\vimfiles\bundle
    cd /d %USERPROFILE%\vimfiles\bundle
    git clone https://github.com/heaths/vim-msbuild.git

To make help content available when using pathogen, start vim and type `:Helptags`. You can then type `:help msbuild` for more information.

If you prefer to install the scripts directly, you can download the [vimball](http://www.vim.org/scripts/script.php?script_id=4422), open it in vim, and install it like so:

    vim msbuild.vba
    :so %
    :q

License
-------

Copyright 2013 Heath Stewart

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
