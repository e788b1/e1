" ############################################################ Plug start
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" ============================================================ 基础
Plug 'scrooloose/syntastic'            " 多语言语法检查
    let g:syntastic_error_symbol='>>'
    let g:syntastic_warning_symbol='>'
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_enable_highlighting=1
    let g:syntastic_python_checkers=['pyflakes', 'pep8']
    " error code: http://pep8.readthedocs.org/en/latest/intro.html#error-codes
    let g:syntastic_python_pep8_args='--ignore=E501,E225'
    let g:syntastic_javascript_checkers = ['jsl', 'jshint']
    let g:syntastic_html_checkers=['tidy', 'jshint']
    " 修改高亮的背景色, 适应主题
    highlight SyntasticErrorSign guifg=white guibg=black

    " to see error location list
    let g:syntastic_always_populate_loc_list = 0
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_loc_list_height = 5

    function! ToggleErrors()
        let old_last_winnr = winnr('$')
        lclose
        if old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            Errors
        endif
    endfunction
    nnoremap <Leader>s :call ToggleErrors()<cr>
    " nnoremap <Leader>sn :lnext<cr>
    " nnoremap <Leader>sp :lprevious<cr>

" ============================================================ 自动补全
" Plug 'Valloric/YouCompleteMe'
    "youcompleteme  默认tab  s-tab 和自动补全冲突
    "let g:ycm_key_list_select_completion=['<c-n>']
    " let g:ycm_key_list_select_completion = ['<Down>']
    " "let g:ycm_key_list_previous_completion=['<c-p>']
    " let g:ycm_key_list_previous_completion = ['<Up>']
    " let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
    " let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
    " let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
    " let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
    " let g:ycm_collect_identifiers_from_tags_files = 1
    " " 开启语法关键字补全
    " let g:ycm_seed_identifiers_with_syntax=1

    " "let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开

    " " 跳转到定义处, 分屏打开
    " let g:ycm_goto_buffer_command = 'horizontal-split'
    " " nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
    " nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

    " " 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
    " " old version
    " if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
        " let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
    " endif
    " " new version
    " if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
        " let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    " endif

    " " 直接触发自动补全 insert模式下
    " " let g:ycm_key_invoke_completion = '<C-Space>'
    " " 黑名单,不启用
    " let g:ycm_filetype_blacklist = {
        " \ 'tagbar' : 1,
        " \ 'gitcommit' : 1,
        " \}

" Plug 'SirVer/ultisnips' " 代码片段快速插入 (snippets中,是代码片段资源,需要学习)
    " Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger       = "<tab>"
    let g:UltiSnipsJumpForwardTrigger  = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
    let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
    " 定义存放代码片段的文件夹 .vim/UltiSnips下，使用自定义和默认的，将会的到全局，有冲突的会提示
    " 进入对应filetype的snippets进行编辑
    map <leader>us :UltiSnipsEdit<CR>

    " ctrl+j/k 进行选择
    func! g:JInYCM()
        if pumvisible()
            return "\<C-n>"
        else
            return "\<c-j>"
        endif
    endfunction

    func! g:KInYCM()
        if pumvisible()
            return "\<C-p>"
        else
            return "\<c-k>"
        endif
    endfunction
    inoremap <c-j> <c-r>=g:JInYCM()<cr>
    au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwordTrigger . " <C-R>=g:KInYCM()<cr>"
    let g:UltiSnipsJumpBackwordTrigger = "<c-k>"

Plug 'Raimondi/delimitMate'                       " 自动补全单引号，双引号等
    "" for python docstring ",优化输入
    au FileType python let b:delimitMate_nesting_quotes = ['"']

Plug 'docunext/closetag.vim'                      " 自动补全html/xml标签
    let g:closetag_html_style=1

Plug 'scrooloose/nerdcommenter'                   "  快速注释 ,cc ,cu ,c<Space>
    let g:NERDSpaceDelims=1


Plug 'tpope/vim-repeat'                            " . to repeat command
Plug 'tpope/vim-surround'                          " > 快速加入修改环绕字符
                " cs"'
                " "Hello world!" -> 'Hello world!'
                " ds"
                " "Hello world!" -> Hello world!
                " ysiw"
                " Hello -> "Hello"
                " yss"
                " Hello world -> "Hello world"
                " cst"
                " <a>abc</a>  -> "abc"
                " ys$" 当前到行尾, 引号引住

