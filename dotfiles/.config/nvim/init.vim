" Packages {{{

lua require('packages')

function! s:packager_init(packager) abort
  call a:packager.add('https://github.com/kristijanhusak/vim-packager', {'type': 'opt'})
  " Autocompletion And IDE Features
  call a:packager.add('https://github.com/neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'})
  call a:packager.add('https://github.com/pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' })
  " TreeSitter
  call a:packager.add('https://github.com/nvim-treesitter/nvim-treesitter')
  call a:packager.add('https://github.com/windwp/nvim-ts-autotag')
  call a:packager.add('https://github.com/JoosepAlviste/nvim-ts-context-commentstring')
  call a:packager.add('https://github.com/tpope/vim-commentary')
  " Tree
  call a:packager.add('https://github.com/kyazdani42/nvim-tree.lua')
  call a:packager.add('https://github.com/kyazdani42/nvim-web-devicons')
  " Fuzzy Finder
  call a:packager.add('https://github.com/nvim-telescope/telescope.nvim')
  call a:packager.add('https://github.com/nvim-lua/plenary.nvim')
  " Git
  call a:packager.add('https://github.com/tpope/vim-fugitive')
  call a:packager.add('https://github.com/lewis6991/gitsigns.nvim')
  " Text Objects
  call a:packager.add('https://github.com/machakann/vim-sandwich')
  call a:packager.add('https://github.com/kana/vim-textobj-user')
  " Miscellaneous
  call a:packager.add('https://github.com/pappasam/papercolor-theme-slim')
  call a:packager.add('https://github.com/NvChad/nvim-colorizer.lua')
  call a:packager.add('https://github.com/fidian/hexmode')
  call a:packager.add('https://github.com/iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'})
  call a:packager.add('https://github.com/pappasam/nvim-repl')
  call a:packager.add('https://github.com/pappasam/vim-filetype-formatter')
  call a:packager.add('https://github.com/pappasam/vim-keywordprg-commands')
  call a:packager.add('https://github.com/sjl/strftimedammit.vim')
  call a:packager.add('https://github.com/windwp/nvim-autopairs')
endfunction

" }}}
" Settings {{{

aunmenu PopUp.-1-
aunmenu PopUp.How-to\ disable\ mouse
colorscheme PaperColorSlim
digraph '' 699  " Hawaiian character ʻ
set cmdheight=2
set completeopt=menuone,longest wildmode=longest:full
set cursorline
set dictionary=$HOME/config/docs/dict/american-english-with-propcase.txt
set diffopt+=internal,algorithm:patience
set expandtab autoindent smartindent shiftwidth=2 softtabstop=2 tabstop=8
set foldenable foldmethod=marker foldnestmax=1
set grepprg=rg\ --vimgrep
set history=10
set isfname+=@-@,:
set list
set listchars=tab:>\ ,nbsp:+,leadmultispace:\ ,multispace:-
set mouse=a
set noshowcmd
set noshowmode
set noswapfile
set notimeout
set nowrap linebreak
set number
set path+=/usr/include/x86_64-linux-gnu/
set shortmess+=cI
set showtabline=2
set signcolumn=number
set spelllang=en_us
set splitright
set termguicolors
set updatetime=300
set statusline=%#CursorLine#\ %{mode()}\ %*\ %{&paste?'[P]':''}%{&spell?'[S]':''}%r%t%m
set statusline+=%=%v/%{strwidth(getline('.'))}:%l/%L%y%#CursorLine#\ %{&ff}\ %*\ %{strlen(&fenc)?&fenc:'none'}\  " Trailing space
set tabline=%!CustomTabLine()
function! CustomTabLine()
  let s = ''
  let tabnumber_max = tabpagenr('$')
  let tabnumber_current = tabpagenr()
  for i in range(1, tabnumber_max)
    let s ..= tabnumber_current == i ? '%#TabLineSel#' : '%#TabLine#'
    let s ..= '%' .. i .. 'T' .. ' ' .. i .. ':%{CustomTabLabel(' .. i .. ')}'
    let s ..= tabnumber_max == 1 ? ' ' : '%' .. i .. 'X ✗ %X'
  endfor
  let s ..= '%#TabLineFill#%T%=%#TabLine#%10@CustomTabCloseVim@ ✗ %X'
  return s
