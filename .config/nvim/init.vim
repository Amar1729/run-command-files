" Amar Paul's nvim init.vim

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/Amar/.config/nvim//repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/Amar/.config/nvim/')
  call dein#begin('/Users/Amar/.config/nvim/')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/Amar/.config/nvim//repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " colorscheme
  call dein#add('morhetz/gruvbox')

  " git gutter
  call dein#add('airblade/vim-gitgutter')

  " (vim plugin) minimap
  call dein#add('severin-lemaignan/vim-minimap')
  
  " powerline that works with neovim
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " bash and tmux airline-prompt generators
  call dein#add('edkolev/promptline.vim')
  call dein#add('edkolev/tmuxline.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


"""
" Personal Settings
"""

"""
" Look and Feel
"""

"colorscheme zenburn
colorscheme gruvbox
set background=dark
set number relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4

" hide modified buffers (?what is this)
"set hidden

"""
" Personal definitions
"""

" auto-reload config
augroup AutoCommands
	au!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC 
augroup END

let mapleader=","

" " Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Switch buffers more easily
nmap <leader>n :bnext<CR>
"nmap <leader>m :bprev<CR>	" use this for tab-switching?
nmap <leader>w <C-W><C-W>

" clear highlighted matches from find
nmap <leader><Space> :noh<CR>

" Hide status bar on command Shift+H
" From http://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction

" also want to hide airline buffer at top
function! TogBuf()
	if g:airline#extensions#tabline#enabled == 1
		let g:airline#extensions#tabline#enabled = 0
	else
		let g:airline#extensions#tabline#enabled = 1
	endif
endfunction

nnoremap <S-j> :call TogBuf()<CR>


nnoremap <S-h> :call ToggleHiddenAll()<CR>

"""
" Plugin Settings and Keybinds
"""

" vim-minimap settings
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'

" chromatica settings
let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1

" airline-vim, airline-vim-themes settings
" TODO

" Default:
 " let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
 " let g:airline_section_b       (hunks, branch)
 " let g:airline_section_c       (bufferline or filename)
 " let g:airline_section_gutter  (readonly, csv)
 " let g:airline_section_x       (tagbar, filetype, virtualenv)
 " let g:airline_section_y       (fileencoding, fileformat)
 " let g:airline_section_z       (percentage, line number, column number)
 " let g:airline_section_error   (ycm_error_count, syntastic, eclim)
 " let g:airline_section_warning (ycm_warning_count, whitespace)
" Changes:
let g:airline_section_x = airline#section#create(['virtualenv'])
let g:airline_section_y = airline#section#create(['branch'])
let g:airline_section_z = '%3p%% :%3v'
let g:airline_section_error = ''
let g:airline_section_warning = ''

" Patch the font myself
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" some ideas for airline theme:
" dark:
"	badcat, laederon, base16_twilight, bubblegum, distinguished, term
" light:
"	papercolor
let g:airline_theme='term'

" Don't rewrite my tmux conf!
let g:airline#extensions#tmuxline#enabled = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" promptline customization (for bash/fish and tmux)
" :PromptlineSnapshot [theme] [preset]
" :TmuxlineSnapshot [theme] [preset]

" Only print git information if not in top-level dotfiles repo
" https://github.com/edkolev/promptline.vim/blob/master/autoload/promptline/slices/vcs_branch.vim
let g:branch_symbol = promptline#symbols#get().vcs_branch
let vcs_revised_slice = {
  \'function_name': 'vcs_revised',
  \'function_body': [
    \'function vcs_revised {',
    \'  local branch',
    \'  local branch_symbol="' . branch_symbol . '"',
    \'  if hash git 2>/dev/null; then',
    \'    repo=$( { git remote -v | grep "dotfiles"; } 2>/dev/null )',
    \'    if [[ -z $repo ]]; then',
    \'    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then',
    \'      branch=${branch##*/}',
    \'      printf "%s" "${branch_symbol}${branch:-unknown}"',
    \'      return',
    \'    fi',
    \'    fi',
    \'  fi',
    \'  return 1',
    \'}']}
   

" so vcs_revised_slice.vim

let g:promptline_theme = 'airline'

let g:promptline_preset = {
	\'a' : [ promptline#slices#python_virtualenv(), '\[\033[1;37m\]\u\033[1m\]' ],
	\'b': [ promptline#slices#cwd({'dir_limit':2}) ],
	\'c' : [ vcs_revised_slice ],
	\'warn' : [ promptline#slices#last_exit_code(), promptline#slices#battery({'threshold':15}) ],
	\'x' : [ promptline#slices#python_virtualenv(), promptline#slices#user() ],
	\'z' : [ promptline#slices#git_status() ],
	\'options': {
		\'left_sections' : [ 'x', 'b', 'c' ],
		\'right_sections' : [ 'warn', 'z' ],
		\'left_only_sections' : [ 'a', 'b', 'c', 'warn' ]}}