Plug 'bronson/vim-trailing-whitespace'         " > 快速去行尾空格 [, + <Space>]
    map <leader><space> :FixWhitespace<cr>

Plug 'junegunn/vim-easy-align'                     " > 快速赋值语句对齐,a[key]
    vmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)
    if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
    endif
    let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" ============================================================ 快速移动

Plug 'Lokaltog/vim-easymotion'                     " > 更高效的移动  [,, + w/fx]
    let g:EasyMotion_smartcase = 1
    " let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
    map <Leader><leader>h <Plug>(easymotion-linebackward)
    map <Leader><Leader>j <Plug>(easymotion-j)
    map <Leader><Leader>k <Plug>(easymotion-k)
    map <Leader><leader>l <Plug>(easymotion-lineforward)
    map <Leader><leader>. <Plug>(easymotion-repeat)

Plug 'vim-scripts/matchit.zip'
Plug 'kshenoy/vim-signature'                  "mark {m[a-Z], '[a-Z], m<Space>}
    " m[a-zA-Z] add mark
    " '[a-zA-Z] go to mark
    " m<Space>  del all marks

" ============================================================ 文本对象

" Plug 'kana/vim-textobj-user'               " 支持自定义文本对象
" Plug 'kana/vim-textobj-line'                   " 增加行文本对象: l   dal yal cil
" Plug 'kana/vim-textobj-entire'             " 增加文件文本对象: e   dae yae cie
" Plug 'kana/vim-textobj-indent' " 增加缩进文本对象: i   dai yai cii - 相同缩进属于同一块

" ============================================================ 快速选中
Plug 'terryma/vim-expand-region'           " > 选中区块               [+ -]
"     map + <Plug>(expand_region_expand)
"     map _ <Plug>(expand_region_shrink)
    vmap v <Plug>(expand_region_expand)
    vmap V <Plug>(expand_region_shrink)

Plug 'terryma/vim-multiple-cursors' " > 多光标选中编辑              [C-m/p/x]
    let g:multi_cursor_use_default_mapping=0
    " Default mapping
    let g:multi_cursor_next_key='<C-m>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

" ============================================================ 显示增强
Plug 'bling/vim-airline'               " > 状态栏增强展示
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_powerline_fonts = 1
    " let g:airline_left_sep = '▶'
    " let g:airline_left_alt_sep = '❯'
    " let g:airline_right_sep = '◀'
    " let g:airline_right_alt_sep = '❮'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.branch = '⎇'
    " 是否打开tabline
    " let g:airline#extensions#tabline#enabled = 1

Plug 'kien/rainbow_parentheses.vim'        " > 括号显示增强
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
    let g:rbpt_max = 40
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

" ============================================================ 功能相关
Plug 'ctrlpvim/ctrlp.vim' " >                      文件搜索              [,p]
    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_cmd = 'CtrlP'
    map <leader>f :CtrlPMRU<CR>
    "set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
        \ }
    "\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_match_window_bottom=1
    let g:ctrlp_max_height=15
    let g:ctrlp_match_window_reversed=0
    let g:ctrlp_mruf_max=500
    let g:ctrlp_follow_symlinks=1
    " 如果安装了ag, 使用ag
    if executable('ag')
        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    endif

Plug 'tacahiroy/ctrlp-funky'              "不用ctag进行函数快速跳转 <Leader>fu/U
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    let g:ctrlp_funky_syntax_highlight = 1

    let g:ctrlp_extensions = ['funky']

Plug 'dyng/ctrlsf.vim'
    " In CtrlSF window:
    " 回车/o, 打开
    " t       在tab中打开(建议)
    " T - Lkie t but focus CtrlSF window instead of opened new tab.
    " q - Quit CtrlSF window.
    nmap \ <Plug>CtrlSFCwordPath<CR>
    " let g:ctrlsf_position = 'below'
    " let g:ctrlsf_winsize = '30%'
    let g:ctrlsf_auto_close = 0

