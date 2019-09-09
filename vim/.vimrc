"| vim : set fdm=marker:fmr=<<<,>>>:fdl=0:

" <<< Vundle configuration
set shell=/bin/bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" indispensables
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/loremipsum'
Plugin 'Rykka/colorv.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
"Plugin 'jnurmine/Zenburn'
Bundle 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'mattn/calendar-vim'
Plugin 'dylanaraps/wal.vim'
Plugin 'honza/vim-snippets'
"Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ervandew/supertab'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'lervag/vimtex'
Plugin 'vim-scripts/mutt-canned'

Bundle 'scrooloose/syntastic'
Bundle 'mbbill/undotree'
Bundle 'nathanaelkane/vim-indent-guides'
Plugin 'mhinz/vim-signify'
Plugin 'osyo-manga/vim-over'

Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'

Plugin 'altercation/vim-colors-solarized.git'
Bundle 'flazz/vim-colorschemes'
Plugin 'luochen1990/rainbow'

Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-fugitive'

"Bundle 'klen/python-mode'
"Bundle 'yssource/python.vim'
"Bundle 'python_match.vim'
"Bundle 'pythoncomplete'

let g:ip_boundary='-\?\s*$'
let g:tex_flavor = 'latex'
"let g:polyglot_disabled = ['latex']

"Plugin 'L9'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" >>>

" <<< Automatic rules for filetypes
augroup LATEX
au BufRead *tex nmap Q gqap
"  au BufRead ~/.mutt/temp/mutt* map!  <F5>  <ESC>kgqji
augroup END

augroup WrapLineInTeXFile
  autocmd!
  autocmd FileType tex setlocal wrap linebreak nolist
  autocmd FileType tex setlocal showbreak=+++
augroup END

set spelllang=fr