endfunction
function! CustomTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let postfix = ''
  for buf in buflist
    if bufname(buf) == 'focuswriting_abcdefg'
      let postfix = '🎯'
      break
    endif
  endfor
  let bname = bufname(buflist[winnr - 1])
  let bnamemodified = fnamemodify(bname, ':t')
  if bnamemodified == ''
    return '👻' .. postfix
  elseif bnamemodified =~ 'NvimTree'
    return '🌲' .. postfix
  else
    return bnamemodified .. postfix
  endif
endfunction
function! CustomTabCloseVim(n1, n2, n3, n4)
  quitall
endfunction
let $PATH = $PWD .. '/node_modules/.bin:' .. $PATH
let g:mapleader = ','
let g:clipboard = {
      \ 'name': 'xsel',
      \ 'cache_enabled': 0,
      \ 'copy' : {'+': 'xsel --clipboard --input' , '*': 'xsel --clipboard --input' },
      \ 'paste': {'+': 'xsel --clipboard --output', '*': 'xsel --clipboard --output'},
      \ }
let g:loaded_python3_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" https://github.com/fidian/hexmode
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 2'
" https://github.com/pappasam/vim-filetype-formatter
let g:vim_filetype_formatter_commands = {
      \ 'python': {-> printf('ruff check -q --fix-only --stdin-filename="%1$s" - | black -q --stdin-filename="%1$s" - | isort -q --filename="%1$s" - | docformatter -', expand('%:p'))},
      \ }
" https://github.com/pappasam/nvim-repl
let g:repl_filetype_commands = {
      \ 'bash': 'bash',
      \ 'javascript': 'node',
      \ 'python': 'ipython --quiet --no-autoindent -i -c "%config InteractiveShell.ast_node_interactivity=\"last_expr_or_assign\""',
      \ 'r': 'R',
      \ 'sh': 'sh',
      \ 'vim': 'nvim --clean -ERM',
      \ 'zsh': 'zsh',
      \ }
let g:repl_default = &shell
" https://github.com/iamcco/markdown-preview.nvim
let g:mkdp_preview_options = {'disable_sync_scroll': 0, 'sync_scroll_type': 'middle'}
" https://github.com/neoclide/coc.nvim
let g:coc_global_extensions = [
      \ '@yaegassy/coc-marksman',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-docker',
      \ 'coc-emoji',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-kotlin',
      \ 'coc-lists',
      \ 'coc-ltex',
      \ 'coc-markdownlint',
      \ 'coc-prisma',
      \ 'coc-pyright',
      \ 'coc-r-lsp',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sumneko-lua',
      \ 'coc-svg',
      \ 'coc-syntax',
      \ 'coc-texlab',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-word',
      \ 'coc-yank',
      \ ]
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
let g:coc_start_at_startup = 1
let g:coc_filetype_map = {
      \ 'markdown.mdx': 'markdown',
      \ 'yaml.ansible': 'yaml',
      \ 'yaml.docker-compose': 'yaml',
      \ 'jinja.html': 'html',
      \ }

" }}}
" Autocmds {{{

augroup bufenter_filetype_assignment
  autocmd!
  autocmd BufEnter *.cfg,*.ini,.coveragerc,*pylintrc,zoomus.conf,config,credentials,.editorconfig set filetype=dosini
  autocmd BufEnter *.config,.cookiecutterrc,DESCRIPTION,.lintr set filetype=yaml
  autocmd BufEnter *.mdx set filetype=markdown
  autocmd BufEnter *.min.js set filetype=none
  autocmd BufEnter *.oct set filetype=octave
  autocmd BufEnter .envrc set filetype=sh
  autocmd BufEnter .dockerignore set filetype=conf
  autocmd BufEnter renv.lock,.jrnl_config,*.bowerrc,*.babelrc,*.eslintrc,*.slack-term,*.htmlhintrc,*.stylelintrc,*.firebaserc set filetype=json
  autocmd BufEnter poetry.lock,Pipfile set filetype=toml
  autocmd BufEnter tsconfig.json,*.jsonc,.markdownlintrc set filetype=jsonc
