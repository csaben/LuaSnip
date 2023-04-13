" Author: Clark Saben
" Latest Update: 8/30/22
" Programming Languages In Mind When Building:
"              1 ) Python
"              2 ) Java
"              3 ) Markdown
"              4 ) Latex

let g:mapleader=" "
" ---------------------------Ian Finlayson Contributions----------------
" generates java boiler plate and autofills class w/ file name (!?) |javat
ab javat <ESC>:set paste<CR>ipublic class <C-R>=expand("%:t:r")<CR> {<CR>    public static void main(String args[]) {<CR>       !cursor!<CR><CR><CR>    }<CR>}<CR><ESC>:set nopaste<CR>?!cursor!<CR>cf!
" auto generates the boilerplate for a print statement |sop
ab sop <ESC>:set paste<CR>iSystem.out.println<ESC>:set nopaste<CR>?!cursor!<CR>cf!
ab sopf <ESC>:set paste<CR>iSystem.out.printf<ESC>:set nopaste<CR>?!cursor!<CR>cf!

" ------------------------- ml shortcuts abusing ab ------------------------------
" boiler plate def main() and if __name__ == '__main__':
ab mainf <ESC>:set paste<CR>idef main():<CR><Tab>pass<CR><CR><ESC>:retab<CR><ESC>:normal G<ESC>A<CR><CR><CR>if __name__ == '__main__':<CR><Tab>main()<ESC>:retab<CR><ESC>:''<CR><ESC><ESC>:set nopaste<CR><ESC>:retab<CR>?!<CR>cf!

" tf keras imports and silencing tf errors w/ os.environ ; this does assume
" you are at the spot you wanna to put your imports 
ab importf <ESC>:set paste<CR>iimport os<CR>os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'<CR>import warnings<CR>warnings.filterwarnings('ignore')<CR><CR>import tensorflow as tf<CR>from tensorflow import keras<CR>import numpy as np<CR>import pandas as pd<CR><ESC>:set nopaste<CR>?!<CR>cf!

" warnings.filterwarnings('ignore')
" boiler plate eda of a numpy array
" boiler plate keras functional model

" ------------------------- Plugins ------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'github/copilot.vim'
Plug 'lervag/vimtex'
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-scripts/indentpython.vim'
Plug 'windwp/nvim-autopairs' " alternative autopair customizable file effect
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ThePrimeagen/harpoon'
Plug 'bfredl/nvim-miniyank'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<1.1.0>.*'}
" Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*'}
" the current major error'd initially so either 1.1.0 works or just try major
" thingy again
" If you have nodejs and yarn
call plug#end()

let g:mkdp_theme = 'dark'
let g:mkdp_browser = 'chrome'

imap <silent><script><expr> <Leader><Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
"
" ---------------------Plugin Settings-----------------------------------
"
" ---------------------Lua Snip (LATEX) -----------------------------------
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Place this in your init.vim
lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'


""not quite sure what these do yet (doesn't work, lets see if it break it)
"lua require("luasnip").config.set_config({ 

"  enable_autosnippets = true,

"  store_selection_keys = "<Tab>",
"})
" Expand or jump in insert mode
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" -- Load all snippets from the nvim/LuaSnip directory at startup
:lua require("luasnip.loaders.from_lua").load({paths = {"~/.config/nvim/LuaSnip/","~/.config/nvim/LuaSnip/tex/" }})

" -- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
:lua require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
" :lua require("luasnip.tex.math")

lua <<EOF
require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",

  update_events = 'TextChanged,TextChangedI',
})
EOF

lua <<EOF
-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config({ -- Setting LuaSnip config
  -- Use <Tab> (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})
EOF
" update_events = 'TextChanged,TextChangedI'
"
" In Vimscript (suggestions)
nnoremap <leader>L <Cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})<CR>
" nnoremap <leader>L <Plug>JupyterExecute<CR>
" imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
" smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
"
"
"

" ---------------------Jupyter Ascending Plugins-------------------------


" nnoremap <leader>L <Plug>JupyterExecute<CR>
" nnoremap <leader>A <Plug>JupyterExecuteAll<CR>

" ---------------------Markdown Settings---------------------------------
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/github_markdown.css'
nnoremap <leader>m :MarkdownPreview
"map N <Plug>MarkdownPreview

"vim.cmd[[ nnoremap <silent><c-x> <Plug>JupyterExecute ]]
"vim.cmd[[ nnoremap <silent><c-X> <Plug>JupyterExecuteAll ]]

"nmap <Ctrl-x> <Plug>JupyterExecute
"nnoremap <silent><c-X> <Plug>JupyterExecuteAll 


