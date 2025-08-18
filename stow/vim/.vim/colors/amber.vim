highlight clear
syntax reset
set background=dark
let g:colors_name = "amber"

hi Normal gui=NONE guifg=#ff8100
hi NonText guifg=#303030
hi Keyword cterm=NONE guifg=#ff8100
hi Constant gui=NONE guifg=#ff8100
hi String gui=NONE guifg=#ff8100
hi Comment gui=NONE guifg=#656565
hi Number gui=NONE guifg=#ff8100
hi Error gui=NONE guifg=#ff8100 guibg=#870000
hi ErrorMsg gui=NONE guifg=#ff8100 guibg=#af0000
hi Search gui=NONE guifg=#ff8100 guibg=#303030
hi IncSearch guifg=#161616 guibg=#ff8100
hi DiffChange gui=NONE guifg=#d70000 guibg=#ff8100
hi DiffText gui=bold guifg=#ff8100 guibg=#ff0000
hi SignColumn gui=NONE guifg=#af0000 guibg=#656565
hi SpellBad gui=undercurl guifg=#ff8100 guibg=#870000
hi SpellCap gui=NONE guifg=#ff8100 guibg=#af0000
hi SpellRare gui=NONE guifg=#af0000
hi WildMenu gui=NONE guifg=#656565 guibg=#ff8100
hi Pmenu gui=NONE guifg=#ff8100 guibg=#656565
hi PmenuThumb gui=NONE guifg=#080808 guibg=#656565
hi SpecialKey gui=NONE guifg=#161616 guibg=#ff8100
hi MatchParen gui=reverse cterm=reverse guifg=#ff8100 guibg=NONE
hi CursorLine gui=NONE guifg=NONE guibg=#121212
hi StatusLine cterm=inverse guifg=#ff8100 guibg=#161616
hi StatusLineNC guifg=#656565 guibg=NONE cterm=bold
hi Visual guibg=#ff8100 guifg=#161616
hi TermCursor gui=reverse guifg=NONE guibg=NONE
hi EndOfBuffer guifg=#161616
hi VertSplit guifg=#656565 guibg=NONE cterm=reverse

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
highlight! link Cursor StatusLine
highlight! link Underlined SpellRare
highlight! link rstEmphasis SpellRare
highlight! link diffChanged DiffChange
