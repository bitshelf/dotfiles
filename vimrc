"set runtimepath-=$ConfigFolder/.vim
"    \ runtimepath^=$ConfigFolder/.local/share/nvim/site runtimepath^=$ConfigFolder/.vim
"    \ runtimepath-=$ConfigFolder/.vim/after
"    \ runtimepath+=$ConfigFolder/.local/share/nvim/site/after runtimepath+=$ConfigFolder/.vim/after
"let &packpath = &runtimepath
" set runtimepath=$ConfigFolder/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$ConfigFolder/.vim/after
" set packpath=$ConfigFolder/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$ConfigFolder/.vim/after

if exists('$VIM_TERMINAL')
  echoerr 'Do not run Vim inside a Vim terminal'
  quit
endif

if has('autocmd')
  " 为了可以重新执行 vimrc，开头先清除当前组的自动命令
  au!
endif

if has('gui_running')
  " 下面两行仅为占位使用；请填入你自己的字体
  set guifont='CaskaydiaCove Nerd Font Mono'
  set guifontwide='CaskaydiaCove Nerd Font Mono'

  " 不延迟加载菜单（需要放在下面的 source 语句之前）
  let do_syntax_sel_menu = 1
  let do_no_lazyload_menus = 1
endif

if !has('nvim')
  source $VIMRUNTIME/vimrc_example.vim
endif

" 启用 man 插件
source $VIMRUNTIME/ftplugin/man.vim

set enc=utf-8
"set autochdir
set fileencodings=ucs-bom,utf-8,gb18030,latin1
set formatoptions+=mM
set keywordprg=:Man
set scrolloff=1
set spelllang+=cjk
" set tags=./kernel/tags,./tags;,tags,/usr/local/etc/systags
set path=./**
set nobackup
set hidden
set signcolumn=yes

" tab key
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

if v:version >= 900
  set wildoptions=pum
  colorscheme habamax
endif

if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
  endif
endif

if has('mouse')
  if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
    set mouse=v
  else
    "set mouse=nvi
    set mouse=v
  endif
endif

if !has('gui_running')
  " 设置文本菜单
  if has('wildmenu')
    set wildmenu
    set cpoptions-=<
    set wildcharm=<C-Z>
    nnoremap <F10>      :emenu <C-Z>
    inoremap <F10> <C-O>:emenu <C-Z>
  endif

  " 识别终端的真彩支持
  if has('termguicolors') &&
        \($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
    set termguicolors
  endif
endif

call plug#begin()
  " Make sure you use single quotes

  " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
  Plug 'junegunn/vim-easy-align'

  " Any valid git URL is allowed
  Plug 'https://github.com/junegunn/vim-github-dashboard.git'

  " Multiple Plug commands can be written in a single line using | separators
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " On-demand loading
  Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
  " Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

  " Using a non-default branch
  Plug 'ycm-core/YouCompleteMe'
  "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

  " customs
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  "Plug 'liuchengxu/vista.vim'
  Plug 'majutsushi/tagbar'
  Plug 'mbbill/undotree'
  Plug 'mg979/vim-visual-multi'
  Plug 'preservim/nerdcommenter'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/SyntaxAttr.vim'
  Plug 'yegappan/mru'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"
"   command
"   PlugInstall: Install plugins
"   PlugUpdate: Install or update plugins
"   PlugUpgrade: Upgrade vim-plug itself


" Tagbar
nmap <Leader>tb :TagbarToggle<CR>
" 自动打开 Tagbar 侧边栏
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "
nnoremap <F9>      :TagbarToggle<CR>
inoremap <F9> <C-O>:TagbarToggle<CR>

" cscope
nmap <C-x>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-x>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-x>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-x>a :cs find a <C-R>=expand("<cword>")<CR><CR>

if has("cscope")
      "set csprg=/usr/bin/cscope
      set csto=0
      set cst
      set nocsverb
      set cspc=3

      if filereadable(expand('%'))
        exe 'cd'  expand('%:h')
        set tags=./tags;,tags,/usr/local/etc/systags
        let cscope_file=findfile("cscope.out", ".;")
        let cscope_pre=matchstr(cscope_file, ".*/")
        "let clangd_file=findfile("compile_commands.json", ".;")
        exe 'cd' '-'

        if !empty(cscope_file) && filereadable(cscope_file)
             exe "cs add" cscope_file cscope_pre
        endif

        "if !empty(clangd_file) 
        "    let g:ycm_clangd_args=clangd_file
        "endif
       elseif filereadable("cscope.out")
           cs add cscope.out
           set tags=./tags;,tags,/usr/local/etc/systags
       "else search cscope.out elsewhere
       elseif $CSCOPE_DB != ""
          cs add $CSCOPE_DB
          set tags=./tags;,tags,/usr/local/etc/systags
       endif

