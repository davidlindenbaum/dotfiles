call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'luochen1990/rainbow'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mileszs/ack.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'moll/vim-bbye'
Plug 'edkolev/promptline.vim'
Plug 'gioele/vim-autoswap'
Plug 'mlr-msft/vim-loves-dafny', {'for': 'dafny'}
call plug#end()

set showtabline=0
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'long']
let g:airline#extensions#whitespace#trailing_format = 'tr[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mi[%s]'
let g:airline#extensions#whitespace#long_format = 'lng[%s]'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline_section_y = airline#section#create([
      \ '%{fnamemodify(getcwd(), ":h:h:t")}',
      \ '/%{fnamemodify(getcwd(),":h:t")}',
      \ '/%{fnamemodify(getcwd(), ":t")}'])
let g:airline_section_z = airline#section#create(['linenr', '/%L:%3c'])
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'seagreen3', 'darkorchid3', 'firebrick3'],
    \   'ctermfgs': ['darkmagenta', 'darkcyan', 'darkred', 'darkgreen', 'red',
    \                'darkblue', 'gray', 'brown']
    \}
let g:rainbow_active = 1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>f <plug>NERDTreeTabsToggle<CR>

let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '▾'
"▼▾►▶►⇕▾˄ ˅

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

let g:SuperTabMappingForward = '<c-@>'

let g:promptline_preset = {
        \'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd({ 'dir_limit': 4 }) ],
        \'warn' : [ promptline#slices#last_exit_code() ]}
"\'y' : [ promptline#slices#vcs_branch() ],