augroup MUTT
au BufRead ~/.mutt/temp/*mutt* set spell " <-- vim 7 required
au BufRead ~/.mutt/temp/*mutt* set nonu
au BufRead ~/.mutt/temp/*mutt* nmap  <F5>  gqap
au BufRead ~/.mutt/temp/*mutt* nmap  <F6>  gqqj
au BufRead ~/.mutt/temp/*mutt* nmap  <F7>  kgqj
au BufRead ~/.mutt/temp/*mutt* map!  <F5>  <ESC>gqapi
au BufRead ~/.mutt/temp/*mutt* map!  <F6>  <ESC>gqqji
au BufRead ~/.mutt/temp/*mutt* map!  <F7>  <ESC>kgqji
"au BufRead ~/.mutt/temp/*mutt* setlocal fo+=aw

au BufRead ~/.mutt/temp/mutt* source ~/.vim/bundle/mutt-canned/plugin/mutt-canned.vim
"au BufRead ./example.file source ./mutt-canned.vim
augroup END

au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
" >>>

" <<< Bindings
let mapleader = ","

map ,nu :set invnumber<CR>
map ,nr :set invrelativenumber<CR>
map ,no :set nonumber<CR>
" instead of :nohlsearch<CR> :
map ,nh :set invhlsearch<CR> 
map ,ns :set nospell<CR>
map ,fr :setlocal spell spelllang=fr<CR>
map ,en :setlocal spell spelllang=en<CR>
map ,fe :setlocal spell spelllang=en,fr<CR>
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" decompte de mots latex
map ,wc :w !detex \| wc -w<CR>
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" permet de ne pas retaper les longs chemins
map ,ed :e <C-R>=expand("%:p:h") . "/" <CR>
"
inoremap kj <Esc>
"makes K split lines (the opposite of J)
nnoremap K i<cr><esc>k$ 
nnoremap Q gqip
nnoremap <tab> %
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
let g:lasttab = 1
nmap <Leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" « v,d » et « v,s » lancent firefox et une recherche (définition ou synonyme) dans le tlfi sur le mot courant
vmap ,d :<C-U>!luakit "http://www.cnrtl.fr/lexicographie/<cword>" >& /dev/null<CR><CR>
vmap ,s :<C-U>!luakit "http://www.cnrtl.fr/synonymie/<cword>" >& /dev/null<CR><CR>
" « v,g » comme ci-dessus mais pour google
vmap ,g :<C-U>!luakit "http://www.google.fr/search?hl=fr&q=<cword>&btnG=Recherche+Google&meta=" >& /dev/null<CR><CR>
"« v,w » comme ci-dessus mais pour wikipedia
vmap ,w :<C-U>!luakit "http://fr.wikipedia.org/wiki/<cword>" >& /dev/null<CR><CR>
" « v,c » comme ci-dessus mais pour le conjugueur
vmap ,cv :<C-U>!luakit "http://www.leconjugueur.com/php5/index.php?v=<cword>" >& /dev/null<CR><CR>
" « v,o » ouvre l’url sur laquelle on se trouve dans firefox
vmap ,o :<C-U>!firefox "<cfile>" >& /dev/null<CR><CR>
"vimbits
" search word in center of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
imap <C-b> <Plug>Tex_MathBF
imap <C-c> <Plug>Tex_MathCal
imap <C-l> <Plug>Tex_LeftRight
" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Use gc to swap the current character with the next, without changing the cursor position.
nnoremap <silent> gc xph
" Use gw to swap the current word with the next, without changing cursor position.
nnoremap <silent> gw "_yiw:s/\(\%#[0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\(\_[^0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\([0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<return>
" Use Alt + ← to swap the current word with the previous, keeping cursor on current word. This feels like "pushing" the word to the left.
nnoremap <silent> <A-Left> "_yiw?[0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\_[^0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\%#<CR>:s/\(\%#[0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\(\_[^0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\([0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<return>
" Use Alt + → to swap the current word with the next, keeping cursor on current word. This feels like "pushing" the word to the right.
nnoremap <silent> <A-Right> "_yiw:s/\(\%#[0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\(\_[^0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)\([0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\)/\3\2\1/<CR><c-o>/[0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+\_[^0-9A-Za-zÀ-ÖØ-öø-ÿ_\-]\+<CR><c-l>:nohlsearch<return>
" Use g{ to swap the current paragraph with the next.
nnoremap g{ {dap}p{
">>>

" <<< Colors 
"set t_Co=256
"let g:zenburn_force_dark_Background = 1
"
"let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
colors zenburn

"colorscheme wal

"set background=dark
"set background=light
"colorscheme solarized
">>>

" <<< Editor Options
set textwidth=80
set colorcolumn=80
set linebreak " avoid cutting words
set wrap
set columns=86
set numberwidth=6
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
" nbsp affiches par '·'
"set list
"set listchars=tab:>·,trail:·,extends:#,nbsp:·
highlight NbSp ctermbg=lightred guibg=lightred
match NbSp /\%xa0/
"set rnu " number
"set nu " number
set ruler
" paste mode
set pastetoggle=<F11>
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
" highlight
set hlsearch
"set scrolloff=999
set scrolloff=8
" use tabs as spaces
set expandtab
set sw=2
set ts=2
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
"set ttymouse=urxvt
set foldmethod=indent
set foldlevelstart=99
"set foldlevel=99
" completion
set wildmenu
set wildmode=list:longest,full

"if &term == "screen-256color"
  "let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
  "set t_ts=k
  "set t_fs=\
"endif
"set title

" >>>

" <<< Plugins Options
nnoremap <silent> <leader>gg :SignifyToggle<CR>
let g:airline_theme='luna'
" taglist
let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
set iskeyword=@,48-57,_,-,:,192-255
"nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>

let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'

let g:polyglot_disabled = ['latex']

let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1

let g:tagbar_autofocus=1
let g:tagbar_compact = 1
let g:tagbar_indent = 1
"let g:tagbar_width = 30
let g:tagbar_autoclose = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds' : [
                \ 's:sections',
                \ 'f:frames',
                \ 'g:graphics:0:0'
            \ ],
            \ 'sort' : 0,
        \ }
let g:tagbar_type_rst = {
    \ 'ctagstype': 'rst',
    \ 'ctagsbin' : '/home/raph/scripts/rst2ctags/rst2ctags.py',
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
      \ 'ctagstype' : 'markdown',
      \ 'kinds' : [
          \ 'h:headings'
      \ ],
  \ 'sort' : 0,
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

" lazy scrolling
"noremap <BS> <PageUp>
"noremap <Space> <PageDown>
filetype detect
set viminfo='1000,f1

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
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

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

nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1

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
        nnoremap <leader>o :CtrlPMRU<CR>
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


">>>

" <<< Misc

au BufNewFile,BufRead *.plt,*.gnuplot,*.plot setf gnuplot
autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks  setfiletype task
autocmd BufNewFile,BufRead *.mdwn  setfiletype markdown
autocmd BufNewFile,BufRead *.md  setfiletype markdown

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
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_force_overwrite_completefunc = 1

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
if exists('g:spf13_noninvasive_completion')
    inoremap <CR> <CR>
    " <ESC> takes you out of insert mode
    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
    " <CR> accepts first, then sends the <CR>
    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    " <Down> and <Up> cycle like <Tab> and <S-Tab>
    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
    " Jump up and down the list
    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
else
    imap <silent><expr><C-k> neosnippet#expandable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    "inoremap <expr><CR> neocomplcache#complete_common_string()

    function! CleverCr()
        if pumvisible()
            if neosnippet#expandable()
                let exp = "\<Plug>(neosnippet_expand)"
                return exp . neocomplcache#close_popup()
            else
                return neocomplcache#close_popup()
            endif
        else
            return "\<CR>"
        endif
    endfunction

    " <CR> close popup and save indent or expand snippet
    imap <expr> <CR> CleverCr()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
    "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
endif
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" }

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
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
let g:vimwiki_list = [{'path': '~/vimwiki/', 'path_html': '~/public_html/vimwiki', 'ext': '.md', 'syntax': 'markdown'},  
            \ {'path': '~/meetings/', 'ext': '.md', 'syntax': 'markdown'}]


" a function to execute formd and return the cursor back
" to it's original position within the buffer. 
" dr bunsen

function! Formd(option)
    :let save_view = winsaveview()
    :let flag = a:option
    :if flag == "-r"
        :%! /usr/bin/formd.py -r
    :elseif flag == "-i"
        :%! /usr/bin/formd.py -i
    :else
        :%! /usr/bin/formd.py -f
    :endif
    :call winrestview(save_view)
endfunction

" formd mappings

"function! ToggleCalendar()
  "execute ":Calendar"
  "if exists("g:calendar_open")
    "if g:calendar_open == 1
      "execute "q"
      "unlet g:calendar_open
    "else
      "g:calendar_open = 1
    "end
  "else
    "let g:calendar_open = 1
  "end
"endfunction
":autocmd FileType vimwiki map c :call ToggleCalendar()
" https://superuser.com/questions/277325/create-a-file-under-the-cursor-in-vim
map <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>
map <leader>gf :e <cfile><cr>
nmap <C-w>f :e <cfile><CR>
nnoremap <C-a> <C-w>

nnoremap <leader><F8> :call NextColor(1)<CR>
nnoremap <leader><S-F8> :call NextColor(-1)<CR>
"nnoremap <A-F8> :call NextColor(0)<CR>

autocmd BufNewFile,BufRead *.md   setfiletype=markdown

vmap ,j !python -m json.tool
com! FormatJSON %!python -m json.tool

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

" --------------------------------------------------------------------
"  ABBREVIATIONS ET RACCOURCIS CLAVIER:
" --------------------------------------------------------------------
ab ccom /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
ab fcom ! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
ab lcom % * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
ab pcom # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

" background transparent
hi Normal guibg=NONE ctermbg=NONE
"let &t_ut=''

" vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
