let g:conflict_marker_enable_mappings = 0
let g:conflict_marker_enable_highlight = 0

nnoremap <silent> <leader>cn :<C-u>ConflictMarkerNextHunk<CR>
nnoremap <silent> <leader>cp :<C-u>ConflictMarkerPrevHunk<CR>

nnoremap <silent> <leader>ct :<C-u>ConflictMarkerThemselves<CR>
nnoremap <silent> <leader>co :<C-u>ConflictMarkerOurselves<CR>
nnoremap <silent> <leader>cb :<C-u>ConflictMarkerBoth<CR>
nnoremap <silent> <leader>cd :<C-u>ConflictMarkerNone<CR>
