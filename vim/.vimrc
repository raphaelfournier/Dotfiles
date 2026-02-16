" <<< Vundle configuration 
set shell=/bin/bash
set nocompatible              " be iMproved, required
set hidden
filetype off                  " required
"set t_Co=256

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call plug#begin('~/.vim/plugged') " vimplug

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plug 'VundleVim/Vundle.vim'

" indispensables
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/loremipsum'
Plug 'gu-fan/colorv.vim' 
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'preservim/tagbar'
Plug 'lvht/tagbar-markdown'
Plug 'mileszs/ack.vim'
Plug 'mattn/calendar-vim'
"Plugin 'honza/vim-snippets'
Plug 'francoiscabrol/ranger.vim'
Plug 'jnurmine/Zenburn'

Plug 'godlygeek/tabular'
Plug 'simplenote-vim/simplenote.vim'
Plug 'benmills/vimux'

Plug 'embear/vim-localvimrc'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'conornewton/vim-pandoc-markdown-preview'

Plug 'ron-rs/ron.vim'

Plug 'JakeRoggenbuck/draft.vim'

Plug 'vimoutliner/vimoutliner'

Plug 'dylanaraps/wal.vim'
Plug 'yasukotelin/shirotelin'
Plug 'xolox/vim-misc'
Plug 'ayu-theme/ayu-vim'
"Plug 'chriskempson/base16-vim'
Plug 'quarto-dev/quarto-vim'
Plug 'jpalardy/vim-slime'


Plug 'NLKNguyen/papercolor-theme'
Plug 'endel/vim-github-colorscheme'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'cseelus/vim-colors-lucid'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'jaredgorski/spacecamp'
Plug 'chase/focuspoint-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'gilgigilgil/anderson.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }

"Plug 'kana/vim-textobj-user'

Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'chrisbra/unicode.vim'
Plug 'ferdinandyb/bibtexcite.vim'
Plug 'hauleth/vim-backscratch'
Plug 'christoomey/vim-system-copy'

Plug 'davidbeckingsale/writegood.vim'

"Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'

"Bundle 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/VST'
"Plugin 'codota/tabnine-vim'

Plug 'vim-scripts/mutt-canned'
Plug 'vim-scripts/swap'

Plug 'psf/black'

Plug 'ryicoh/deepl.vim'
Plug '0xStabby/chatgpt-vim'

Plug 'universal-ctags/ctags'
"Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
"Plugin 'Konfekt/vim-notmuch-addrlookup'
"Plugin 'felipec/notmuch-vim'
"Plugin 'alok/notational-fzf-vim'

Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

Plug 'vim-ctrlspace/vim-ctrlspace'

Plug 'scrooloose/syntastic'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
"Plugin 'mhinz/vim-signify'
Plug 'osyo-manga/vim-over'

Plug 'chmp/mdnav'
Plug 'mzlogin/vim-markdown-toc'
let g:vmt_dont_insert_fence = 1 " not comment around TOC
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jdonaldson/vim-markdown-link-convert'
Plug 'vimwiki/vimwiki'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

"Plugin 'davidhalter/jedi-vim'
Plug 'tpope/vim-fugitive'
"Plugin 'airblade/vim-gitgutter'

" vim 4 writing
"Plugin 'tpope/vim-markdown' " not needed ?
" https://github.com/preservim/vim-pencil
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-pencil-colors'
Plug 'preservim/vim-markdown'
Plug 'Raimondi/vim-lengthy'
Plug 'embear/vim-localvimrc'
Plug 'preservim/vim-wordy'

Plug 'junegunn/seoul256.vim'

" idées pas essayées
"Plug 'dpelle/vim-LanguageTool'
"Plug 'Ron89/thesaurus_query.vim'
"Plug 'thaerkh/vim-workspace'

let g:ip_boundary='-\?\s*$'
let g:tex_flavor = 'latex'

call plug#end() " vimplug
" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required

" >>>

" <<< Automatic rules for filetypes 
augroup LATEX
	au BufRead *tex nmap Q gqap
	"  au BufRead ~/.mutt/temp/mutt* map!  <F5>  <ESC>kgqji
augroup END

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

augroup WrapLineInTeXFile
	autocmd!
	autocmd FileType tex setlocal wrap linebreak nolist
  autocmd FileType tex setlocal fdm=marker " rien à voir avec wraping
	"autocmd FileType tex setlocal showbreak=+++
	"autocmd FileType tex setlocal formatoptions-=t
augroup END

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

set spelllang=fr

" vimOutliner
au BufEnter *.otl setlocal tabstop = 2
au BufEnter *.otl setlocal shiftwidth=2

augroup MARKDOWN
	au BufNewFile,BufRead *.md set syntax=liquid
  au BufEnter *.md* setlocal foldcolumn=0
  "au BufEnter *.md* setlocal foldlevel=99
	"au BufEnter *.md* setlocal foldexpr=MarkdownLevel()  

  au BufEnter *.md* setlocal foldmethod=syntax
	"au BufEnter *.md* setlocal foldexpr=MarkdownFold(v:lnum)
	autocmd BufNewFile,BufRead *.mdwn  setfiletype markdown
	autocmd BufNewFile,BufRead *.md   setfiletype=markdown
	au BufEnter *.md* colorscheme onehalfdark
	"let g:airline_theme='onehalfdark'
augroup END

