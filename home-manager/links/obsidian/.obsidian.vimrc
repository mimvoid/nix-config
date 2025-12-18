set clipboard=unnamedplus
set tabstop=4

unmap <Space>

" Remove search highlights
nmap <Esc> :nohl<CR>


" Obsidian Vimrc Support Plugin provided commands

" Surround
" NOTE: must use 'map' and not 'nmap'
nunmap s
vunmap s
map s" :surround<space>"<space>"<CR>
map s' :surround<space>'<space>'<CR>
map s` :surround<space>`<space>`<CR>

exmap surround_brackets surround ( )
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>

exmap surround_square_brackets surround [ ]
map s[ :surround_square_brackets<CR>
map s[ :surround_square_brackets<CR>

exmap surround_curly_brackets surround { }
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>


" Obsidian commands

" Tab management
exmap badd obcommand workspace:new-tab
exmap bdelete obcommand workspace:close

nmap <Space>n :badd<CR>
nmap <Space>x :bdelete<CR>


" Sidebar
exmap files_focus obcommand file-explorer:reveal-active-file
exmap search_open obcommand global-search:open
exmap bookmarks_open obcommand bookmarks:open

nmap <Space>e :files_focus<CR>
nmap <Space>s :search_open<CR>
nmap <Space>bm :bookmarks_open<CR>


" Plugins
"
" Quick Explorer
exmap browse_current obcommand quick-explorer:browse-current
nmap <Space>e :browse_current<CR>

" Linter
exmap lint_file obcommand obsidian-linter:lint-file-unless-ignored
nmap <Space>bf :lint_file<CR>


" Misc
exmap switcher_open obcommand switcher:open
exmap daily_note_open obcommand daily-notes

nmap <Space>ff :switcher_open<CR>
nmap <Space>da :daily_note_open<CR>
