" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set number

if has("gui_running")
    set guifont=Inconsolata\ Medium\ 14
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/syntastic'

Plugin 'taglist.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/vim-easy-align'

"Plugin 'Townk/vim-autoclose'
"Plugin 'edsono/vim-matchit'
Plugin 'vim-scripts/closetag.vim'

Plugin 'rust-lang/rust.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'

" fzf
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plugin 'junegunn/fzf.vim'

Plugin 'cespare/vim-toml'
Plugin 'nfvs/vim-perforce'

" Syntax highlighting extensions
Plugin 'justinmk/vim-syntax-extra'
Plugin 'plasticboy/vim-markdown'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'PProvost/vim-ps1'

Plugin 'airblade/vim-rooter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Motion/textobj plugins
Plugin 'bkad/CamelCaseMotion'
Plugin 'gaving/vim-textobj-argument'

call vundle#end()
filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=200      	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set viminfo='500,<500,s10,h 	" extend copy buffer to 200 lines

" autoindent and tabs = 4 spaces
set autoindent
set tabstop=4
set shiftwidth=4

" allow safe per-project .vimrc
set exrc
set secure

let g:tex_flavor='latex'

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"""Theme Settings
let g:solarized_termcolors=16
se t_Co=256
set background=light
colorscheme solarized


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

syntax enable
syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " force .md as markdown
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""Basic Key Mappings

" navigation
map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>

" make navigation visual not logic lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" fast esc
imap jk <Esc>

" toggle whitespace
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬,extends:·,precedes:·


"""NERDTree Config

" NERDTree File Highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .'ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Key mapping
map <C-n> :NERDTreeToggle<CR>

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="luna"
set laststatus=2

" CTags config
set autochdir
set tags=tags;
nnoremap <leader>. :Tags<cr>

" Search config
set incsearch
set nohlsearch

cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>``

" Syntastic config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_aggregate_errors = 1

"let g:syntastic_c_checkers = ['']
"let g:syntastic_cpp_checkers = ['']

"let g:syntastic_c_include_dirs = ['../../../inc', '../../inc', '../inc', 'inc']

let g:rooter_patterns = ['.vimroot', '.git/']
let g:rooter_silent_chdir = 1
"let g:rooter_manual_only = 1

"augroup vimrc_rooter
  "autocmd VimEnter * :Rooter
"augroup END

" Snippets config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" fzf config
let g:rg_command = '
			\ rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color=always
			\ -g "!{.git,_out}/*" '
command! -bang -nargs=* Rg call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

nnoremap <leader>o :execute ':Files ' . FindRootDirectory()<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <leader>f :Buffers<CR>

" easyalign config
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" motion/textobj plugin config
map <silent> <leader>w <Plug>CamelCaseMotion_w
map <silent> <leader>b <Plug>CamelCaseMotion_b
map <silent> <leader>e <Plug>CamelCaseMotion_e
map <silent> <leader>ge <Plug>CamelCaseMotion_ge
sunmap <leader>w
sunmap <leader>b
sunmap <leader>e
sunmap <leader>ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