" ---------------------Telelscope Settings-------------------------------
:lua require('telescope')
nnoremap <leader>f :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>fi :lua require('telescope.builtin').find_files({ search = vim.fn.input("Enter to Find File: > ")})<CR>
" ---------------------Python Debugger Settings--------------------------
:lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
nnoremap <leader>b :lua require("dap").toggle_breakpoint()<CR> <Plug>
nnoremap <leader>j :lua require("dap").continue()<CR>
:lua require("dapui").setup()
nnoremap <silent><leader>jj :lua require("dapui").toggle()<CR>
" current preference is just to check jj to see variable values in stack


nnoremap <silent><leader>ja :lua require('dap').step_over()
nnoremap <silent><leader>jak :lua require('dap').step_into()
nnoremap <silent><leader>fl :lua require("dapui").float_element("stacks")<CR>
" you have to hit leader fl again and i to get into insert mode inside of
" not really sure how to get the table any bigger. also hear are the other pop
" up options ; breakpoints watches stacks scopes
" popup
" https://github.com/rcarriga/nvim-dap-ui/blob/master/README.md
"
"
:lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF

nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>
nnoremap <leader>di :lua require("dap.ui.widgets").hover()<CR>

"nnoremap <leader>dc :lua require('dap.ui.variables').scopes()<CR>
"map({ "n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>" })
"map({ "n", "<Leader>di", ":lua require('dapui').toggle()<CR>" })

" ---------------------Harpoon Settings--------------------------------------
nnoremap <leader>y :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>
"                -- navigates to next mark
nnoremap <leader>l :lua require("harpoon.ui").nav_next()<CR>   
"                -- navigates to previous mark
nnoremap <leader>k:lua require("harpoon.ui").nav_prev()<CR>   

" ---------------------Autopairs settings------------------------------------
lua << EOF
require("nvim-autopairs").setup ({
  disable_filetype = { "TelescopePrompt", "vim"},
})
EOF
" ---------------------NERDTree settings-------------------------------------
nnoremap <leader>q :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


" -------------------------- General Settings -------------------------------
"-----Colorscheme----                            
colorscheme nord
" ----Preference----
set foldlevel=99
nnoremap <leader>g za
filetype plugin indent on
set noerrorbells
set scrolloff=8
set nowrap
set incsearch
set signcolumn=yes
set nu
set number
set cursorline
set colorcolumn=81
set incsearch
set hlsearch
set hls is "highlights word as typed in search 
set undofile "set undodir=~/.vim/undodir
set undodir=~/undodir
set mouse=a
set foldmethod=manual " <leader>zf + #jk to make and <leader>g to open
"----Mappings----
vnoremap <S-s-k>   :m '<-2<CR>gv=gv
vnoremap <S-s-j> :m '>+1<CR>gv=gv
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
nnoremap <C-p> :Files<Cr>
cmap w!! w !sudo tee > /dev/null %
"----Pythonic----
"syntax on
filetype indent on
"----LATEX TUTORIAL ADDITIONS
filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation
" need to split up my file types into subdirectories to trouble shoot why
" tabbing is broken in lua files



"filetype plugin on
autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4
"this maps shift-b to run a python script from an open vim instance
autocmd FileType python map <buffer> <leader><S-b> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"autocmd FileType python imap <buffer> <S-b> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
au BufNewFile,BufRead *.py
    \ set softtabstop=4 |
    \ set expandtab ts=4 sw=4 ai |
    \ set textwidth=99 | "arbitrary
    \ set fileformat=unix
    " \ set autoindent |
    "

" vimtex stuff
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
" let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_zathura_options = '-reuse-instance'
let g:tex_flavor= 'latex'
let g:vimtex_quickfix_mode=2	
set encoding=utf8
let g:vitex_quickfix_open_on_warning=0
let g:vimtex_quickfix_latexlog = {
            \ 'default' : 1,
            \ 'fix_paths' : 0,
            \ 'general' : 1,
            \ 'references' : 1,
            \ 'overfull' : 1,
            \ 'underfull' : 1,
            \ 'font' : 1,
            \ 'packages' : {
            \   'default' : 1,
            \   'natbib' : 1,
            \   'biblatex' : 1,
            \   'babel' : 1,
            \   'hyperref' : 1,
            \   'scrreprt' : 1,
            \   'fixltx2e' : 1,
            \   'titlesec' : 1,
            \ },
            \}
nnoremap <leader>la :VimtexCompile<CR>

" let g:vimtex_view_general_options_latexmk = '--unique'
" let g:vimtex_compiler_progname = 'nvr'
" let g:vimtex_compiler_latexmk = {
"     \ 'build_dir' : '../build',
"     \}

