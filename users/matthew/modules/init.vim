"Allow filetype plugins and syntax highlighting
set autoindent
filetype plugin indent on
syntax on

"Exapnd tab to spaces
set expandtab

"Incremental live completion
set inccommand=nosplit

"Change backspace to behave more intuitively
set backspace=indent,eol,start

"Set tab options for vim
set tabstop=8
set softtabstop=4

"Set highlight on search
set nohlsearch
set incsearch

"Make line numbers default
set number

"Do not save when switching buffers
set hidden

"Enable mouse mode
set mouse=a

"Enable break indent
set breakindent

"Set show command
set showcmd

"Save undo history
set undofile

"Case insensitive searching UNLESS /C or capital in search
set ignorecase
set smartcase

"Decrease update time
set updatetime=250
set signcolumn=yes

"Set colorscheme
packadd! onedark-vim
colorscheme onedark
set termguicolors
let g:onedark_terminal_italics=1
let g:lightline = {
       \ 'colorscheme': 'onedark',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
       \ },
       \ 'component_function': {
       \   'gitbranch': 'fugitive#head',
       \ },
       \ }


"Remap space as leader key
noremap <Space> <Nop>
let mapleader="\<Space>"

" Remap for dealing with word wrap
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

"Add move line shortcuts
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <A-j> :m .+1<CR>==

"Remap escape to leave terminal mode
augroup Terminal
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
augroup end

"Add map to enter paste mode
set pastetoggle=<F3>

"Allow copy and paste to clipboard
nnoremap <F10> :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == 'a'
    IndentLinesDisable
    set signcolumn=no
    set mouse=v
    set nonu
    echo "Mouse usage Visual"
  else
    IndentLinesEnable
    set signcolumn=yes
    set mouse=a
    set nu
    echo "Mouse usage All"
  endif
endfunction

"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Add neovim remote for vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

"Add leader shortcuts
"nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>f :ProjectFiles<CR>
nnoremap <silent> <leader><space> :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>s :Rg<CR>
nnoremap <silent> <leader>p :Projects<CR>

" Add FZF and Vim Fugitive Shorcuts
nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gb :Gbranch<CR>
nnoremap <silent> <leader>ga :Git add %:p<CR><CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR><CR>
nnoremap <silent> <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <silent> <leader>gp :Ggrep<Space>
nnoremap <silent> <leader>gm :Gmove<Space>
nnoremap <silent> <leader>go :Git checkout<Space>
nnoremap <silent> <leader>gps :Dispatch! git push<CR>
nnoremap <silent> <leader>gpl :Dispatch! git pull<CR>

"Alternative shortcut without using fzf
nnoremap <leader>, :buffer *
nnoremap <leader>. :e<space>**/
nnoremap <leader>T :tjump *

" Intelligent switching of branches
function! s:gitCheckoutRef(ref)
    execute('Git checkout ' . a:ref)
    " call feedkeys("i")
endfunction

function! s:gitListRefs()
   let l:refs = execute("Git for-each-ref --format='\\%(refname:short)'")
   return split(l:refs,'\r\n*')[1:] "jump past the first line which is the git command
endfunction

command! -bang Gbranch call fzf#run({ 'source': s:gitListRefs(), 'sink': function('s:gitCheckoutRef'), 'dir':expand('%:p:h') })

" Search project root
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(options), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

"Add command for searching files within current git directory structure
command! ProjectFiles execute 'Files' s:find_git_root()

function! s:change_working_directory(path)
    execute 'cd' a:path
    execute 'edit' a:path
endfunction

" Projects implementation
function! s:switch_projects(path)
  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:path[0], 'e')

  execute cmd escape(a:path[1], ' %#\')
  execute('lcd ' . a:path[1])
endfunction

" Projects
command! -nargs=* Projects call fzf#run({
\ 'source':  'fd -H -t d --maxdepth 4 .git ' . $HOME . "/Repositories" . ' | sed -En "s/\/.git//p"',
\ 'sink*':    function('<sid>switch_projects'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'})

" Make gutentags use ripgrep
" --python-kinds=-iv
" --exclude=build
" --exclude=dist
let g:gutentags_file_list_command = 'fd'
let g:gutentags_ctags_extra_args = ['-n', '-u', '--python-kinds=-iv']

" speed up indent line
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_faster = 1
let g:indentLine_setConceal = 2
let g:indentLine_concealcursor = ""
let g:indentLine_bufNameExclude = ["term:.*"]

" remove conceal on markdown files
let g:markdown_syntax_conceal = 0

" Configure vim slime to use tmux
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}

"Change preview window location
set splitbelow

"Remap number increment to alt
nnoremap <A-a> <C-a>
vnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
vnoremap <A-x> <C-x>

"n always goes forward
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

"Neovim python support
let g:loaded_python_provider = 0

" Highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

" Y yank until the end of line
noremap Y y$

" Clear white space on empty lines and end of line
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

""" Nerdtree like sidepanel
" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" variable for use by ToggleNetrw function
let g:NetrwIsOpen=0

" Lexplore toggle function
function! ToggleNetrw()

    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
        let g:netrw_liststyle = 0
        let g:netrw_chgwin=-1
    else
        let g:NetrwIsOpen=1
        let g:netrw_liststyle = 3
        silent Lexplore
    endif
endfunction

" Open netrw sidebar and open preview of file under cursor with ;
noremap <silent> <leader>d :call ToggleNetrw()<CR><Paste>

" Function to open preview of file under netrw
augroup Netrw
  autocmd filetype netrw nmap <leader>; <cr>:wincmd W<cr>
augroup end

" Vim polyglot language specific settings
let g:python_highlight_space_errors = 0

" LSP settings
" log file location: /Users/michael/.local/share/nvim/vim-lsp.log
:lua << EOF
  -- Add nvim-lspconfig plugin
  vim.cmd('packadd nvim-lspconfig')

  local nvim_lsp = require('lspconfig')
  -- vim.lsp.set_log_level("debug")

  local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- disable virtual text
        virtual_text = false,

        -- show signs
        signs = true,

        -- delay update diagnostics
        update_in_insert = false,
      }
    )
    require'completion'.on_attach()

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  end

  local servers = {'gopls', 'rust_analyzer', 'sumneko_lua', 'tsserver', 'vimls', 'jsonls', 'html', 'ghcide', 'rnix', 'ocamllsp', 'pyright'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

command! Format  execute 'lua vim.lsp.buf.formatting()'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Chain completion list
let g:completion_chain_complete_list = {
            \ 'default' : {
            \   'default': [
            \       {'complete_items': ['lsp', 'snippet']},
            \       {'mode': '<c-p>'},
            \       {'mode': '<c-n>'}],
            \   'comment': [],
            \   'string' : [{'complete_items': ['path']}]}}


" Formatters 
let g:neoformat_enabled_python = [ 'black' ]