augroup end

augroup filetype_custom
  autocmd!
  autocmd Filetype vim call system(['git', 'clone', 'https://github.com/kristijanhusak/vim-packager', $HOME .. '/.config/nvim/pack/packager/opt/vim-packager'])
        \ | packadd vim-packager
        \ | call packager#setup(function('s:packager_init'), {'window_cmd': 'edit'})
        \ | let &l:path .= ','..stdpath('config')..'/lua'
        \ | setlocal suffixesadd^=.lua
  " indentation
  autocmd Filetype markdown setlocal shiftwidth=2 softtabstop=2
  autocmd Filetype python,c,nginx,haskell,rust,kv,asm,nasm,gdscript3 setlocal shiftwidth=4 softtabstop=4
  autocmd Filetype go,gomod,make,snippets,tsv,votl setlocal tabstop=4 softtabstop=0 shiftwidth=0 noexpandtab
  " commentstring + comments + formatoptions
  "   commentstring: read by vim-commentary; must be one template
  "   comments: csv of comments.
  "   formatoptions: influences how Vim formats text
  "   ':help fo-table' will get the desired result
  autocmd FileType dosini setlocal commentstring=#\ %s comments=:#,:;
  autocmd FileType mermaid setlocal commentstring=\%\%\ %s comments=:\%\%
  autocmd FileType tmux,python,nginx setlocal commentstring=#\ %s comments=:# formatoptions=jcroql
  autocmd FileType jsonc setlocal commentstring=//\ %s comments=:// formatoptions=jcroql
  autocmd FileType sh setlocal formatoptions=jcroql
  autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
  " iskeyword
  autocmd FileType nginx setlocal iskeyword+=$
  autocmd FileType zsh,sh,css setlocal iskeyword+=-
  autocmd FileType scss setlocal iskeyword+=@-@
  " keywordprg
  autocmd FileType markdown setlocal keywordprg=:DefEng
  " wrap
  autocmd FileType coctree setlocal nowrap
  " foldenable
  autocmd FileType gitcommit,checkhealth setlocal nofoldenable
  " window opening
  autocmd FileType gitcommit if winnr("$") > 1 | wincmd T | endif
  " mappings
  autocmd FileType man,help,qf
        \ nnoremap <buffer> d <C-d> |
        \ nnoremap <buffer> D <C-d> |
        \ nnoremap <buffer> u <C-u> |
        \ nnoremap <buffer> U <C-u> |
        \ nnoremap <buffer> <C-]> <C-]> |
        \ nnoremap <buffer> q <Cmd>quit<CR>
augroup end

augroup miscellaneous_custom
  autocmd!
  autocmd BufEnter NvimTree* setlocal statusline=\ NvimTree\ %#CursorLine#
  autocmd BufWritePre * TrimWhitespace
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
  autocmd VimEnter * if exists(':NvimTreeOpen') && len(argv()) == 1 && isdirectory(argv(0)) | execute 'NvimTreeOpen ' .. argv(0) | endif
  autocmd VimResized * wincmd =
augroup end

" }}}
" Mappings {{{

