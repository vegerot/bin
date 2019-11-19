"filetype plugin indent on
"syntax on
"
set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=indent,eol,start


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plugin 'keith/swift.vim'

Plugin 'rsmenon/vim-mathematica'

Plugin 'airblade/vim-gitgutter'

Plugin 'justinmk/vim-syntax-extra'

"Plugin 'vim-syntastic/syntastic'

Plugin 'ycm-core/YouCompleteMe'

Plugin 'nvie/vim-flake8'

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plugin 'Vimjas/vim-python-pep8-indent'

Plugin 'ivanov/vim-ipython'

Plugin 'vim-python/python-syntax'

Plugin 'wikitopian/hardmode'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

" Plugin 'Mathematica-Syntax-File'
" Plugin 'Mathematica-Indent-File'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()
Glaive codefmt plugin[mappings]
filetype plugin indent on    " required
syntax on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set incsearch
set hlsearch
nnoremap n nzz
nnoremap N Nzz

set tabstop=4
set shiftwidth=4
set expandtab
set nu
set relativenumber
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries 
        "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction


" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
    " vim -b : edit binary using xxd-format!
    augroup Binary
        au!

        " set binary option for all binary files before reading them
        au BufReadPre *.bin,*.hex setlocal binary

        " if on a fresh read the buffer variable is already set, it's wrong
        au BufReadPost *
                    \ if exists('b:editHex') && b:editHex |
                    \   let b:editHex = 0 |
                    \ endif

        " convert to hex on startup for binary files automatically
        au BufReadPost *
                    \ if &binary | Hexmode | endif

        " When the text is freed, the next time the buffer is made active it will
        " re-read the text and thus not match the correct mode, we will need to
        " convert it again if the buffer is again loaded.
        au BufUnload *
                    \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
                    \   call setbufvar(expand("<afile>"), 'editHex', 0) |
                    \ endif

        " before writing a file when editing in hex mode, convert back to non-hex
        au BufWritePre *
                    \ if exists("b:editHex") && b:editHex && &binary |
                    \  let oldro=&ro | let &ro=0 |
                    \  let oldma=&ma | let &ma=1 |
                    \  silent exe "%!xxd -r" |
                    \  let &ma=oldma | let &ro=oldro |
                    \  unlet oldma | unlet oldro |
                    \ endif

        " after writing a binary file, if we're in hex mode, restore hex mode
        au BufWritePost *
                    \ if exists("b:editHex") && b:editHex && &binary |
                    \  let oldro=&ro | let &ro=0 |
                    \  let oldma=&ma | let &ma=1 |
                    \  silent exe "%!xxd" |
                    \  exe "set nomod" |
                    \  let &ma=oldma | let &ro=oldro |
                    \  unlet oldma | unlet oldro |
                    \ endif
    augroup END
endif


"WINDOW CONFIG
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction

set laststatus=2
set statusline=win:%{WindowNumber()}

set showcmd

"Window end


"PEP 8 indentation standards
au BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix


"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_mode_map = {
"     \ "mode": "active"}
"let g:syntastic_loc_list_height = 3
"
"let g:syntastic_html_checkers=['eslint', 'w3']
"let g:syntastic_javascript_checkers=['eslint', 'w3']


"Pylint
let python_highlight_all=1
let g:python_highlight_all = 1

"YouCompleteMe
let g:ycm_clangd_args=['-log=verbose', '-pretty']
nnoremap <C-]> :YcmCompleter GoToDefinition<CR>
syntax on


au BufRead,BufNewFile bash-fc-* set filetype=sh
au BufRead,BufNewFile zsh* set filetype=sh

"make things difficult
let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = 'Don''t use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