Plug 'tpope/vim-fugitive' "git操作还是习惯命令行,vim里面处理简单diff编辑操作
    ":Gdiff  :Gstatus :Gvsplit
    nnoremap <leader>ge :Gdiff<CR>
    " not ready to open
    " <leader>gb maps to :Gblame<CR>
    " <leader>gs maps to :Gstatus<CR>
    " <leader>gd maps to :Gdiff<CR>  和现有冲突
    " <leader>gl maps to :Glog<CR>
    " <leader>gc maps to :Gcommit<CR>
    " <leader>gp maps to :Git push<CR>

Plug 'airblade/vim-gitgutter'                  " 同git diff, 默认关闭     [gs]
    let g:gitgutter_map_keys = 0
    let g:gitgutter_enabled = 0
    let g:gitgutter_highlight_lines = 1
    nnoremap <leader>gs :GitGutterToggle<CR>


Plug 'sjl/gundo.vim'           " edit history, 可以查看回到某个历史状态  [,h]
    nnoremap <leader>h :GundoToggle<CR>

" ============================================================ 快速导航
Plug 'scrooloose/nerdtree'                     " > 目录导航              [,n]
Plug 'jistr/vim-nerdtree-tabs'
    map <leader>n :NERDTreeToggle<CR>
    " let NERDTreeHighlightCursorline=1
    " let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
    " "let NERDTreeDirArrows=0
    " "let g:netrw_home='~/bak'
    " "close vim if the only window left open is a NERDTree
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
    " " s/v 分屏打开文件
    " let g:NERDTreeMapOpenSplit = 's'
    " let g:NERDTreeMapOpenVSplit = 'v'
    " map <Leader>n <plug>NERDTreeTabsToggle<CR>
    " " 关闭同步
    " let g:nerdtree_tabs_synchronize_view=0
    " let g:nerdtree_tabs_synchronize_focus=0
    " " 自动开启nerdtree
    " let g:nerdtree_tabs_open_on_console_startup=1

Plug 'szw/vim-ctrlspace'
    let g:airline_exclude_preview = 1
    hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold
    hi CtrlSpaceNormal   guifg=#839496 guibg=#021B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
    hi CtrlSpaceSearch   guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
    hi CtrlSpaceStatus   guifg=#839496 guibg=#002b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8

Plug 'majutsushi/tagbar'           " > 标签导航                           [F9]
    nmap <F9> :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
    " for ruby
    let g:tagbar_type_ruby = {
        \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'f:methods',
            \ 'F:singleton methods'
        \ ]
    \ }

" ============================================================ Theme
Plug 'tomasr/molokai'
    let g:molokai_original = 1
    let g:rehash256 = 1

Plug 'altercation/vim-colors-solarized'
    " let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"

" =========================================================== Python

" Plug 'thinca/vim-quickrun'
    " let g:quickrun_config = {
    " \   "_" : {
    " \       "outputter" : "message",
    " \   },
    " \}

    " let g:quickrun_no_default_key_mappings = 1
    " nmap <Leader>r <Plug>(quickrun)
    " map <F10> :QuickRun<CR>


" for python.vim syntax highlight
" Plug 'hdima/python-syntax'
" Plug 'hynek/vim-python-pep8-indent'
" Plug 'Glench/Vim-Jinja2-Syntax'
" let python_highlight_all = 1

" ============================================================ Markdown
" Plug 'plasticboy/vim-markdown'
    " let g:vim_markdown_folding_disabled=1

" ============================================================ javascript

" for javascript  注意: syntax这个插件要放前面
" Plug 'othree/yajs.vim'
" Plug 'pangloss/vim-javascript'
    " let g:html_indent_inctags = "html,body,head,tbody"
    " let g:html_indent_script1 = "inc"
    " let g:html_indent_style1 = "inc"

" Plug 'othree/javascript-libraries-syntax.vim'
    " let g:used_javascript_libs = 'jquery,underscore,backbone'

" ==================================================== ianva/vim-youdao-translater
" Plug 'ianva/vim-youdao-translater'
    " vnoremap <silent> <C-T> <Esc>:Ydv<CR>
    " nnoremap <silent> <C-T> <Esc>:Ydc<CR>
    " noremap <leader>yd :Yde<CR>

call plug#end()
" ############################################################ End Plug