endif

"set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

" 修改光标上下键一次移动一个屏幕行
nnoremap <Up>        gk
inoremap <Up>   <C-O>gk
nnoremap <Down>      gj
inoremap <Down> <C-O>gj

" 切换窗口的键映射
" nnoremap <C-Tab>   <C-W>w
" inoremap <C-Tab>   <C-O><C-W>w
" nnoremap <C-S-Tab> <C-W>W
" inoremap <C-S-Tab> <C-O><C-W>W

" Nerdtree
" nnoremap <C-S-e> :exec 'NERDTreeToggle' <CR>
nnoremap <C-S-e> :NERDTreeToggle <CR>

" Vista
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista_default_executive = 'ctags'
"let g:vista_fzf_preview = ['right:50%']
"let g:vista_executive_for = {
"  \ 'cpp': 'vim_lsp',
"  \ }


" 检查光标下字符的语法属性的键映射
nnoremap <Leader>a :call SyntaxAttr()<CR>
if has('unix') && !has('gui_running')
  " Unix 终端下使用两下 Esc 来离开终端作业模式
  tnoremap <Esc><Esc> <C-\><C-N>
else
  " 其他环境则使用 Esc 来离开终端作业模式
  tnoremap <Esc>      <C-\><C-N>
  tnoremap <C-V><Esc> <Esc>
endif