nnoremap <silent> zS <cmd>Inspect<CR>
nnoremap <silent> <expr> J v:count == 0 ? '<esc>' : 'J'
nnoremap ' ,
inoremap <silent> <C-c> <Esc>:pclose <BAR> cclose <BAR> lclose <CR>a
nnoremap <silent> <C-c> :pclose <BAR> cclose <BAR> lclose <CR>
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <plug>@init <SID>mr_at_init()
inoremap <expr> <plug>@init "\<c-o>".<SID>mr_at_init()
nnoremap <expr> <plug>qstop <SID>mr_q_stop()
inoremap <expr> <plug>qstop "\<c-o>".<SID>mr_q_stop()
nmap <expr> @ <SID>mr_at_reg()
nmap <expr> q <SID>mr_q_start()
nnoremap <silent> <A-1> <Cmd>silent! 1tabnext<CR>
nnoremap <silent> <A-2> <Cmd>silent! 2tabnext<CR>
nnoremap <silent> <A-3> <Cmd>silent! 3tabnext<CR>
nnoremap <silent> <A-4> <Cmd>silent! 4tabnext<CR>
nnoremap <silent> <A-5> <Cmd>silent! 5tabnext<CR>
nnoremap <silent> <A-6> <Cmd>silent! 6tabnext<CR>
nnoremap <silent> <A-7> <Cmd>silent! 7tabnext<CR>
nnoremap <silent> <A-8> <Cmd>silent! 8tabnext<CR>
nnoremap <silent> <A-9> <Cmd>silent! $tabnext<CR>
nnoremap <silent> gx <Cmd>call jobstart(['firefox', expand('<cfile>')])<CR>
xnoremap <silent> gx :<C-u> call jobstart(['firefox', <SID>get_visual_selection(visualmode())])<CR><Esc>`<
nnoremap <leader><leader>g <Cmd>FocusWriting<CR>
nnoremap <silent> <leader><leader>h <Cmd>ResizeWindowHeight<CR>
nnoremap <silent> <leader><leader>w <Cmd>ResizeWindowWidth<CR>
vnoremap <leader>y "+y
nnoremap <leader>y "+y
noremap <silent> <MiddleMouse> <LeftMouse>za
noremap <silent> <2-MiddleMouse> <LeftMouse>za
noremap <silent> <3-MiddleMouse> <LeftMouse>za
noremap <silent> <4-MiddleMouse> <LeftMouse>za
cnoreabbrev <expr> v <SID>abbr_only_beginning('v', 'edit ~/.config/nvim/init.vim')
cnoreabbrev <expr> z <SID>abbr_only_beginning('z', 'edit ~/.zshrc')
cnoreabbrev <expr> b <SID>abbr_only_beginning('b', 'edit ~/.bashrc')
" https://github.com/neoclide/coc.nvim
nmap     <silent>        <C-]> <Plug>(coc-definition)
nnoremap <silent>        <C-k> <Cmd>call CocActionAsync('doHover')<CR>
inoremap <silent>        <C-s> <Cmd>call CocActionAsync('showSignatureHelp')<CR>
nnoremap <silent>        <C-w>f <Cmd>call coc#float#jump()<CR>
nmap     <silent>        <leader>st <Plug>(coc-type-definition)
nmap     <silent>        <leader>si <Plug>(coc-implementation)
nmap     <silent>        <leader>su <Plug>(coc-references)
nmap     <silent>        <leader>sr <Plug>(coc-rename)
nmap     <silent>        <leader>sa v<Plug>(coc-codeaction-selected)
vmap     <silent>        <leader>sa <Plug>(coc-codeaction-selected)
nnoremap <silent>        <leader>sh <Cmd>call CocActionAsync('highlight')<CR>
nnoremap <silent>        <leader>sn <Cmd>CocNext<CR>
nnoremap <silent>        <leader>sp <Cmd>CocPrev<CR>
nnoremap <silent>        <leader>sl <Cmd>CocListResume<CR>
nnoremap <silent>        <leader>sc <Cmd>CocList commands<cr>
nnoremap <silent>        <leader>so <Cmd>CocList -A outline<cr>
nnoremap <silent>        <leader>sw <Cmd>CocList -A -I symbols<cr>
inoremap <silent> <expr> <c-space> coc#refresh()
nnoremap                 <leader>d <Cmd>call CocActionAsync('diagnosticToggleBuffer')<CR>
nnoremap                 <leader>D <Cmd>call CocActionAsync('diagnosticPreview')<CR>
nmap     <silent>        ]g <Plug>(coc-diagnostic-next)
nmap     <silent>        [g <Plug>(coc-diagnostic-prev)
nnoremap <silent>        <space>l <Cmd>call <SID>coc_toggle_outline()<CR>
" https://github.com/lewis6991/gitsigns.nvim
nnoremap <silent> <leader>g <Cmd>Gitsigns toggle_signs<CR>
" https://github.com/pappasam/nvim-repl
nnoremap <leader><leader>e <Cmd>ReplToggle<CR>
nmap     <leader>e         <Plug>ReplSendLine
vmap     <leader>e         <Plug>ReplSendVisual
" https://github.com/machakann/vim-sandwich
nmap s <Nop>
xmap s <Nop>
" https://github.com/nvim-telescope/telescope.nvim
nnoremap <silent> <C-p><C-p> <Cmd>Telescope find_files hidden=true<CR>
nnoremap <silent> <C-p><C-b> <Cmd>Telescope buffers<CR>
nnoremap <silent> <C-p><C-g> <Cmd>Telescope git_status<CR>
nnoremap <silent> <C-n><C-n> <Cmd>Telescope live_grep<CR>
nnoremap <silent> <C-n><C-w> <Cmd>Telescope grep_string<CR>
nnoremap <silent> <C-n><C-h> <Cmd>Telescope help_tags<CR>
" https://github.com/pappasam/vim-filetype-formatter
nnoremap <silent> <leader>f <Cmd>silent! CocDisable<cr><Cmd>FiletypeFormat<cr><Cmd>silent! CocEnable<cr>
vnoremap <silent> <leader>f <Cmd>silent! CocDisable<cr>:FiletypeFormat<cr><Cmd>silent! CocEnable<cr>
" https://github.com/kyazdani42/nvim-tree.lua
nnoremap <silent> <space>j <Cmd>NvimTreeFindFileToggle<CR>

" https://stackoverflow.com/a/61486601
function! s:get_visual_selection(mode)
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if a:mode ==# 'v'
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
  elseif a:mode ==# 'V'
  elseif a:mode == "\<c-v>"
    let new_lines = []
    let i = 0
    for line in lines
      let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
      let i = i + 1
    endfor
  else
    return ''
  endif
  return join(lines, "\n")
endfunction

function! s:abbr_only_beginning(in_command, out_command)
  if (getcmdtype() == ':' && getcmdline() =~ '^' .. a:in_command .. '$')
    return a:out_command
  else
    return a:in_command
  endif
endfunction

function! s:coc_toggle_outline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

" Macro Repeater (mr): https://vi.stackexchange.com/questions/11210/can-i-repeat-a-macro-with-the-dot-operator
function! s:mr_at_repeat(_)
  let s:atcount = v:count ? v:count : s:atcount
  call feedkeys(s:atcount .. '@@')
endfunction
function! s:mr_at_set_repeat(_)
  set operatorfunc=<SID>mr_at_repeat
endfunction
function! s:mr_at_init()
  set operatorfunc=<SID>mr_at_set_repeat
  return 'g@l'
endfunction
function! s:mr_at_reg()
  let s:atcount = v:count1
  return '@' .. nr2char(getchar()) .. "\<plug>@init"
endfunction
function! s:mr_q_repeat(_)
  call feedkeys('@' .. s:qreg)
endfunction
function! s:mr_q_set_repeat(_)
  set operatorfunc=<SID>mr_q_repeat
endfunction
function! s:mr_q_stop()
  set operatorfunc=<SID>mr_q_set_repeat
  return 'g@l'
endfunction
let s:qrec = 0
function! s:mr_q_start()
  if s:qrec == 1
    let s:qrec = 0
    return "q\<plug>qstop"
  endif
  let s:qreg = nr2char(getchar())
  if s:qreg =~# '[0-9a-zA-Z"]'
    let s:qrec = 1
  endif
  return 'q' .. s:qreg
endfunction

" }}}
" Commands {{{

command! TrimWhitespace call s:trim_whitespace()
function! s:trim_whitespace()
  let save = winsaveview()
  if &ft == 'markdown'
    " Replace lines with only trailing spaces
    silent! execute '%s/^\s\+$//e'
    " Replace lines with exactly one trailing space with no trailing spaces
    silent! execute '%g/\S\s$/s/\s$//g'
    " Replace lines with more than 2 trailing spaces with 2 trailing spaces
    silent! execute '%s/\s\s\s\+$/  /e'
  else
    " Remove all trailing spaces
    silent! execute '%s/\s\+$//e'
  endif
  call winrestview(save)
endfunction

command! ResizeWindowWidth call s:resize_window_width()
function! s:resize_window_width()
  if &wrap
    echo 'run `:set nowrap` before resizing window'
    return
  endif
  let max_line = line('$')
  let maxlength = max(map(range(1, max_line), "virtcol([v:val, '$'])"))
  let adjustment = &number ? maxlength + max([len(max_line + ''), 2]) + 1 : maxlength - 1
  normal! m`
  execute ':vertical resize ' .. adjustment
  normal! ``
