" Initialisation:"{{n
" ----------------------------------------------------------------------------
if !has("gui_running") && &t_Co < 256
  finish
endif

if !exists("g:hybrid_use_Xresources")
  let g:hybrid_use_Xresources = 0
endif

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "hybrid"

let s:gui = 1

if s:gui
  set termguicolors
endif

function! HexOrTermColor(hex, cterm)

  if s:gui
    return a:hex
  else
    return a:cterm
  end
endfunction

"}}}
" GUI And Cterm Palettes:"{{{
" ----------------------------------------------------------------------------

" Function to convert hex to RGB
function! HexToRgb(hex)
    let r = str2nr(a:hex[1:2], 16)
    let g = str2nr(a:hex[3:4], 16)
    let b = str2nr(a:hex[5:6], 16)
    return [r, g, b]
endfunction

" Function to convert RGB to hex
function! RgbToHex(rgb)
    let hex = printf("#%02x%02x%02x", a:rgb[0], a:rgb[1], a:rgb[2])
    return hex
endfunction

" Function to lighten or darken a hex color
" percentage > 0 to lighten, < 0 to darken
function! AdjustHexColor(hex, percentage)
    let rgb = HexToRgb(a:hex)
    let factor = 1 + a:percentage / 100.0
    let new_rgb = map(rgb, 'max(0, min(255, v:val * factor))')
    return RgbToHex(new_rgb)
endfunction


if s:gui
  let s:vmode      = "gui"
  let s:background = "#161616"
  let s:window     = "#303030"
  let s:darkcolumn = "#1c1c1c"
  let s:addbg      = "#5F875F"
  let s:addfg      = "#d7ffaf"
  let s:changebg   = "#5F5F87"
  let s:changefg   = "#d7d7ff"
  let s:darkblue   = "#00005f"
  let s:darkcyan   = "#005f5f"
  let s:darkred    = "#5f0000"
  let s:darkpurple = "#5f005f"
else
  let s:vmode      = "cterm"
  let s:background = "234"
  let s:window     = "236"
  let s:darkcolumn = "234"
  let s:addbg      = "65"
  let s:addfg      = "193"
  let s:changebg   = "60"
  let s:changefg   = "189"

  let s:darkblue   = "17"
  let s:darkcyan   = "24"
  let s:darkred    = "52"
  let s:darkpurple = "53"
endif


let s:line       = HexOrTermColor("#181818", 0)    " Black
let s:darkred    = HexOrTermColor("#76233d", 1)    " Red | Maroon
" let s:darkred    = HexOrTermColor("#96233d", 1)    " Red | Maroon
let s:orange     = HexOrTermColor("#dd9767", 3)    " Yellow | DarkYellow
let s:blue       = HexOrTermColor("#7a88a0", 4)   " Bright Blue | LightBlue
let s:magenta     = HexOrTermColor("#811d31", 5)   " Magenta | LightMagenta
let s:comment    = HexOrTermColor("#5f666d", 7)    " White | LightGrey
" let s:selection  = HexOrTermColor("#373a40", 8)    " White
let s:selection  = HexOrTermColor("#272a30", 8)    " White
" let s:selection  = HexOrTermColor("#2828", 8)    " White

let s:float_bg  = HexOrTermColor("#1b1b1b", 8)    " White
let s:red        = HexOrTermColor("#88314d", 9)    " Bright Red | LightRed

" let s:selection  = HexOrTermColor("#5f666d", 8)    " White

" let s:red        = HexOrTermColor("#c85a80", 9)    " Bright Red | LightRed

let s:green      = HexOrTermColor("#81213b", 10)   " LightGreen
let s:yellow     = HexOrTermColor("#967e7f", 11)   " LightYellow
let s:cursorline  = HexOrTermColor("#1f1f1f", 12)    " Cyan
let s:purple     = HexOrTermColor("#af6a87", 13)   " Magenta Bright | LightMagenta

let s:aqua       = HexOrTermColor("#933d52", 14)   " Cyan Bright | LightCyan


let s:foreground = HexOrTermColor("#999999", 15)   " White


" old 5 -


"}}}
" Formatting Options:"{{{
" ----------------------------------------------------------------------------
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"

"}}}
" Highlighting Primitives:"{{{
" ----------------------------------------------------------------------------
exe "let s:bg_none       = ' ".s:vmode."bg=".s:none      ."'"
exe "let s:bg_foreground = ' ".s:vmode."bg=".s:foreground."'"
exe "let s:bg_background = ' ".s:vmode."bg=".s:background."'"
exe "let s:bg_selection  = ' ".s:vmode."bg=".s:selection ."'"
exe "let s:bg_line       = ' ".s:vmode."bg=".s:line      ."'"
exe "let s:bg_comment    = ' ".s:vmode."bg=".s:comment   ."'"
exe "let s:bg_red        = ' ".s:vmode."bg=".s:red       ."'"
exe "let s:bg_orange     = ' ".s:vmode."bg=".s:orange    ."'"
exe "let s:bg_yellow     = ' ".s:vmode."bg=".s:yellow    ."'"
exe "let s:bg_green      = ' ".s:vmode."bg=".s:green     ."'"
exe "let s:bg_aqua       = ' ".s:vmode."bg=".s:aqua      ."'"
exe "let s:bg_blue       = ' ".s:vmode."bg=".s:blue      ."'"
exe "let s:bg_purple     = ' ".s:vmode."bg=".s:purple    ."'"
exe "let s:bg_magenta     = ' ".s:vmode."bg=".s:magenta    ."'"
exe "let s:bg_window     = ' ".s:vmode."bg=".s:window    ."'"
exe "let s:bg_darkcolumn = ' ".s:vmode."bg=".s:darkcolumn."'"
exe "let s:bg_addbg      = ' ".s:vmode."bg=".s:addbg     ."'"
exe "let s:bg_addfg      = ' ".s:vmode."bg=".s:addfg     ."'"
exe "let s:bg_changebg   = ' ".s:vmode."bg=".s:changebg  ."'"
exe "let s:bg_changefg   = ' ".s:vmode."bg=".s:changefg  ."'"
exe "let s:bg_darkblue   = ' ".s:vmode."bg=".s:darkblue  ."'"
exe "let s:bg_darkcyan   = ' ".s:vmode."bg=".s:darkcyan  ."'"
exe "let s:bg_darkred    = ' ".s:vmode."bg=".s:darkred   ."'"
exe "let s:bg_darkpurple = ' ".s:vmode."bg=".s:darkpurple."'"
exe "let s:bg_cursorline = ' ".s:vmode."bg=".s:cursorline."'"

exe "let s:bg_float_bg = ' ".s:vmode."bg=".s:float_bg."'"

exe "let s:fg_none       = ' ".s:vmode."fg=".s:none      ."'"
exe "let s:fg_foreground = ' ".s:vmode."fg=".s:foreground."'"
exe "let s:fg_background = ' ".s:vmode."fg=".s:background."'"
exe "let s:fg_magenta     = ' ".s:vmode."fg=".s:magenta    ."'"
exe "let s:fg_selection  = ' ".s:vmode."fg=".s:selection ."'"
exe "let s:fg_line       = ' ".s:vmode."fg=".s:line      ."'"
exe "let s:fg_comment    = ' ".s:vmode."fg=".s:comment   ."'"
exe "let s:fg_red        = ' ".s:vmode."fg=".s:red       ."'"
exe "let s:fg_orange     = ' ".s:vmode."fg=".s:orange    ."'"
exe "let s:fg_yellow     = ' ".s:vmode."fg=".s:yellow    ."'"
exe "let s:fg_green      = ' ".s:vmode."fg=".s:green     ."'"
exe "let s:fg_aqua       = ' ".s:vmode."fg=".s:aqua      ."'"
exe "let s:fg_blue       = ' ".s:vmode."fg=".s:blue      ."'"
exe "let s:fg_purple     = ' ".s:vmode."fg=".s:purple    ."'"
exe "let s:fg_window     = ' ".s:vmode."fg=".s:window    ."'"
exe "let s:fg_darkcolumn = ' ".s:vmode."fg=".s:darkcolumn."'"
exe "let s:fg_addbg      = ' ".s:vmode."fg=".s:addbg     ."'"
exe "let s:fg_addfg      = ' ".s:vmode."fg=".s:addfg     ."'"
exe "let s:fg_changebg   = ' ".s:vmode."fg=".s:changebg  ."'"
exe "let s:fg_changefg   = ' ".s:vmode."fg=".s:changefg  ."'"
exe "let s:fg_darkblue   = ' ".s:vmode."fg=".s:darkblue  ."'"
exe "let s:fg_darkcyan   = ' ".s:vmode."fg=".s:darkcyan  ."'"
exe "let s:fg_darkred    = ' ".s:vmode."fg=".s:darkred   ."'"
exe "let s:fg_darkpurple = ' ".s:vmode."fg=".s:darkpurple."'"

exe "let s:fmt_none      = ' ".s:vmode."=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold      = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi      = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_undr      = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb      = ' ".s:vmode."=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi      = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl      = ' ".s:vmode."=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital      = ' ".s:vmode."=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd      = ' ".s:vmode."=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr      = ' ".s:vmode."=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb      = ' ".s:vmode."=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"

" if has("gui_running")
if s:gui
  exe "let s:sp_none       = ' guisp=".s:none      ."'"
  exe "let s:sp_foreground = ' guisp=".s:foreground."'"
  exe "let s:sp_background = ' guisp=".s:background."'"
  exe "let s:sp_selection  = ' guisp=".s:selection ."'"
  exe "let s:sp_line       = ' guisp=".s:line      ."'"
  exe "let s:sp_comment    = ' guisp=".s:comment   ."'"
  exe "let s:sp_red        = ' guisp=".s:red       ."'"
  exe "let s:sp_orange     = ' guisp=".s:orange    ."'"
  exe "let s:sp_yellow     = ' guisp=".s:yellow    ."'"
  exe "let s:sp_green      = ' guisp=".s:green     ."'"
  exe "let s:sp_aqua       = ' guisp=".s:aqua      ."'"
  exe "let s:sp_blue       = ' guisp=".s:blue      ."'"
  exe "let s:sp_purple     = ' guisp=".s:purple    ."'"
  exe "let s:sp_window     = ' guisp=".s:window    ."'"
  exe "let s:sp_addbg      = ' guisp=".s:addbg     ."'"
  exe "let s:sp_addfg      = ' guisp=".s:addfg     ."'"
  exe "let s:sp_changebg   = ' guisp=".s:changebg  ."'"
  exe "let s:sp_changefg   = ' guisp=".s:changefg  ."'"
  exe "let s:sp_darkblue   = ' guisp=".s:darkblue  ."'"
  exe "let s:sp_darkcyan   = ' guisp=".s:darkcyan  ."'"
  exe "let s:sp_darkred    = ' guisp=".s:darkred   ."'"
  exe "let s:sp_darkpurple = ' guisp=".s:darkpurple."'"
else
  let s:sp_none       = ""
  let s:sp_foreground = ""
  let s:sp_background = ""
  let s:sp_selection  = ""
  let s:sp_line       = ""
  let s:sp_comment    = ""
  let s:sp_red        = ""
  let s:sp_orange     = ""
  let s:sp_yellow     = ""
  let s:sp_green      = ""
  let s:sp_aqua       = ""
  let s:sp_blue       = ""
  let s:sp_purple     = ""
  let s:sp_window     = ""
  let s:sp_addbg      = ""
  let s:sp_addfg      = ""
  let s:sp_changebg   = ""
  let s:sp_changefg   = ""
  let s:sp_darkblue   = ""
  let s:sp_darkcyan   = ""
  let s:sp_darkred    = ""
  let s:sp_darkpurple = ""
endif

"}}}
" Vim Highlighting: (see :help highlight-groups)"{{{
" ----------------------------------------------------------------------------
exe "hi! ColorColumn"   .s:fg_none        .s:bg_line        .s:fmt_none
"   Conceal"
"   Cursor"
"   CursorIM"
exe "hi! CursorColumn"  .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_cursorline       .s:fmt_none
exe "hi! TreesitterContext"    .s:fg_none        .s:bg_cursorline       .s:fmt_none
exe "hi! Context"    .s:fg_magenta        .s:bg_cursorline       .s:fmt_none

exe "hi! Directory"     .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_addfg       .s:bg_addbg       .s:fmt_none
exe "hi! DiffChange"    .s:fg_changefg    .s:bg_changebg    .s:fmt_none
exe "hi! DiffDelete"    .s:fg_background  .s:bg_red         .s:fmt_none
exe "hi! DiffText"      .s:fg_background  .s:bg_blue        .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_background  .s:bg_red         .s:fmt_stnd
exe "hi! VertSplit"     .s:fg_window      .s:bg_none        .s:fmt_none
exe "hi! Folded"        .s:fg_comment     .s:bg_darkcolumn  .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_darkcolumn  .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_darkcolumn  .s:fmt_none
"   Incsearch"
exe "hi! LineNr"        .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! CursorLineNr"  .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! MatchParen"    .s:fg_background  .s:bg_changebg    .s:fmt_none
exe "hi! ModeMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_foreground  .s:bg_selection   .s:fmt_none

exe "hi! MiniTrailspace"         .s:fg_foreground  .s:bg_selection   .s:fmt_none

exe "hi! ModifiedBuffer" .s:fg_yellow  .s:bg_magenta   .s:fmt_none

exe "hi! PmenuSel"      .s:fg_foreground  .s:bg_selection   .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"

" exe "hi! IncSearch" .s:fg_yellow .s:bg_magenta. s:fmt_none
" exe "hi! CurSearch" .s:fg_line .s:bg_blue. s:fmt_none

" exe "hi! LocalSearch" .s:fg_yellow .s:bg_magenta. s:fmt_none

" hi! LocalSearch guibg=#470000
hi! CurSearch guibg=#470000 guifg=#999999

" hi! CurSearch guibg=#152238
hi! LocalSearch guibg=#142b58

hi! ObsidianBullet guifg=#96233d
hi! ObsidianUI guifg=#96233d


exe "hi! FloatFilename" .s:fg_magenta .s:bg_float_bg. s:fmt_none
exe "hi! FloatFilenameChange" .s:fg_yellow .s:bg_magenta. s:fmt_none

exe "hi! Question"      .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_background  .s:bg_yellow      .s:fmt_none
exe "hi! SpecialKey"    .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_magenta        .s:bg_none    .s:fmt_none
exe "hi! SpellLocal"    .s:fg_aqua        .s:bg_darkcyan    .s:fmt_undr
exe "hi! SpellBad"      .s:fg_red         .s:bg_darkred     .s:fmt_undr
exe "hi! SpellRare"     .s:fg_purple      .s:bg_darkpurple  .s:fmt_undr
exe "hi! StatusLine"    .s:fg_background  .s:bg_comment  .s:fmt_revr
exe "hi! StatusLineNC"  .s:fg_background  .s:bg_selection     .s:fmt_revr
exe "hi! TabLine"       .s:fg_foreground  .s:bg_darkcolumn  .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
exe "hi! Title"         .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_none        .s:bg_selection   .s:fmt_none

hi Visual guibg=#152238


hi! IlluminatedWordText        guibg=#1c2d4d
hi! IlluminatedWordRead        guibg=#1c2d4d
hi! IlluminatedWordWrite       guibg=#1c2d4d

hi SearchxMarker ctermfg=20  ctermbg=159 guifg=NONE guibg=#1c2e4a
"   VisualNos"
exe "hi! WarningMsg"    .s:fg_red         .s:bg_none        .s:fmt_none
" hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
"   WildMenu"

exe "hi! NvimTreeNormalFloat"        .s:fg_yellow  .s:bg_none        .s:fmt_none
exe "hi! NvimTreeFolderIcon"        .s:fg_darkred  .s:bg_none        .s:fmt_none

" Use Xresources for background colour
" if has('gui_running') || g:hybrid_use_Xresources != 1
if s:gui
  exe "hi! Normal"        .s:fg_foreground  .s:bg_background  .s:fmt_none
  exe "hi! NormalFloat"        .s:fg_foreground  .s:bg_background  .s:fmt_none
else
  exe "hi! NormalFloat"        .s:fg_foreground  .s:bg_none        .s:fmt_none
endif

"}}}
" Generic Syntax Highlighting: (see :help group-name)"{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"         .s:fg_comment     .s:bg_none        .s:fmt_none

exe "hi! TabLine"         .s:fg_comment     .s:bg_background        .s:fmt_none
exe "hi! TabLineFill"     .s:fg_background  .s:bg_background        .s:fmt_none
exe "hi! TabLineSel"      .s:fg_magenta     .s:bg_background        .s:fmt_none


exe "hi! Constant"        .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! String"          .s:fg_magenta       .s:bg_none        .s:fmt_none
exe "hi! QuickFixLine"          .s:fg_darkred       .s:bg_none        .s:fmt_none
exe "hi! Number"          .s:fg_purple       .s:bg_none        .s:fmt_none
"   Character"
"   Number"
"   Boolean"
"   Float"

exe "hi! Identifier"      .s:fg_purple      .s:bg_none        .s:fmt_none
exe "hi! Function"        .s:fg_aqua      .s:bg_none        .s:fmt_none

exe "hi! Statement"       .s:fg_blue        .s:bg_none        .s:fmt_none
"   Conditional"
"   Repeat"
"   Label"
exe "hi! Operator"        .s:fg_blue        .s:bg_none        .s:fmt_none
"   Keyword"
"   Exception"

exe "hi! PreProc"         .s:fg_blue        .s:bg_none        .s:fmt_none
"   Include"
"   Define"
"   Macro"
"   PreCondit"

exe "hi! Type"            .s:fg_aqua      .s:bg_none        .s:fmt_none
"   StorageClass"
exe "hi! Structure"       .s:fg_green        .s:bg_none        .s:fmt_none
"   Typedef"

exe "hi! Special"         .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Delimiter"         .s:fg_darkred       .s:bg_none        .s:fmt_none
"   SpecialChar"
"   Tag"
"   Delimiter"
"   SpecialComment"
"   Debug"
"
exe "hi! Underlined"      .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! Ignore"          .s:fg_none        .s:bg_none        .s:fmt_none
exe "hi! Error"           .s:fg_yellow         .s:bg_magenta     .s:fmt_undr
exe "hi! Todo"            .s:fg_addfg       .s:bg_none        .s:fmt_none

" Quickfix window highlighting
exe "hi! qfLineNr"        .s:fg_yellow      .s:bg_none        .s:fmt_none
"   qfFileName"
"   qfLineNr"
"   qfError"


exe "hi! TroubleSignInformation"        .s:fg_comment      .s:bg_none        .s:fmt_none
exe "hi! Label"        .s:fg_comment      .s:bg_none        .s:fmt_none
exe "hi! NoiceFormatTitle                     "        .s:fg_foreground      .s:bg_none        .s:fmt_none
exe "hi! Title"        .s:fg_darkred      .s:bg_none        .s:fmt_none
exe "hi! DiagnosticSignInfo"        .s:fg_blue      .s:bg_none        .s:fmt_none
" exe "hi! NormalFloat"        .s:fg_blue      .s:bg_none        .s:fmt_none
" exe "hi! NormalFloat"        .s:fg_comment      .s:bg_none        .s:fmt_none
exe "hi! NoiceMini"        .s:fg_comment      .s:bg_none        .s:fmt_none

exe "hi! NotifyINFOTitle"        .s:fg_blue      .s:bg_none        .s:fmt_none
exe "hi! NotifyINFOBorder"        .s:fg_blue      .s:bg_none        .s:fmt_none
exe "hi! NotifyINFOBody"        .s:fg_blue      .s:bg_none        .s:fmt_none
exe "hi! NotifyINFOIcon"        .s:fg_blue      .s:bg_none        .s:fmt_none


exe "hi! DiagnosticError"        .s:fg_red      .s:bg_none        .s:fmt_none
exe "hi! DiagnosticWarn"        .s:fg_aqua      .s:bg_none        .s:fmt_none
exe "hi! DiagnosticInfo"        .s:fg_blue      .s:bg_none        .s:fmt_none
exe "hi! DiagnosticHint"        .s:fg_blue      .s:bg_none        .s:fmt_none
exe "hi! HighlightUndo"        .s:fg_none      .s:bg_selection        .s:fmt_none

" hi LucyLine ctermfg=20  ctermbg=159 guifg=NONE guibg=#421010
hi LucyLine guibg=#22000d



"}}}
" Diff Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
" Diff
"   diffOldFile
"   diffNewFile
"   diffFile
"   diffOnly
"   diffIdentical
"   diffDiffer
"   diffBDiffer
"   diffIsA
"   diffNoEOL
"   diffCommon
hi! link diffRemoved Constant
"   diffChanged
hi! link diffAdded Special
"   diffLine
"   diffSubname
"   diffComment

" highlight NotifyERRORBorder guifg=#8A1F1F
" highlight NotifyWARNBorder guifg=#79491D
" highlight NotifyINFOBorder guifg=#4F6752
" highlight NotifyDEBUGBorder guifg=#8B8B8B
" highlight NotifyTRACEBorder guifg=#4F3552
" highlight NotifyERRORIcon guifg=#F70067
" highlight NotifyWARNIcon guifg=#F79000
" highlight NotifyINFOIcon guifg=#A9FF68
" highlight NotifyDEBUGIcon guifg=#8B8B8B
" highlight NotifyTRACEIcon guifg=#D484FF
" highlight NotifyERRORTitle  guifg=#F70067
" highlight NotifyWARNTitle guifg=#F79000

" highlight NotifyINFOTitle guifg=#A9FF68
" highlight NotifyDEBUGTitle  guifg=#8B8B8B
" highlight NotifyTRACETitle  guifg=#D484FF
" highlight link NotifyERRORBody Normal
" highlight link NotifyWARNBody Normal
" highlight link NotifyINFOBody Normal
" highlight link NotifyDEBUGBody Normal
" highlight link NotifyTRACEBody Normal

hi clear Search
hi clear IncSearch

hi @variable guifg=#999999
hi WinSeparator guifg=#373a40

hi HighlightUndo guibg=#102030
hi! link HighlightRedo HighlightUndo
hi CodeBlock guibg=#202020 guifg=#808080
hi HeadLine guifg=#7a88a0 guibg=#1c1c1c

hi! ModifiedBuffer guibg=#56031d guifg=#888888
hi! link FloatFilenameChange ModifiedBuffer