" 自定义快捷键
nnoremap <silent> <C-P> :GFiles<CR>
nnoremap <C-`> :term ++rows=7<CR>
nnoremap <C-j> :term ++rows=7<CR>
set splitbelow
set splitright

" 停止搜索高亮的键映射
nnoremap <silent> <F2>      :nohlsearch<CR>
inoremap <silent> <F2> <C-O>:nohlsearch<CR>

" vim-powered terminal in split window
map <Leader>te :term ++close<cr>
tmap <Leader>te <c-w>:term ++close<cr>

" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>
tmap <Leader>T <c-w>:tab term ++close<cr>

"---------------alrLine Config--------------
"Windows Ubuntu airline乱码
"安装power-line字体
"sudo apt-get install fonts-powerline
  " status bar colors
  let g:airline_theme="jellybeans"
  let g:airline_powerline_fonts = 1  " 如没有安装合适的字体，则应置成 0
  let g:airline#extensions#tabline#enabled = 1 "允许修改默认Tab样式
  let g:airline#extensions#tabline#buffer_nr_show = 0 "buffer显示编号
  let g:airline#extensions#tabline#overflow_marker = '…'
  let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#tabline#show_close_button = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let w:airline_skip_empty_sections              = 1
  "let g:airline_section_b                        = '%{fugitive#head()}'
  let g:airline_section_c                        = ''
  let g:airline_section_x                        = '%{&filetype}'
  "let g:airline_section_warning                  = ''

  if !exists('g:airline_symbols')
          let g:airline_symbols = {}
  endif

  let g:airline_symbols.space = "\ua0"
  let g:airline_exclude_filename = []
  let g:Powerline_symbols='fancy'
  let Powerline_symbols='fancy'
  let g:airline_powerline_fonts = 1 " 使用powerline打过补丁的字体
  let g:bufferline_echo=0
  set laststatus=2 " 永远显示状态栏
  set t_Co=256
  set fillchars+=stl:\ ,stlnc:\


"  let g:c_space_errors = 1 " hightlight space
"  let g:c_gnu = 1
"  let g:c_no_cformat = 1
"  let g:c_no_curly_error = 1
"  if exists('g:c_comment_strings')
"    unlet g:c_comment_strings
"  endif

if has('autocmd')
  function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
  endfunction

" 用于 YouCompleteMe 的设定
  let g:ycm_enable_diagnostic_highlighting = 0
  let g:ycm_enable_diagnostic_signs = 0
  let g:ycm_show_diagnostics_ui = 0

  let g:ycm_auto_hover = ''
  let g:ycm_complete_in_comments = 1
  let g:ycm_filetype_whitelist = {
        \ 'c': 1,
        \ 'dts': 1,
        \ 'cpp': 1,
        \ 'java': 1,
        \ 'python': 1,
        \ 'vim': 1,
        \ 'sh': 1,
        \ }

  " auto completion
  let g:ycm_semantic_triggers =  {
   \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
   \ 'cs,lua,javascript': ['re!\w{2}'],
   \ }

  let g:ycm_goto_buffer_command = 'split-or-existing-window'
  let g:ycm_key_invoke_completion = '<C-Z>'
  let g:ycm_use_clangd = 1
  let g:ycm_show_diagnostics_ui = 0
  "nnoremap <Leader>gd :YcmCompleter GoToDefinition<CR>
  nnoremap <Leader>fi :YcmCompleter FixIt<CR>
  nnoremap gt :YcmCompleter GoTo<CR>
  nnoremap gd :YcmCompleter GoToDefinition<CR>
  nnoremap gh :YcmCompleter GoToDeclaration<CR>
  nnoremap gr :YcmCompleter GoToReferences<CR>

  "Toggle YouCompleteMe on and off with <leader>gf
  function Toggle_ycm()
      if g:ycm_show_diagnostics_ui == 0
          let g:ycm_auto_trigger = 1
          let g:ycm_show_diagnostics_ui = 1
          let g:ycm_enable_diagnostic_highlighting = 1
          let g:ycm_enable_diagnostic_signs = 1
          :YcmRestartServer
          :e
          :echo "YCM on"
      elseif g:ycm_show_diagnostics_ui == 1
          let g:ycm_auto_trigger = 0
          let g:ycm_show_diagnostics_ui = 0
          :YcmRestartServer
          :e
          :echo "YCM off"
      endif
  endfunction
  nnoremap <silent> <leader>go :call Toggle_ycm() <CR>

  au FileType c,cpp,objc  setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 cinoptions=:0,g0,(0,w1
  au FileType json        setlocal expandtab shiftwidth=2 softtabstop=2
  au FileType vim         setlocal expandtab shiftwidth=2 softtabstop=2

  au FileType help        nnoremap <buffer> q <C-W>c

" au BufRead /usr/include/*  call GnuIndent()
endif

" fzf vim setting
" set rtp+=~/.fzf " setting use which fzf
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_preview_window = []
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


"" 关闭 airline status bar colors
"au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
"au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
"hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
"
"" Status line
"" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
"
"" Status Line Custom
"let g:currentmode={
"    \ 'n'  : 'Normal',
"    \ 'no' : 'Normal·Operator Pending',
"    \ 'v'  : 'Visual',
"    \ 'V'  : 'V·Line',
"    \ '^V' : 'V·Block',
"    \ 's'  : 'Select',
"    \ 'S'  : 'S·Line',
"    \ '^S' : 'S·Block',
"    \ 'i'  : 'Insert',
"    \ 'R'  : 'Replace',
"    \ 'Rv' : 'V·Replace',
"    \ 'c'  : 'Command',
"    \ 'cv' : 'Vim Ex',
"    \ 'ce' : 'Ex',
"    \ 'r'  : 'Prompt',
"    \ 'rm' : 'More',
"    \ 'r?' : 'Confirm',
"    \ '!'  : 'Shell',
"    \ 't'  : 'Terminal'
"    \}
"
"set laststatus=2
"set noshowmode
"set statusline=
""set statusline+=%0*\ %n\                                 " Buffer number
"set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode
"" set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
"set statusline+=%3*│                                     " Separator
""set statusline+=%2*\ %Y\                                 " FileType
"set statusline+=%3*│                                     " Separator
""set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
"set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
"set statusline+=%=                                       " Right Side
"set statusline+=%2*\ col:\ %02v\                         " Colomn number
"set statusline+=%3*│                                     " Separator
"set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document
"
"hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
"hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
"hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
"hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e
