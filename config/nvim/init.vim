" Plugins
call plug#begin('~/.vim/plugged')
" Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'

Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pantharshit00/vim-prisma'

Plug 'lifepillar/pgsql.vim'

Plug 'neovimhaskell/haskell-vim'

" Plug 'ionide/Ionide-vim'
Plug 'rescript-lang/vim-rescript'
Plug 'gleam-lang/gleam.vim'

" Elixir
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'elixir-editors/vim-elixir'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

Plug 'purescript-contrib/purescript-vim'

" Terraform
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save=1


" Plug 'fatih/vim-go'

" Javascript
call plug#end()


syntax on
set termguicolors
colorscheme night-owl

" Numbers
set number
set numberwidth=1
set signcolumn=yes:1
set tabstop=2
set shiftwidth=2      " Number of spaces to use for each step of (auto)indent.
set expandtab         " insert tab with right amount of spacing
set shiftround        " Round indent to multiple of 'shiftwidth'
set mouse=a           " enable mouse (selection, resizing windows)
set foldlevel=99      " default to unfolded
set foldmethod=indent
set foldenable


" remove highlighting on escape
nnoremap <silent> <esc> :nohlsearch<cr>

" Coc
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" FZF
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --color=always -E .git --ignore-file ~/.gitignore'
let $FZF_DEFAULT_OPTS='--ansi --preview "bat --color \"always\" {}"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" let g:fzf_files_options = '--preview "bat {}"'
nnoremap <C-p> :FZF<CR>
nnoremap <silent> <Leader>f :Ag<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}


" Nerd Tree
let g:NERDTreeIgnore = [
      \ '\.vim$',
      \ '\~$',
      \ '\.beam',
      \ 'deps',
      \ '_build',
      \ '.git',
      \ '.elixir_ls',
      \ 'node_modules',
      \ 'tags',
      \ ]
let g:NERDTreeShowHidden = 1
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>


let g:vim_jsx_pretty_colorful_config = 1 " default 0