endfunction

command! ResizeWindowHeight call s:resize_window_height()
function! s:resize_window_height()
  normal! m`
  let initial = winnr()
  wincmd k
  if winnr() != initial
    execute initial .. 'wincmd w'
    1
    execute 'resize ' .. (line('$') + 1)
    normal! ``
    return
  endif
  wincmd j
  if winnr() != initial
    execute initial .. 'wincmd w'
    1
    execute 'resize ' .. (line('$') + 1)
    normal! ``
    return
  endif
endfunction

command! FocusWriting call s:focuswriting()
function! s:focuswriting()
  augroup focuswriting
    autocmd!
  augroup end
  let current_buffer = bufnr('%')
  tabe
  try
    file focuswriting_abcdefg
  catch
    edit focuswriting_abcdefg
  endtry
  setlocal nobuflisted
  " Left Window
  call s:focuswriting_settings_side()
  vsplit
  vsplit
  " Right Window
  call s:focuswriting_settings_side()
  wincmd h
  " Middle Window
  vertical resize 88
  execute 'buffer ' .. current_buffer
  call s:focuswriting_settings_middle()
  wincmd =
  augroup focuswriting
    autocmd!
    autocmd WinEnter focuswriting_abcdefg call s:focuswriting_autocmd()
  augroup end
endfunction
function! s:focuswriting_settings_side()
  setlocal nonumber norelativenumber nocursorline fillchars=vert:\ ,eob:\  statusline=\  colorcolumn=0 winhighlight=Normal:NormalFloat
endfunction
function! s:focuswriting_settings_middle()
  setlocal number norelativenumber wrap nocursorline winfixwidth fillchars=vert:\ ,eob:\ ,stlnc:  statusline=\  colorcolumn=0 nofoldenable winhighlight=StatusLine:StatusLineNC
endfunction
function! s:focuswriting_autocmd()
  for windowid in range(1, winnr('$'))
    if bufname(winbufnr(windowid)) != 'focuswriting_abcdefg'
      execute windowid .. 'wincmd w'
      return
    endif
  endfor
  if tabpagenr('$') > 1
    tabclose
  else
    wqall
  endif
endfunction

command! CleanUnicode call s:clean_unicode()
function! s:clean_unicode()
  silent! execute '%s/”/"/g'
  silent! execute '%s/“/"/g'
  silent! execute "%s/’/'/g"
  silent! execute "%s/‘/'/g"
  silent! execute '%s/—/-/g'
  silent! execute '%s/…/.../g'
  silent! execute '%s/​//g'
endfunction

command! Preview call s:preview()
function! s:preview()
  if &filetype ==? 'markdown'
    " https://github.com/iamcco/markdown-preview.nvim
    silent! execute 'MarkdownPreview'
  else
    silent! execute "!gio open '%:p'"
  endif
endfunction

" }}}
