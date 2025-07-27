" Vim color file
" Name:       256_noir.vim
" Maintainer: Andreas van Cranenburgh <andreas@unstable.nl>
" Homepage:   https://github.com/andreasvc/vim-256noir/

" Basically: dark background, numerals & errors red,
" rest different shades of gray.
"
" colors 232--250 are shades of gray, from dark to light;
" 16=black, 255=white, 196=red, 88=darkred.

highlight clear
syntax reset
set background=dark
let g:colors_name = "256_noir"

hi Normal gui=NONE guifg=#bcbcbc
hi NonText guifg=#161616
hi Keyword gui=bold cterm=bold guifg=#bbbbbb
hi Constant gui=NONE guifg=#d0d0d0
hi String gui=NONE guifg=#8a8a8a
hi Comment gui=NONE guifg=#585858
hi Number gui=NONE guifg=#ff0000
hi Error gui=NONE guifg=#bbbbbb guibg=#870000
hi ErrorMsg gui=NONE guifg=#bbbbbb guibg=#af0000
hi Search gui=NONE guifg=#8a8a8a guibg=#303030
hi IncSearch gui=reverse guifg=#bbbbbb guibg=#8a8a8a
hi DiffChange gui=NONE guifg=#d70000 guibg=#bbbbbb
hi DiffText gui=bold guifg=#bcbcbc guibg=#ff0000
hi SignColumn gui=NONE guifg=#af0000 guibg=#585858
hi SpellBad gui=undercurl guifg=#bbbbbb guibg=#870000
hi SpellCap gui=NONE guifg=#bbbbbb guibg=#af0000
hi SpellRare gui=NONE guifg=#af0000
hi WildMenu gui=NONE guifg=#585858 guibg=#bbbbbb
hi Pmenu gui=NONE guifg=#bbbbbb guibg=#585858
hi PmenuThumb gui=NONE guifg=#080808 guibg=#585858
hi SpecialKey gui=NONE guifg=#000000 guibg=#bbbbbb
hi MatchParen gui=bold cterm=bold guifg=#af0000 guibg=NONE
hi CursorLine gui=NONE guifg=NONE guibg=#121212
hi StatusLine gui=bold,reverse guifg=#8a8a8a
hi StatusLineNC gui=reverse guifg=#303030
hi Visual gui=reverse guifg=#bcbcbc
hi TermCursor gui=reverse guifg=NONE guibg=NONE

highlight! link Boolean Normal
highlight! link Delimiter Normal
highlight! link Identifier Normal
highlight! link Title Normal
highlight! link Debug Normal
highlight! link Exception Normal
highlight! link FoldColumn Normal
highlight! link Macro Normal
highlight! link ModeMsg Normal
highlight! link MoreMsg Normal
highlight! link Question Normal
highlight! link Conditional Keyword
highlight! link Statement Keyword
highlight! link Operator Keyword
highlight! link Structure Keyword
highlight! link Function Keyword
highlight! link Include Keyword
highlight! link Type Keyword
highlight! link Typedef Keyword
highlight! link Todo Keyword
highlight! link Label Keyword
highlight! link Define Keyword
highlight! link DiffAdd Keyword
highlight! link diffAdded Keyword
highlight! link diffCommon Keyword
highlight! link Directory Keyword
highlight! link PreCondit Keyword
highlight! link PreProc Keyword
highlight! link Repeat Keyword
highlight! link Special Keyword
highlight! link SpecialChar Keyword
highlight! link StorageClass Keyword
highlight! link SpecialComment String
highlight! link CursorLineNr String
highlight! link Character Number
highlight! link Float Number
highlight! link Tag Number
highlight! link Folded Number
highlight! link WarningMsg Number
highlight! link iCursor SpecialKey
highlight! link SpellLocal SpellCap
highlight! link LineNr Comment
highlight! link DiffDelete Comment
highlight! link diffRemoved Comment
highlight! link PmenuSbar Visual
highlight! link PmenuSel Visual
highlight! link VisualNOS Visual
highlight! link VertSplit Visual
highlight! link Cursor StatusLine
highlight! link Underlined SpellRare
highlight! link rstEmphasis SpellRare
highlight! link diffChanged DiffChange