"" fold region for headings
"syn region mkdHeaderFold
    "\ start="^\s*\z(#\+\)"
    "\ skip="^\s*\z1#\+"
    "\ end="^\(\s*#\)\@="
    "\ fold contains=TOP

"" fold region for lists
"syn region mkdListFold
    "\ start="^\z(\s*\)\*\z(\s*\)"
    "\ skip="^\z1 \z2\s*[^#]"
    "\ end="^\(.\)\@="
    "\ fold contains=TOP

au FileType markdown syn region myMkdHeaderFold
        \ start="\v^\s*\z(\#{1,6})"
        \ skip="\v(\n\s*\z1\#)\@="
        \ end="\v\n(\s*\#)\@="ms=s-1,me=s-1
        \ fold contains=myMkdHeaderFold

syn sync fromstart


" Disable folding specifically for vimrc files

"augroup pencil
"autocmd!
"autocmd FileType markdown,mkd call pencil#init()
""\ | call lexical#init()
""\ | call litecorrect#init()
""\ | call textobj#quote#init()
""\ | call textobj#sentence#init()
"augroup END

" Select the whole frame including \begin and \end
nnoremap <leader>af ?^\\begin{frame}<CR>V/^\\end{frame}<CR>

" Select just the inside of the frame (exclude \begin and \end lines)
nnoremap <leader>if ?^\\begin{frame}<CR>jV/^\\end{frame}<CR>k

augroup MUTT
	au BufRead ~/.mutt/temp/*mutt* set spell " <-- vim 7 required
	au BufRead ~/.mutt/temp/*mutt* set nonu
	au BufRead ~/.mutt/temp/*mutt* nmap  <F5>  gqap
	au BufRead ~/.mutt/temp/*mutt* nmap  <F6>  gqqj
	au BufRead ~/.mutt/temp/*mutt* nmap  <F7>  kgqj
	au BufRead ~/.mutt/temp/*mutt* nmap  <F7>  vipJ
	au BufRead ~/.mutt/temp/*mutt* map!  <F5>  <ESC>gqapi
	au BufRead ~/.mutt/temp/*mutt* map!  <F6>  <ESC>gqqji
	au BufRead ~/.mutt/temp/*mutt* map!  <F7>  <ESC>kgqji
	au BufRead ~/.mutt/temp/*mutt* setlocal wrap linebreak nolist
	"au BufRead ~/.mutt/temp/*mutt* colorscheme onehalfdark
	"au BufRead ~/.mutt/temp/*mutt* colorscheme one
	"au BufRead ~/.mutt/temp/*mutt* setlocal showbreak=+++
	"au BufRead ~/.mutt/temp/*mutt* setlocal formatoptions-=t
	au BufRead ~/Dotfiles/mail/.mutt/temp/*mutt* nmap  ,x  <ESC>oScheduler: 8:05 AM tomorrow
	"au BufRead ~/.mutt/temp/*mutt* setlocal fo+=aw

	au BufRead ~/.mutt/temp/mutt* source ~/.vim/bundle/mutt-canned/plugin/mutt-canned.vim
	"au BufRead ./example.file source ./mutt-canned.vim
augroup END

au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake

function! MarkdownFold(lnum)
  let line = getline(a:lnum)

  " If line starts with #, fold based on number of #'s
  if line =~ '^#\+ '
    return match(line, '#\+') + 1
  endif

  " Otherwise: keep the same fold level as previous line
  return '='
endfunction


function! MarkdownLevel()
	"if getline(v:lnum) =~ '^---$'
	"return ">1"
	"endif
	if getline(v:lnum) =~ '^# .*$'
		return ">1"
	endif
	"if getline(v:lnum) =~ '^### .*$'
	"return ">3"
	"endif
	"if getline(v:lnum) =~ '^#### .*$'
	"return ">4"
	"endif
	return "=" 
endfunction

"autocmd VimEnter * if argc() > 1 && !exists("s:std_in") | execute "vsp " . argv() | wincmd p | argdelete" | endif
" >>>

" <<< Bindings 
let mapleader = ","
"let maplocalleader = "<space>"

"nnoremap <leader>v :vnew<CR>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>ch :hi! link Comment Ignore<CR>
nnoremap <leader>cs :hi! link Comment Comment<CR>
map ,nu :set invnumber<CR>
map ,nr :set invrelativenumber<CR>
map ,no :set nonumber<CR>
" instead of :nohlsearch<CR> :
map ,nh :set invhlsearch<CR> 
map ,ns :set invspell<CR>
map ,fr :setlocal spell spelllang=fr<CR>
map ,en :setlocal spell spelllang=en<CR>
map ,fe :setlocal spell spelllang=en,fr<CR>
" comment 
map ,zc :set fdm=expr<CR> :set fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0<CR>zM

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" decompte de mots latex
map ,wc :w !detex \| wc -w<CR>
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" close the quickfix window return to position
nnoremap <leader>q :cclose<CR>`A 

vnoremap <C-X> <Esc>`.``gvP``P

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" permet de ne pas retaper les longs chemins
map ,ed :e <C-R>=expand("%:p:h") . "/" <CR>
"
"makes K split lines (the opposite of J)
nnoremap K i<cr><esc>k$ 
nnoremap Q gqip
nnoremap <tab> %
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
let g:lasttab = 1
nmap <Leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" Â« v,d Â» et Â« v,s Â» lancent firefox et une recherche (dÃ©finition ou synonyme) dans le tlfi sur le mot courant
vmap ,d :<C-U>!luakit "http://www.cnrtl.fr/lexicographie/<cword>" >& /dev/null<CR><CR>
vmap ,s :<C-U>!luakit "http://www.cnrtl.fr/synonymie/<cword>" >& /dev/null<CR><CR>
" Â« v,g Â» comme ci-dessus mais pour google
vmap ,g :<C-U>!luakit "http://www.google.fr/search?hl=fr&q=<cword>&btnG=Recherche+Google&meta=" >& /dev/null<CR><CR>
"Â« v,w Â» comme ci-dessus mais pour wikipedia
vmap ,w :<C-U>!luakit "http://fr.wikipedia.org/wiki/<cword>" >& /dev/null<CR><CR>
" Â« v,c Â» comme ci-dessus mais pour le conjugueur
vmap ,cv :<C-U>!luakit "http://www.leconjugueur.com/php5/index.php?v=<cword>" >& /dev/null<CR><CR>
" Â« v,o Â» ouvre lâ€™url sur laquelle on se trouve dans firefox
vmap ,o :<C-U>!firefox "<cfile>" >& /dev/null<CR><CR>
"vimbits
" search word in center of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
imap <C-b> <Plug>Tex_MathBF
imap <C-c> <Plug>Tex_MathCal
" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>Ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

">>>

" <<< Colors 

" pairs of colorschemes I like to use:
" light is the first one, dark is the second.
let g:duo_themes = [ {'name': 'PaperColor', 'bg': 'light', 'airlinetheme': 'light'}, {'name': 'zenburn', 'bg': 'dark', 'airlinetheme': 'angr'} ]

func! s:set_colorscheme(color)
	if has_key(a:color, 'bg')
		let &bg = a:color['bg']
		let g:airline_theme=a:color['airlinetheme']
	endif
	if has_key(a:color, 'name')
		exe "colorscheme ".a:color['name']
	endif
endfunc

func! ToggleColorscheme()
	if !exists('g:colors_name')
		let g:colors_name = 'default'
	endif
	let color = filter(copy(g:duo_themes), {k, v -> v['name'] != g:colors_name})[0]
	call s:set_colorscheme(color)
endfunc
nnoremap <Leader>bg :call ToggleColorscheme()<CR>

"let g:zenburn_force_dark_Background = 1
"let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
"let g:zenburn_alternate_Visual = 1

" background transparent
"hi Normal guibg=NONE ctermbg=NONE

let inout = system("cat ~/.insideOutside | tr -d '\n'")
" si on est dedans, on active thÃ¨me sombre
if inout == "in" 
	colors zenburn
	"colors base16-zenburn
	let g:airline_theme='angr'
" sinon, le thÃ¨me light
else
	"colorscheme shirotelin
	"set background=light
	"" This is only necessary if you use "set termguicolors".
	"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	"set termguicolors " required for kitty
	"set t_Co=256
	"let base16colorspace=256
	"colorscheme base16-one-light

	let g:airline_theme='light'

	set background=light
	colorscheme PaperColor
	let g:PaperColor_Theme_Options = {
				\   'theme': {
				\     'default': {
				\       'transparent_background': 0
				\     }
				\   }
				\ }
endif


"colorscheme lucid

"colorscheme onehalflight " pas mal du tout! 

"colorscheme spacecamp
"colorscheme spacecamp_lite

"colorscheme challenger_deep
"colorscheme anderson



colors zenburn
"highlight SpellBad gui=undercurl guisp=#ff6c6b cterm=underline ctermfg=Red
" --- Spellcheck colors tuned for Zenburn ---

"colors onehalfdark

"colo seoul256
"colo seoul256-light
"colors onedark
"colorscheme shirotelin " clair
"colorscheme wal
">>>

" <<< Editor Options 
set textwidth=80 
set wrapmargin=0 " inutile si textwidth est >0
set colorcolumn=80
set linebreak " avoid cutting words
set wrap
set columns=80
"set numberwidth=6

"autocmd VimResized * if (&columns > 80) | set columns=80 | endif
"set showbreak=+++

syn on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set splitbelow
set splitright
set cursorline " Highlight current line
set showmatch
filetype plugin on
" Show special characters in the file.
" colorise les nbsp
" nbsp affiches par 'Â·'
"set list
"set listchars=tab:>·,trail:·,nbsp:·
"set listchars=tab:>·,trail:·extends:#,nbsp:·
highlight NbSp ctermbg=lightred guibg=lightred
match NbSp /\%xa0/
"set rnu " number
"set nu " number
set ruler
" paste mode
set pastetoggle=<F11>
set incsearch                   " Find as you type search
set nohlsearch                    " Disable HLsearch on startup
set ignorecase                  " Case insensitive search
set wildignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
" highlight
"set scrolloff=999
set scrolloff=5
" use tabs as spaces
set expandtab
set sw=2
set ts=2
"set softtabstop=2
" export html ok
let html_use_css = 1
set nojoinspaces
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
"""""
"set mouse=a
set mouse=v
"set ttymouse=urxvt
set foldmethod=indent
set foldlevelstart=99
"set foldlevel=99
set foldcolumn=0
" completion
set wildmenu
set wildmode=list:longest,full

"if &term == "screen-256color"
"let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
"set t_ts=k
"set t_fs=\
"endif

set title

" >>>

" <<< Plugins Options 
"
" calendar-vim
let g:calendar_mark = 'right'
let g:calendar_monday = 1
let g:calendar_wruler = 'Di Lu Ma Me Je Ve Sa'
let g:calendar_mruler = 'Jan,Fev,Mars,Avr,Mai,Juin,Juil,Aout,Sept,Oct,Nov,Dec'
let g:calendar_datetime = 'statusline'
let g:calendar_diary=$HOME.'/.vim/diary'
let g:calendar_weeknm = 1 " WK01
let g:calendar_number_of_months = 5


autocmd VimEnter * silent! unmap <leader>cal | silent! unmap <leader>caL
autocmd VimEnter * nnoremap <leader>cal :CalendarH<CR>
autocmd VimEnter * nnoremap <leader>caL :CalendarV<CR>

function! MyCalAction(day, month, year, week, dir)
	" Month names
	let l:months = [
				\ 'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
				\ 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
				\ ]

	" Build date string "day month"
	let l:date = printf('%d %s prochain', a:day, l:months[a:month - 1])

	" Copy to registers
	let @+ = l:date  " System clipboard
	let @* = l:date  " PRIMARY selection (X11)
	let @" = l:date  " Default unnamed register

	echo 'Copied: ' . l:date
endfunction

let calendar_action = 'MyCalAction'

" Disable the default <Enter> mapping (diary entry)
autocmd FileType calendar silent! nunmap <buffer> <CR>
" " Remap <Enter> to trigger your action
autocmd FileType calendar nnoremap <buffer> <CR> :call calendar#action()<CR>


" Vimux
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>


" gitgutter. Reenable with :GitGutterToggle
let g:gitgutter_enabled = 0

let g:muttaliases_file = '/home/raph/.mutt/aliases'

"https://github.com/vim-ctrlspace/vim-ctrlspace
set showtabline=0

let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
let g:deepl#auth_key = "8a004057-94dd-b96a-b8d8-6b8b6280bc00:fx"

" replace a visual selection
vmap ,<C-e> <Cmd>call deepl#v("EN")<CR>
vmap ,<C-j> <Cmd>call deepl#v("FR")<CR>

" translate a current line and display on a new line
nmap ,<C-e> yypV<Cmd>call deepl#v("EN")<CR>
nmap ,<C-j> yypV<Cmd>call deepl#v("FR")<CR>

" specify the source language
" translate from FR to EN
nmap t<C-e> yypV<Cmd>call deepl#v("EN", "FR")<CR>

"let g:swap_custom_ops = ['first_operator', 'second_operator', ...] 
"vmap <leader>s         <plug>SwapSwapOperands
"vmap <leader><leader>x <plug>SwapSwapOperandsPivot
"nmap <leader>x         <plug>SwapSwapWithR_WORD
"nmap <leader>X         <plug>SwapSwapWithL_WORD

"let scl = "number"
"
nnoremap <leader>gG :call FoldColumnToggle()<cr>

nnoremap <leader>S :SimplenoteList<cr>

function! FoldColumnToggle()
	if &foldcolumn
		setlocal foldcolumn=0
	else
		setlocal foldcolumn=3
	endif
endfunction

nnoremap <Leader>gg :call ToggleSignColumn()<CR>
" Toggle signcolumn. Works on vim>=8.1 or NeoVim
function! ToggleSignColumn()
	if !exists("b:signcolumn_on") || b:signcolumn_on
		set signcolumn=no
		let b:signcolumn_on=0
	else
		set signcolumn=number
		let b:signcolumn_on=1
	endif
endfunction

" taglist
let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections;x:todo'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
set iskeyword=@,48-57,_,-,:,192-255
"nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>

let g:airline#extensions#tagbar#enabled = 0

"let g:pencil#wrapModeDefault = 'soft'
"let g:airline_section_x = '%{PencilMode()}'
"let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}

let g:muttaliases_file = '~/.mutt/aliases'

let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'

" fugitive Gdiff = Gvdiff
set diffopt+=vertical


let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1

let g:SimpylFold_docstring_preview = 1
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1

let g:md_pdf_viewer="zathura"
let g:md_args = "--template eisvogel --listings"
nnoremap <leader>P :StartMdPreview<CR>

" notational
let g:nv_search_paths = ['~/Notes', '/home/raph/Publications/Blogging/sbadmin2']
" String. Set to '' (the empty string) if you don't want an extension appended by default.
" Don't forget the dot, unless you don't want one.
let g:nv_default_extension = '.md'

" String. Default is first directory found in `g:nv_search_paths`. Error thrown
"if no directory found and g:nv_main_directory is not specified
"let g:nv_main_directory = g:nv_main_directory or (first directory in g:nv_search_paths)

" Dictionary with string keys and values. Must be in the form 'ctrl-KEY':
" 'command' or 'alt-KEY' : 'command'. See examples below.
let g:nv_keymap = {
			\ 'ctrl-s': 'split ',
			\ 'ctrl-v': 'vertical split ',
			\ 'ctrl-t': 'tabedit ',
			\ }

" String. Must be in the form 'ctrl-KEY' or 'alt-KEY'
let g:nv_create_note_key = 'ctrl-x'

" String. Controls how new note window is created.
let g:nv_create_note_window = 'vertical split'

" Boolean. Show preview. Set by default. Pressing Alt-p in FZF will toggle this for the current search.
let g:nv_show_preview = 1

" Boolean. Respect .*ignore files in or above nv_search_paths. Set by default.
let g:nv_use_ignore_files = 1

" Boolean. Include hidden files and folders in search. Disabled by default.
let g:nv_include_hidden = 0

" Boolean. Wrap text in preview window.
let g:nv_wrap_preview_text = 1

" String. Width of window as a percentage of screen's width.
let g:nv_window_width = '40%'

" String. Determines where the window is. Valid options are: 'right', 'left', 'up', 'down'.
let g:nv_window_direction = 'down'

" String. Command to open the window (e.g. `vertical` `aboveleft` `30new` `call my_function()`).
"let g:nv_window_command = 'call my_function()'

" Float. Width of preview window as a percentage of screen's width. 50% by default.
let g:nv_preview_width = 50

" String. Determines where the preview window is. Valid options are: 'right', 'left', 'up', 'down'.
let g:nv_preview_direction = 'right'

" String. Yanks the selected filenames to the default register.
let g:nv_yank_key = 'ctrl-y'

" String. Separator used between yanked filenames.
let g:nv_yank_separator = "\n"

" Boolean. If set, will truncate each path element to a single character. If
" you have colons in your pathname, this will fail. Set by default.
let g:nv_use_short_pathnames = 1

"List of Strings. Shell glob patterns. Ignore all filenames that match any of
" the patterns.
let g:nv_ignore_pattern = ['summarize-*', 'misc*']

" List of Strings. Key mappings like above in case you want to define your own
" handler function. Most users won't want to set this to anything.
let g:nv_expect_keys = []

nnoremap <silent> <c-s> :NV<space> 

set tags=.tags;

let g:tagbar_autofocus=1
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_compact = 1
let g:tagbar_indent = 1
"let g:tagbar_width = 30
let g:tagbar_autoclose = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_type_latex = {
			\ 'ctagstype' : 'latex',
			\ 'kinds'     : [
			\ 's:sections',
			\ 'g:graphics:0:0',
			\ 'l:labels',
			\ 'r:refs:1:0',
			\ 'p:pagerefs:1:0'
			\ ],
			\ 'sort'    : 0,
			\ }
let g:tagbar_type_rst = {
			\ 'ctagstype': 'rst',
			\ 'ctagsbin' : '/home/raph/.scripts/rst2ctags/rst2ctags.py',
			\ 'ctagsargs' : '-f - --sort=yes',
			\ 'kinds' : [
			\ 's:sections',
			\ 'i:images'
			\ ],
			\ 'sro' : '|',
			\ 'kind2scope' : {
			\ 's' : 'section',
			\ },
			\ 'sort': 0,
			\ }
let g:tagbar_type_markdown = {
			\ 'ctagstype': 'markdown',
			\ 'ctagsbin' : '/home/raph/.scripts/markdown2ctags/markdown2ctags.py',
			"\ 'ctagsargs' : '-f - --sort=yes --sro=»',
			\ 'ctagsargs' : '-f - --sort=yes',
			\ 'kinds' : [
			\ 's:sections',
			\ 'i:images'
			\ ],
			"\ 'sro' : '»',
			\ 'kind2scope' : {
			\ 's' : 'section',
			\ },
			\ 'sort': 0,
			\ }
"let g:tagbar_type_tex = {
"\ 'ctagstype' : 'latex',
"\ 'kinds' : [
"\ 's:sections',
"\ 'g:graphics:1:0',
"\ 'l:labels',
"\ 'r:refs:1:0',
"\ 'p:pagerefs:1:0'
"\ ],
"\ 'sort' : 0,
"\ }

" add lines without going into insert mode
"nmap t o<ESC>k
"nmap T O<ESC>j
" source /home/raph/.config/bepo/vimrc.bepo
" Check code every save
" simplenote
source ~/.simplenote-vim.rc

" lazy scrolling
"noremap <BS> <PageUp>
"noremap <Space> <PageDown>
filetype detect
set viminfo='1000,f1

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
let g:goyo_width = 100
let g:goyo_height = 90

" limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 3

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
" end limelight

let g:calendar_google_calendar = 1
"let g:calendar_frame = 'default'

" PyMode {
" Disable if python support not present
if !has('python') && !has('python3')
	let g:pymode = 0
endif

if isdirectory(expand("~/.vim/bundle/python-mode"))
	let g:pymode_lint_checkers = ['pyflakes']
	let g:pymode_trim_whitespaces = 0
	let g:pymode_options = 0
	let g:pymode_rope = 0
	let g:pymode_lint_write = 0
endif
" }

set undofile
set undodir=~/.vim/undo/

nnoremap <Leader>u :UndotreeToggle<CR>
"" If undotree is opened, it is likely one wants to interact with it.
"let g:undotree_SetFocusWhenToggle=1

" indent_guides {
if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
	let g:indent_guides_start_level = 2
	let g:indent_guides_guide_size = 1
	let g:indent_guides_enable_on_vim_startup = 1
endif
" }

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ctrlp {
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
	let g:ctrlp_working_path_mode = 'wa' " better than ra ?
	nnoremap <leader>p :CtrlP<CR>
	"nnoremap <leader>o :CtrlPMRU<CR>
	let g:ctrlp_custom_ignore = {
				\ 'dir':  '\.git$\|\.hg$\|\.svn$',
				\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

	if executable('ag')
		let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
	elseif executable('ack-grep')
		let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
	elseif executable('ack')
		let s:ctrlp_fallback = 'ack %s --nocolor -f'
	" On Windows use "dir" as fallback command.
	elseif WINDOWS()
		let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
	else
		let s:ctrlp_fallback = 'find %s -type f'
	endif
	if exists("g:ctrlp_user_command")
		unlet g:ctrlp_user_command
	endif
	let g:ctrlp_user_command = {
				\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
				\ 2: ['.hg', 'hg --cwd %s locate -I .'],
				\ },
				\ 'fallback': s:ctrlp_fallback
				\ }

	if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
		" CtrlP extensions
		let g:ctrlp_extensions = ['funky']

		"funky
		nnoremap <Leader>fu :CtrlPFunky<Cr>
	endif
endif
"}

" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
"let g:vimtex_complete_enabled=1
"
let g:vimtex_view_method='zathura'
let g:vimtex_main_file_auto = 0
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
" Or with a generic interface:
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
"let g:vimtex_compiler_method = 'latexrun'
let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
"let g:vimtex_maplocalleader = ","
let g:vimtex_quickfix_mode=0

set conceallevel=1
let g:tex_conceal='abdmg'
" TOC settings
let g:vimtex_toc_config = {
			\ 'name' : 'TOC',
			\ 'layers' : ['content', 'todo', 'include'],
			\ 'resize' : 1,
			\ 'todo_sorted' : 0,
			\ 'show_help' : 1,
			\ 'show_numbers' : 1,
			\ 'mode' : 2,
			\}

call vimtex#imaps#add_map({
			\ 'lhs' : 'b',
			\ 'rhs' : '\bigskip ',
			\ 'leader' : ',',
			\ 'wrapper' : 'vimtex#imaps#wrap_trivial'
			\})
call vimtex#imaps#add_map({
			\ 'lhs' : 'p',
			\ 'rhs' : '\part ',
			\ 'leader' : ',',
			\ 'wrapper' : 'vimtex#imaps#wrap_trivial'
			\})
call vimtex#imaps#add_map({
			\ 'lhs' : 'i',
			\ 'rhs' : '\item ',
			\ 'leader' : ',',
			\ 'wrapper' : 'vimtex#imaps#wrap_trivial'
			\})
call vimtex#imaps#add_map({
			\ 'lhs' : 'o',
			\ 'rhs' : 'itemize',
			\ 'leader' : ',',
			\ 'wrapper' : 'vimtex#imaps#wrap_trivial'
			\})

let g:vimtex_toc_enabled=1

">>>

" <<< Misc 

au BufNewFile,BufRead *.plt,*.gnuplot,*.plot setf gnuplot
autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks  setfiletype task

autocmd filetype tex highlight MatchParen ctermbg=0

function! ShowColourSchemeName()
	try
		echo g:colors_name
	catch /^Vim:E121/
		echo "default
	endtry
endfunction

"https://www.hillelwayne.com/post/intermediate-vim/
command! Vimrc :vs $MYVIMRC
command! ZenburnColors :vs /home/raph/.config/Xresources/Xdefaults.colors.zenburn
command! AwesomeWMTheme :vs /home/raph/.config/awesome/themes/myzenburn/theme.lua
command! MuttAliases :vs ~/.mutt/aliases
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l
"

set suffixesadd='.tex'

command! -nargs=* Hardcopy call DoMyPrint('<args>')
function DoMyPrint(args)
	let colorsave=g:colors_name
	color print
	exec 'hardcopy '.a:args
	exec 'color '.colorsave
endfunction

:map ,s :if exists("g:syntax_on") <Bar>                                    
			\   syntax off <Bar>                                                    
			\ else <Bar>                                                            
			\   syntax enable <Bar>                                                 
			\ endif <CR> 

set switchbuf=useopen,split,usetab,newtab

" youCompleteMe
"let g:ycm_autoclose_preview_window_after_completion=1
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
""let g:UltiSnipsSnippetDirectories=$HOME.'/.vim/mysnippets'
"let g:UltiSnipsSnippetDir="~/.vim/mysnippets"
"let g:UltiSnipsEditSplit="vertical"

"let g:ycm_use_ultisnips_completer = 1
"let g:ycm_cache_omnifunc = 1
"let g:UltiSnipsEnableSnipMate = 1

"" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
"" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_force_overwrite_completefunc = 1

let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns._ = '\h\w*'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/mysnippets'

" Plugin key-mappings {
" These two lines conflict with the default digraph mapping of <C-K>
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"if exists('g:spf13_noninvasive_completion')
"inoremap <CR> <CR>
"" <ESC> takes you out of insert mode
"inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
"" <CR> accepts first, then sends the <CR>
"inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
"" <Down> and <Up> cycle like <Tab> and <S-Tab>
"inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
"inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
"" Jump up and down the list
"inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
"inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
"else
"imap <silent><expr><C-k> neosnippet#expandable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
"\ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
"smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

"inoremap <expr><C-g> neocomplcache#undo_completion()
"inoremap <expr><C-l> neocomplcache#complete_common_string()
""inoremap <expr><CR> neocomplcache#complete_common_string()

"function! CleverCr()
"if pumvisible()
"if neosnippet#expandable()
"let exp = "\<Plug>(neosnippet_expand)"
"return exp . neocomplcache#close_popup()
"else
"return neocomplcache#close_popup()
"endif
"else
"return "\<CR>"
"endif
"endfunction

"" <CR> close popup and save indent or expand snippet
"imap <expr> <CR> CleverCr()

"" <CR>: close popup
"" <s-CR>: close popup and save indent.
"inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
""inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y> neocomplcache#close_popup()
"endif
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" }

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
" }

" find next occurence of character under cursor
nnoremap <leader>z xhp/<C-R>-<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"project_base_dir = os.environ['VIRTUAL_ENV']
"activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"execfile(activate_this, dict(__file__=activate_this))
"EOF
let python_highlight_all=1

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

vnoremap // y/<C-R>"<CR>

" hard mode

" disable arrow keys
"
" very hard mode
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>
"
" auto exit of insert mode after 4sec
"au CursHoldI * stopinstert

"let g:vimwiki_customwiki2html=$HOME.'/.vim/autoload/vimwiki/customwiki2html.sh'
"let g:vimwiki_list = [{'path': '~/Notes/vimwiki/', 'path_html': '~/public_html/vimwiki', 'ext': '.md', 'syntax': 'markdown'}]
"let g:vimwiki_list = [{'path': '~/.vimwiki/', 'ext': '.md', 'syntax': 'markdown'}]
let wiki_1                          = {}
let wiki_1.path                     = '~/.vimwiki/'
let wiki_1.links_space_char         = '-'
let wiki_1.ext                      = '.md'
let wiki_1.path_html                = '~/Notes/vimwiki-notes'
let wiki_1.auto_export              = 1
let wiki_1.syntax                   = 'markdown'
let wiki_1.custom_wiki2html         = '~/.scripts/markdown_to_note'
let wiki_1.custom_wiki2html_args    = ''
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list                  = [wiki_1]

nmap <Leader>wx :vs \| :VimwikiIndex<CR>

"autocmd BufWritePost *.md call vimwiki#vars#set_wikilocal('custom_wiki2html_args', '', 0) | execute ':silent Vimwiki2HTML' | call vimwiki#vars#set_wikilocal('custom_wiki2html_args', '', 0) | execute ':redraw!'

"let g:vimwiki_markdown_link_ext = 1

" a function to execute formd and return the cursor back
" to it's original position within the buffer. 
" dr bunsen

function! Formd(option)
	:let save_view = winsaveview()
	:let flag = a:option
	:if flag == "-r"
	:%! /usr/bin/formd -r
	:elseif flag == "-i"
	:%! /usr/bin/formd -i
	:else
	:%! /usr/bin/formd -f
	:endif
	:call winrestview(save_view)
endfunction

" formd mappings
nmap <leader>Fr :call Formd("-r")<CR>
nmap <leader>Fi :call Formd("-i")<CR>

function! ToggleCalendar()
	execute ":Calendar"
	if exists("g:calendar_open")
		if g:calendar_open == 1
			execute "q"
			unlet g:calendar_open
		else
			g:calendar_open = 1
		end
	else
		let g:calendar_open = 1
	end
endfunction

au FileType vimwiki map <leader>wc :call ToggleCalendar() <cr>

augroup vimwikigroup
	autocmd!
	" automatically update links on read diary
	autocmd BufRead,BufNewFile ~/Notes/vimwiki/diary/diary.md VimwikiDiaryGenerateLinks
	au BufNewFile ~/Notes/vimwiki/diary/*.md :silent 0r !~/.scripts/vim/generate-vimwiki-diary-template '%'
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md :silent $
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md exe "normal!O"
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md :put =strftime('%H:%M')
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md exe "normal!I- "
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md exe "normal!A:  "
	autocmd BufRead Notes/vimwiki/diary/????-??-??.md :star!
augroup end

"
"https://superuser.com/questions/277325/create-a-file-under-the-cursor-in-vim
map <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>
map <leader>Gf :e <cfile><cr>
map <leader>gf :vs <cfile><cr>
map <leader>gF :sp <cfile><cr>
nmap <C-w>f :e <cfile><CR>
nnoremap <C-W><C-F> <C-W>vgf 
"C-WC-F - Edit existing file under cursor in vertically split window
nnoremap <C-a> <C-w>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <silent> <c-_> :wincmd _<CR>

"nnoremap <leader><F8> :call NextColor(1)<CR>
"nnoremap <leader><S-F8> :call NextColor(-1)<CR>
"nnoremap <A-F8> :call NextColor(0)<CR>


vmap ,j !python -m json.tool
com! FormatJSON %!python -m json.tool

command! YTDLP s/[?=]/\\&/g 

"function! MyFormatExpr(start, end)
"silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
"endfunction
"set formatexpr=MyFormatExpr(v:lnum,v:lnum+v:count-1)

function! GotoJump()
	jumps
	let j = input("Please select your jump: ")
	if j != ''
		let pattern = '\v\c^\+'
		if j =~ pattern
			let j = substitute(j, pattern, '', 'g')
			execute "normal " . j . "\<c-i>"
		else
			execute "normal " . j . "\<c-o>"
		endif
	endif
endfunction

function! Synctex()
	" remove 'silent' for debugging
	execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
endfunction
map <C-enter> :call Synctex()<cr>

nnoremap <leader>rs :call neosnippet#variables#set_snippets({})<cr>
nmap <Leader>j :call GotoJump()<CR>
"let g:AutoCentern
" >>>

" <<< Abréviations et raccourcis clavier 
"
" Append modeline after last line in buffer.
" " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" " files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" :Hv to open vertically
command -narg=1 -complete=help H vert help <args>

map <silent> <leader>h <C-w>5<
map <silent> <leader>l <C-w>5>

"function! SmartWidth( width )
"let num_wins = 0
"windo let num_wins+=1
"sil exe "set columns=" . num_wins * a:width
"sil exe "normal! \<c-w>="
"endfunction

"autocmd VimEnter * call SmartWidth(85)
"autocmd WinEnter * call SmartWidth(85)
"

ab ccom /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
ab fcom ! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	ab lcom % * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	ab pcom # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	"let &t_ut=''
"
let @t = '^c2lCcddpkc2lTo'

" help:
" record macro, then paste content of register to get desired sequence
let @r = 'o\Raphael{}l' "latex comments
let @s = 'O\begin{synth}'
let @d = 'o\end{synth}'
let @l = 'o\plan{}li'
let @i = 'o\setlength{\itemsep}{10pt}' "beamer
let @p = 'o\bigskip' "beamer
"let @o = 'oitemize' "beamer
"let @P = 'o\medskip' "beamer
let @m = 'yyPvt{lc% <<< $r ' " latex modeline.
"let @d = 'kO% >>>€ýa'
" FZF
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :History<cr>
nnoremap <leader>fb :BLines<cr>

let g:fzf_action = {
			\ 'ctrl-t': 'edit',
			\ 'ctrl-h': 'split',
			\ 'ctrl-v': 'vsplit',
			\ 'enter': 'vsplit' }
" >>>

nmap <c-j> <c-w>w3<c-e><c-w>w
nmap <c-k> <c-w>w3<c-y><c-w>w

nnoremap <expr> g<c-v> '`[' . getregtype()[0] . '`]'

if argc() == 2
	execute "edit " . argv(0)
	execute "vsplit " . argv(1)
	wincmd =
		endif

"iamcco/markdown-preview.nvim
	" set to 1, nvim will open the preview window after entering the Markdown buffer
	" default: 0
	let g:mkdp_auto_start = 0

	" set to 1, the nvim will auto close current preview window when changing
	" from Markdown buffer to another buffer
	" default: 1
	let g:mkdp_auto_close = 1

	" set to 1, Vim will refresh Markdown when saving the buffer or
	" when leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
	" move the cursor
	" default: 0
	let g:mkdp_refresh_slow = 0

	" set to 1, the MarkdownPreview command can be used for all files,
	" by default it can be use in Markdown files only
	" default: 0
	let g:mkdp_command_for_global = 1

	" set to 1, the preview server is available to others in your network.
	" By default, the server listens on localhost (127.0.0.1)
	" default: 0
	let g:mkdp_open_to_the_world = 0

	" use custom IP to open preview page.
	" Useful when you work in remote Vim and preview on local browser.
	" For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
	" default empty
	let g:mkdp_open_ip = ''

	" specify browser to open preview page
	" for path with space
	" valid: `/path/with\ space/xxx`
	" invalid: `/path/with\\ space/xxx`
	" default: ''
	let g:mkdp_browser = ''

	" set to 1, echo preview page URL in command line when opening preview page
	" default is 0
	let g:mkdp_echo_preview_url = 0

	" a custom Vim function name to open preview page
	" this function will receive URL as param
	" default is empty
	let g:mkdp_browserfunc = ''

	" options for Markdown rendering
	" mkit: markdown-it options for rendering
	" katex: KaTeX options for math
	" uml: markdown-it-plantuml options
	" maid: mermaid options
	" disable_sync_scroll: whether to disable sync scroll, default 0
	" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
	"   middle: means the cursor position is always at the middle of the preview page
	"   top: means the Vim top viewport always shows up at the top of the preview page
	"   relative: means the cursor position is always at relative positon of the preview page
	" hide_yaml_meta: whether to hide YAML metadata, default is 1
	" sequence_diagrams: js-sequence-diagrams options
	" content_editable: if enable content editable for preview page, default: v:false
	" disable_filename: if disable filename header for preview page, default: 0
	let g:mkdp_preview_options = {
				\ 'mkit': {},
				\ 'katex': {},
				\ 'uml': {},
				\ 'maid': {},
				\ 'disable_sync_scroll': 0,
				\ 'sync_scroll_type': 'middle',
				\ 'hide_yaml_meta': 1,
				\ 'sequence_diagrams': {},
				\ 'flowchart_diagrams': {},
				\ 'content_editable': v:false,
				\ 'disable_filename': 0,
				\ 'toc': {}
				\ }

	" use a custom Markdown style. Must be an absolute path
	" like '/Users/username/markdown.css' or expand('~/markdown.css')
	"let g:mkdp_markdown_css = '/home/raph/Notes/style.css'
	"let g:mkdp_markdown_css = '/home/raph/Code/markdown-css-themes/markdown3.css'

	" use a custom highlight style. Must be an absolute path
	" like '/Users/username/highlight.css' or expand('~/highlight.css')
	let g:mkdp_highlight_css = ''

	" use a custom port to start server or empty for random
	let g:mkdp_port = ''

	" preview page title
	" ${name} will be replace with the file name
	let g:mkdp_page_title = '¿${name}¿'

	" use a custom location for images
	let g:mkdp_images_path = '/home/raph/.markdown_images'

	" recognized filetypes
	" these filetypes will have MarkdownPreview... commands
	let g:mkdp_filetypes = ['markdown']

	" set default theme (dark or light)
	" By default the theme is defined according to the preferences of the system
	let g:mkdp_theme = 'light'

	" combine preview window
	" default: 0
	" if enable it will reuse previous opened preview window when you preview markdown file.
	" ensure to set let g:mkdp_auto_close = 0 if you have enable this option
	let g:mkdp_combine_preview = 0

	" auto refetch combine preview contents when change markdown buffer
	" only when g:mkdp_combine_preview is 1
	let g:mkdp_combine_preview_auto_refresh = 1


	" example
	"nmap <C-s> <Plug>MarkdownPreview
	"nmap <M-s> <Plug>MarkdownPreviewStop
	"nmap <C-p> <Plug>MarkdownPreviewToggle
	nmap <leader>mp :MarkdownPreviewToggle<CR>
	"nmap <leader>mp :set ft=markdown<CR> <bar> :MarkdownPreviewToggle<CR>

	let g:gutentags_cache_dir="~/.vimtags"

	autocmd FileType html setlocal foldmethod=indent
	autocmd FileType html setlocal fdl=3

	let g:colors = getcompletion('', 'color')
	func! NextColors()
		let idx = index(g:colors, g:colors_name)
		return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
	endfunc
	func! PrevColors()
		let idx = index(g:colors, g:colors_name)
		return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
	endfunc
	nnoremap <C-n> :exe "colo " .. NextColors()<CR>
	nnoremap <C-p> :exe "colo " .. PrevColors()<CR>

	augroup no_folding_vimrc
		autocmd!
		autocmd BufRead,BufNewFile ~/.vimrc setlocal foldmethod=manual foldenable
	augroup END

	"au BufNewFile ~/.vimwiki/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'
	"au BufNewFile ~/.vimwiki/*.md :silent 0r ~/Templates/template-vimwikipage.mdwn

	" todolist
	"map gg ^rx: <Esc>:r! date +" [\%H:\%M]"<ENTER>kJA<Esc>$
	"" create a new todo item
	"map gt o  _
	"
	function! TLDR() range
		" Get the selected lines
		let lines = getline(a:firstline, a:lastline)
		" Find max length (consider TL;DR: as well)
		let maxlen = max([max(map(copy(lines), 'len(v:val)')), len('TL;DR:')])
		" Build top/bottom border
		let border = '+' . repeat('-', maxlen + 2) . '+'
		" Start boxed lines
		let boxed = [border]
		" Add TL;DR: line
		call add(boxed, '| TL;DR:' . repeat(' ', maxlen - len('TL;DR:')) . ' |')
		" Add content lines
		for l in lines
			call add(boxed, '| ' . l . repeat(' ', maxlen - len(l)) . ' |')
		endfor
		call add(boxed, border)
		" Replace selection
		call setline(a:firstline, boxed)
		if a:lastline > a:firstline
			call deletebufline('', a:firstline+len(boxed), a:lastline+len(boxed)-1)
		endif
	endfunction
	xnoremap <leader>b :<C-u>call TLDR()<CR>

" Show all 256 terminal colors
function! ShowCTermColors()
  let row=0
  for i in range(0, 255)
    let group="Color".i
    execute "highlight ".group." ctermfg=".i
    let col=i%16
    if col==0
      echo ""
      let row+=1
    endif
    echohl Color".i
    echon printf("%3d ", i)
    echohl None
  endfor
  echo ""
endfunction

let g:slime_target = "tmux"

"nnoremap <Leader>* :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>
" search for word in the other split
nnoremap <Leader>* :let @/=expand("<cword>")<Bar>wincmd w<Bar>normal n<CR>

" meme chose en visuel
xnoremap <Leader>* "vy:let @/ = escape(@v, '/\')<Bar>wincmd w<Bar>normal n<CR>

nnoremap <Leader>hW :s/width/height/g
nnoremap <Leader>hw :s/height/width/g

let g:drafts_directory = "/home/raph/.drafts/"
" NewDraft Keybind
nnoremap <Leader>nd :call NewDraft()<CR>
" ListDrafts Keybind
nnoremap <Leader>ld :call ListDrafts()<CR>
" OpenDrafts Keybind
nnoremap <Leader>nz :call OpenDrafts()<CR>

command! EmailCopy let @" = matchstr(getline('.'), '<\zs[^>]\+')

"let g:markdown_folding = 1
let g:vim_markdown_folding_level = 2
"set foldtext=getline(v:foldstart).'////...'

" Move last screenshot from ~/Images/Screenshots to ./figures using visual selection
function! MoveLastScreenshot() range
  " Get filename from visual selection
  "let l:newname = join(getline("'<","'>"), "")
  "let l:newname = trim(l:newname)
  let l:newname = trim(getreg('"'))

  " Hardcoded paths
  let l:src = expand('~/Images/Screenshots')
  let l:dst = getcwd() . '/figures'

  " Most recent file in screenshot folder
  let l:lastfile = systemlist('ls -t ' . shellescape(l:src) . ' | head -n1')[0]

  if empty(l:lastfile)
    echo "No screenshots found in " . l:src
    return
  endif

  " Full paths
  let l:srcpath = l:src . '/' . l:lastfile
  let l:dstpath = l:dst . '/' . l:newname

  " Check if destination file already exists
  if filereadable(l:dstpath)
    echohl ErrorMsg
    echo "Destination file already exists: " . l:dstpath
    echohl None
    return
	endif

  " Move & rename
  call system('mv ' . shellescape(l:srcpath) . ' ' . shellescape(l:dstpath))

  echo "Moved " . l:srcpath . " -> " . l:dstpath
endfunction

command! -range MoveLastScreenshot <line1>,<line2>call MoveLastScreenshot()

" beamer itemize
" prend des lignes visuellement surlignées et transforme en liste beamer
vnoremap ,bi :s/^\s*\(.*\)/  \\item \1/<CR>gv<Esc>'<O\begin{itemize}<Esc>'>o\end{itemize}<Esc>
" même chose pour une ligne transformée en titre de frame
vnoremap ,bt :s/^\s*\(.*\)/  \\begin{frame}{ \1/<CR>A}<Esc>O\end{frame}<Esc>

" Highlight the markers in bright colors
match ErrorMsg /^\(<\{7\}\|=\{7\}\|>\{7\}\).*/

" Correct typos in insert mode.  Copied from <https://castel.dev/post/lecture-notes-1/>.
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u

" vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
