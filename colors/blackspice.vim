" colors/blackspice.vim

if version > 580
  hi clear
  if exists('syntax_on')
    syntax reset
  endif
endif
let g:colors_name = 'blackspice'

" Require truecolor or 256-color terminal
if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co < 256
  finish
endif

let s:is_light = (&background ==# 'light')

let s:p = {
\ 'none'            : ['NONE', 'NONE'],
\ 'bg'              : ['#132123', 233],
\ 'surface'         : ['#2c393a', 235],
\ 'surface2'        : ['#162122', 237],
\ 'surface3'        : ['#121b1c', 238],
\ 'border'          : ['#2a3737', 239],
\ 'line'            : ['#2a3737', 240],
\ 'muted'           : ['#627d9d', 241],
\ 'fg_dim'          : ['#c6b8ad', 251],
\ 'fg'              : ['#f2ecde', 253],
\ 'accent.yellow'   : ['#dcb659', 221],
\ 'accent.green'    : ['#46a68b', 118],
\ 'accent.purple'   : ['#b759dc', 171],
\ 'accent.pink'     : ['#dc59c0', 206],
\ 'accent.orange'   : ['#dc7759', 206],
\ 'accent.error'    : ['#d32c5d', 204],
\ 'accent.warn'     : ['#dc7759', 209],
\ 'accent.info'     : ['#59dcd8', 80],
\ 'accent.hint'     : ['#7bce9e', 50],
\ 'accent.primary'  : ['#7bce9e', 50]
\ }

if s:is_light
  let s:p['fg_dim']           = s:p['surface']
  let s:p['fg']               = s:p['bg']
  let s:p['bg']               = ['#f6fbd6', 230]
  let s:p['surface']          = ['#c7c7ba', 187]
  let s:p['surface2']         = ['#aaaa97', 144]
  let s:p['accent.info']      = ['#289cbc', 38]
  let s:p['accent.yellow']    = ['#A58023', 136]
endif

" Terminal palette mapping (Neovim + Vim)
if has('nvim')
  let g:terminal_color_0  = s:p['bg'][0]
  let g:terminal_color_8  = s:p['border'][0]
  let g:terminal_color_1  = s:p['accent.error'][0]
  let g:terminal_color_9  = s:p['accent.error'][0]
  let g:terminal_color_2  = s:p['accent.green'][0]
  let g:terminal_color_10 = s:p['accent.green'][0]
  let g:terminal_color_3  = s:p['accent.warn'][0]
  let g:terminal_color_11 = s:p['accent.yellow'][0]
  let g:terminal_color_4  = s:p['accent.info'][0]
  let g:terminal_color_12 = s:p['accent.info'][0]
  let g:terminal_color_5  = s:p['accent.purple'][0]
  let g:terminal_color_13 = s:p['accent.pink'][0]
  let g:terminal_color_6  = s:p['accent.hint'][0]
  let g:terminal_color_14 = s:p['accent.hint'][0]
  let g:terminal_color_7  = s:p['fg_dim'][0]
  let g:terminal_color_15 = s:p['fg'][0]
endif

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)
  let g:terminal_ansi_colors[0]  = s:p['bg'][0]
  let g:terminal_ansi_colors[8]  = s:p['border'][0]
  let g:terminal_ansi_colors[1]  = s:p['accent.error'][0]
  let g:terminal_ansi_colors[9]  = s:p['accent.error'][0]
  let g:terminal_ansi_colors[2]  = s:p['accent.green'][0]
  let g:terminal_ansi_colors[10] = s:p['accent.green'][0]
  let g:terminal_ansi_colors[3]  = s:p['accent.warn'][0]
  let g:terminal_ansi_colors[11] = s:p['accent.yellow'][0]
  let g:terminal_ansi_colors[4]  = s:p['accent.info'][0]
  let g:terminal_ansi_colors[12] = s:p['accent.info'][0]
  let g:terminal_ansi_colors[5]  = s:p['accent.purple'][0]
  let g:terminal_ansi_colors[13] = s:p['accent.pink'][0]
  let g:terminal_ansi_colors[6]  = s:p['accent.hint'][0]
  let g:terminal_ansi_colors[14] = s:p['accent.hint'][0]
  let g:terminal_ansi_colors[7]  = s:p['fg_dim'][0]
  let g:terminal_ansi_colors[15] = s:p['fg'][0]
endif

function! s:Hi(group, opts) abort
  let l:fgk = get(a:opts, 'fg', 'none')
  let l:bgk = get(a:opts, 'bg', 'none')
  let l:spk = get(a:opts, 'sp', 'none')
  let l:sty = get(a:opts, 'style', 'NONE')

  let l:fg = get(s:p, l:fgk, s:p['none'])
  let l:bg = get(s:p, l:bgk, s:p['none'])
  let l:sp = get(s:p, l:spk, s:p['none'])

  execute printf(
  \ 'hi %s guifg=%s ctermfg=%s guibg=%s ctermbg=%s gui=%s cterm=%s guisp=%s',
  \ a:group, l:fg[0], l:fg[1], l:bg[0], l:bg[1], l:sty, l:sty, l:sp[0]
  \ )
endfunction

" UI
call s:Hi('Normal',      {'fg':'fg',     'bg':'bg'})
call s:Hi('NormalFloat', {'fg':'fg',     'bg':'surface'})
call s:Hi('EndOfBuffer', {'fg':'bg',     'bg':'bg'})
call s:Hi('Cursor',      {'fg':'fg_dim', 'style':'reverse'})
call s:Hi('CursorLine',  {'bg':'surface'})
call s:Hi('CursorColumn',{'bg':'surface'})
call s:Hi('LineNr',      {'fg':'fg_dim', 'bg':'bg'})
call s:Hi('CursorLineNr',{'fg':'accent.hint','bg':'surface2','style':'bold'})
call s:Hi('SignColumn',  {'bg':'bg'})
call s:Hi('ColorColumn', {'bg':'surface'})
call s:Hi('Visual',      {'style':'reverse'})
call s:Hi('MatchParen',  {'bg':'border', 'style':'bold'})

" Search
call s:Hi('Search',      {'style':'underline', 'sp':'accent.yellow'})
call s:Hi('CurSearch',   {'fg':'bg', 'bg':'surface', 'style':'bold'})
call s:Hi('IncSearch',   {'fg':'bg', 'bg':'surface', 'style':'bold'})

call s:Hi('Pmenu',       {'fg':'fg_dim','bg':'surface'})
call s:Hi('PmenuSel',    {'fg':'fg', 'bg':'surface','style':'bold'})
call s:Hi('PmenuSbar',   {'bg':'surface'})
call s:Hi('PmenuThumb',  {'bg':'border'})

call s:Hi('StatusLine',  {'fg':'fg',    'bg':'surface3'})
call s:Hi('StatusLineNC',{'fg':'bg',    'bg':'surface3'})
call s:Hi('VertSplit',   {'fg':'surface2','bg':'surface3'})
call s:Hi('WinSeparator',{'fg':'surface2','bg':'surface3'}) " Vim/Neovim newer split group

call s:Hi('Folded',      {'fg':'fg_dim','bg':'surface2'})
call s:Hi('NonText',     {'fg':'muted'})
call s:Hi('Conceal',     {'fg':'muted'})

" Messages
call s:Hi('ErrorMsg',    {'fg':'accent.error','bg':'bg','style':'bold'})
call s:Hi('WarningMsg',  {'fg':'accent.warn', 'bg':'bg','style':'bold'})
call s:Hi('ModeMsg',     {'fg':'fg_dim','bg':'bg'})
call s:Hi('MoreMsg',     {'fg':'fg_dim','bg':'bg'})
call s:Hi('Question',    {'fg':'fg_dim','bg':'bg'})

" Diffs
call s:Hi('DiffAdd',     {'fg':'accent.green','bg':'surface'})
call s:Hi('DiffChange',  {'fg':'accent.yellow','bg':'surface'})
call s:Hi('DiffDelete',  {'fg':'accent.error','bg':'surface'})
call s:Hi('DiffText',    {'fg':'fg','bg':'surface2','style':'bold'})

" Diagnostics
call s:Hi('DiagnosticError', {'fg':'accent.error'})
call s:Hi('DiagnosticWarn',  {'fg':'accent.warn'})
call s:Hi('DiagnosticInfo',  {'fg':'accent.info'})
call s:Hi('DiagnosticHint',  {'fg':'accent.hint'})

call s:Hi('DiagnosticUnderlineError', {'style':'underline', 'sp':'accent.error'})
call s:Hi('DiagnosticUnderlineWarn',  {'style':'underline', 'sp':'accent.warn'})
call s:Hi('DiagnosticUnderlineInfo',  {'style':'underline', 'sp':'accent.info'})
call s:Hi('DiagnosticUnderlineHint',  {'style':'underline', 'sp':'accent.hint'})

" Core syntax
call s:Hi('Comment',     {'fg':'muted','style':'italic'})
call s:Hi('Constant',    {'fg':'accent.green'})
call s:Hi('String',      {'fg':'fg_dim'})
call s:Hi('Character',   {'fg':'accent.orange'})
call s:Hi('Number',      {'fg':'accent.green'})
call s:Hi('Boolean',     {'fg':'accent.green'})
call s:Hi('Float',       {'fg':'accent.green'})
call s:Hi('Identifier',  {'fg':'fg'})
call s:Hi('Function',    {'fg':'accent.primary'})
call s:Hi('Statement',   {'fg':'accent.primary'})
call s:Hi('Conditional', {'fg':'fg_dim'})
call s:Hi('Repeat',      {'fg':'fg'})
call s:Hi('Keyword',     {'fg':'accent.yellow'})
call s:Hi('Operator',    {'fg':'accent.orange'})
call s:Hi('PreProc',     {'fg':'accent.orange'})
call s:Hi('Type',        {'fg':'accent.yellow'})
call s:Hi('Special',     {'fg':'accent.orange'})
call s:Hi('Delimiter',   {'fg':'accent.orange'})
call s:Hi('Underlined',  {'fg':'accent.yellow','style':'underline'})
call s:Hi('Todo',        {'fg':'accent.info','style':'bold'})
call s:Hi('Error',       {'bg':'accent.error','style':'bold'})
call s:Hi('Label',       {'fg':'fg_dim'})                 " used by some syntaxes / TSLabel
call s:Hi('Title',       {'fg':'fg_dim', 'style':'bold'})      " used by MsgArea/gitcommit/etc

" ---------------------------------------------------------------------------
" Links / integrations
" Note: make s:Link silent so missing plugin groups never error.
" ---------------------------------------------------------------------------
function! s:Link(from, to) abort
  execute 'silent! hi! link ' . a:from . ' ' . a:to
endfunction

" Extra semantic groups used by older configs/plugins
call s:Hi('InfoMsg',           {'fg':'accent.info', 'bg':'bg'})
call s:Hi('HintMsg',           {'fg':'accent.hint', 'bg':'bg'})
call s:Hi('WarnMsg',           {'fg':'accent.warn', 'bg':'bg'}) " convenience alias

call s:Hi('ErrorMsgInverse',   {'fg':'bg', 'bg':'accent.error', 'style':'bold'})
call s:Hi('WarningMsgInverse', {'fg':'bg', 'bg':'accent.warn',  'style':'bold'})
call s:Hi('InfoMsgInverse',    {'fg':'bg', 'bg':'accent.info',  'style':'bold'})
call s:Hi('HintMsgInverse',    {'fg':'bg', 'bg':'accent.hint',  'style':'bold'})

" Common UI groups some plugins expect
call s:Hi('Directory',         {'fg':'accent.hint'})
call s:Hi('Ignore',            {'fg':'muted'})
call s:Hi('StringDelimiter',   {'fg':'accent.hint'}) " used by markdown 'Quote' mapping sometimes

" ---------------------------------------------------------------------------
" “Alias” groups used by various syntax files (non-standard group names)
" ---------------------------------------------------------------------------
call s:Link('FunctionDef',   'Function')
call s:Link('LibraryFunc',   'Function')
call s:Link('LocalFunc',     'Function')

call s:Link('LibraryIdent',  'Identifier')
call s:Link('LocalIdent',    'Identifier')
call s:Link('IdentifierDef', 'Identifier')

call s:Link('LibraryType',   'Type')
call s:Link('LocalType',     'Type')

call s:Link('Noise',         'Delimiter')
call s:Link('Quote',         'StringDelimiter')
call s:Link('Searchlight',   'Search')

call s:Link('StatusLineTerm',   'StatusLine')
call s:Link('StatusLineTermNC', 'StatusLineNC')
call s:Link('Terminal',         'Normal')

" ---------------------------------------------------------------------------
" Plugin: ALE
" ---------------------------------------------------------------------------
call s:Link('ALEVirtualTextError',   'DiagnosticError')
call s:Link('ALEVirtualTextWarning', 'DiagnosticWarn')

" ---------------------------------------------------------------------------
" Plugin: buftabline
" ---------------------------------------------------------------------------
call s:Link('BufTabLineCurrent', 'Pmenu')
call s:Link('BufTabLineActive',  'PmenuSel')

" ---------------------------------------------------------------------------
" Plugin: Signify (define directly so you don’t need an extra 'Signify' group)
" ---------------------------------------------------------------------------
call s:Hi('SignifySignAdd',    {'fg':'accent.green', 'bg':'bg'})
call s:Hi('SignifySignChange', {'fg':'accent.yellow', 'bg':'bg'})
call s:Hi('SignifySignDelete', {'fg':'accent.error', 'bg':'bg'})

" ---------------------------------------------------------------------------
" Plugin: coc.nvim (map to semantic groups + proper undercurl color)
" ---------------------------------------------------------------------------
call s:Link('CocErrorSign',        'ErrorMsg')
call s:Link('CocWarningSign',      'WarningMsg')
call s:Link('CocInfoSign',         'InfoMsg')
call s:Link('CocHintSign',         'HintMsg')

call s:Link('CocErrorFloat',       'ErrorMsg')
call s:Link('CocWarningFloat',     'WarningMsg')
call s:Link('CocInfoFloat',        'InfoMsg')
call s:Link('CocHintFloat',        'HintMsg')

call s:Link('CocDiagnosticsError', 'DiagnosticError')
call s:Link('CocDiagnosticsWarning','DiagnosticWarn')
call s:Link('CocDiagnosticsInfo',  'DiagnosticInfo')
call s:Link('CocDiagnosticsHint',  'DiagnosticHint')

call s:Hi('CocSelectedText',       {'fg':'accent.error', 'style':'bold'})
call s:Hi('CocCodeLens',           {'fg':'border'})

call s:Hi('CocErrorHighlight',     {'style':'underline,bold', 'sp':'accent.error'})
call s:Link('CocWarningHighlight', 'CocErrorHighlight')
call s:Link('CocInfoHighlight',    'CocErrorHighlight')
call s:Link('CocHintHighlight',    'CocErrorHighlight')

" ---------------------------------------------------------------------------
" Neovim LSP (older group names still seen in configs)
" ---------------------------------------------------------------------------
call s:Link('LspDiagnosticsDefaultError',       'DiagnosticError')
call s:Link('LspDiagnosticsDefaultWarning',     'DiagnosticWarn')
call s:Link('LspDiagnosticsDefaultInformation', 'DiagnosticInfo')
call s:Link('LspDiagnosticsDefaultHint',        'DiagnosticHint')

call s:Link('LspDiagnosticsError',       'LspDiagnosticsDefaultError')
call s:Link('LspDiagnosticsWarning',     'LspDiagnosticsDefaultWarning')
call s:Link('LspDiagnosticsInformation', 'LspDiagnosticsDefaultInformation')
call s:Link('LspDiagnosticsHint',        'LspDiagnosticsDefaultHint')

call s:Link('LspDiagnosticsSignError',       'ErrorMsgInverse')
call s:Link('LspDiagnosticsSignWarning',     'WarningMsgInverse')
call s:Link('LspDiagnosticsSignInformation', 'InfoMsgInverse')
call s:Link('LspDiagnosticsSignHint',        'HintMsgInverse')

" ---------------------------------------------------------------------------
" Filetype: C
" ---------------------------------------------------------------------------
call s:Link('cInclude',   'PreProc')
call s:Link('cIncluded',  'Directory')
call s:Link('cSpecial',   'Special')
call s:Link('cRepeat',    'Keyword')
call s:Link('cLabel',     'Operator')
call s:Link('cConstant',  'Number')

" ---------------------------------------------------------------------------
" Filetype: CSS
" ---------------------------------------------------------------------------
call s:Link('cssClassName',       'Type')
call s:Link('cssPseudoClassId',   'PreProc')
call s:Link('cssIdentifier',      'Identifier')
call s:Link('cssFunctionName',    'FunctionDef')
call s:Link('cssCustomProp',      'Identifier')
call s:Link('cssFunctionComma',   'Delimiter')
call s:Link('cssBraces',          'Delimiter')
call s:Link('cssSelectorOp',      'Operator')
call s:Link('cssSelectorOp2',     'Operator')

" ---------------------------------------------------------------------------
" Filetype: diff
" ---------------------------------------------------------------------------
call s:Link('diffAdded',      'DiffAdd')
call s:Link('diffChanged',    'DiffChange')
call s:Link('diffRemoved',    'DiffDelete')
call s:Link('diffBDiffer',    'WarningMsg')
call s:Link('diffCommon',     'WarningMsg')
call s:Link('diffDiffer',     'WarningMsg')
call s:Link('diffFile',       'Directory')
call s:Link('diffIdentical',  'WarningMsg')
call s:Link('diffIndexLine',  'Number')
call s:Link('diffIsA',        'WarningMsg')
call s:Link('diffNoEOL',      'WarningMsg')
call s:Link('diffOnly',       'WarningMsg')

" ---------------------------------------------------------------------------
" Filetype: gitcommit
" ---------------------------------------------------------------------------
call s:Link('gitcommitHeader',   'Todo')
call s:Link('gitcommitOverflow', 'Error')
call s:Link('gitcommitSummary',  'Title')

" ---------------------------------------------------------------------------
" Filetype: HTML
" ---------------------------------------------------------------------------
call s:Link('htmlTag',         'Operator')
call s:Link('htmlEndTag',      'htmlTag')
call s:Link('htmlSpecialChar', 'Special')

" ---------------------------------------------------------------------------
" Filetype: JavaScript
" ---------------------------------------------------------------------------
call s:Link('jsArrowFunction',   'PreProc')
call s:Link('jsFunction',        'FunctionDef')
call s:Link('jsOperatorKeyword', 'Keyword')
call s:Link('jsGlobalObjects',   'Type')
call s:Link('jsSpecial',         'Special')
call s:Link('jsExport',          'Type')

" ---------------------------------------------------------------------------
" Filetype: Markdown (define a few directly for better results)
" ---------------------------------------------------------------------------
call s:Hi('markdownH1',         {'fg':'accent.yellow', 'style':'bold'})
call s:Link('markdownH2',       'markdownH1')
call s:Link('markdownH3',       'markdownH1')
call s:Link('markdownH4',       'markdownH1')
call s:Link('markdownH5',       'markdownH1')

call s:Hi('markdownLinkText',   {'fg':'accent.error', 'style':'underline'})
call s:Link('markdownUrl',      'Underlined')
call s:Hi('markdownBold',       {'style':'bold'})
call s:Link('markdownCode',     'String')
call s:Link('markdownHeadingRule',      'Operator')
call s:Link('markdownHeadingDelimiter', 'Operator')
call s:Link('markdownCodeDelimiter',    'Operator')
call s:Link('markdownListMarker',       'Operator')

" ---------------------------------------------------------------------------
" Filetype: shell
" ---------------------------------------------------------------------------
call s:Link('shVariable',   'Identifier')
call s:Link('shAlias',      'shVariable')
call s:Link('shDeref',      'Type')
call s:Link('shConditional','Keyword')
call s:Link('shStatement',  'Keyword')
call s:Link('shSet',        'Keyword')
call s:Link('shSetList',    'Identifier')
call s:Link('shQuote',      'Quote')
call s:Link('shSnglCase',   'Operator')
call s:Link('shTestOpr',    'Operator')
call s:Link('shVarAssign',  'Operator')
call s:Link('shEscape',     'Special')
call s:Link('shOption',     'Keyword')
call s:Link('shDblBrace',   'Operator')
call s:Link('shSpecial',    'shEscape')
call s:Link('shSpecialDQ',  'shSpecial')
call s:Link('shSpecialSQ',  'shSpecial')

" ---------------------------------------------------------------------------
" Filetype: Python
" ---------------------------------------------------------------------------
call s:Link('pythonClass',    'Type')
call s:Link('pythonClassVar', 'Operator')
call s:Link('pythonOperator', 'Operator')
call s:Link('pythonRun',      'PreProc')

" ---------------------------------------------------------------------------
" Filetype: Rust
" ---------------------------------------------------------------------------
call s:Link('rustMacro',           'PreProc')
call s:Link('rustAttribute',       'PreProc')
call s:Link('rustDerive',          'PreProc')
call s:Link('rustSelf',            'Type')
call s:Link('rustFuncName',        'FunctionDef')
call s:Link('rustIdentifier',      'Identifier')
call s:Link('rustType',            'LibraryType')
call s:Link('rustStorage',         'Keyword')
call s:Link('rustEnumVariant',     'Type')
call s:Link('rustConditional',     'Keyword')
call s:Link('rustRepeat',          'Keyword')
call s:Link('rustSigil',           'Operator')
call s:Link('rustCommentLineDoc',  'PreProc')
call s:Link('rustQuestionMark',    'Operator')
call s:Link('rustModPath',         'Type')

" ---------------------------------------------------------------------------
" Filetype: Vimscript
" ---------------------------------------------------------------------------
call s:Link('vimVar',      'Identifier')
call s:Link('vimOper',     'Operator')
call s:Link('vimLet',      'Keyword')
call s:Link('vimNotFunc',  'Keyword')
call s:Link('vimCommand',  'Keyword')
call s:Link('vimHiGroup',  'Type')
call s:Link('vimGroup',    'Type')
call s:Link('vimContinue', 'vimOper')
call s:Link('vimUserFunc', 'Function')

" ---------------------------------------------------------------------------
" TS/TSX operator + bracket normalization
" ---------------------------------------------------------------------------

" White brackets group
call s:Hi('BlackspiceBrackets', {'fg':'fg'})
call s:Link('typescriptArrowFunc',   'Operator')
call s:Link('typescriptOpSymbols',   'Operator')
call s:Link('typescriptLogicSymbols','Operator')
call s:Link('typescriptBinaryOp',    'Operator')
call s:Link('typescriptAssign',      'Operator')
call s:Link('typescriptBraces',      'BlackspiceBrackets')
call s:Link('typescriptParens',      'BlackspiceBrackets')
call s:Link('typescriptBrackets',    'BlackspiceBrackets')

call s:Link('typescriptIdentifierName',      'Identifier')
call s:Link('typescriptIdentifier',          'Identifier')
call s:Link('typescriptParameter',           'Identifier')
call s:Link('typescriptPropertyName',        'Identifier')
call s:Link('typescriptObjectLabel',         'Identifier')
call s:Link('typescriptDestructureVariable', 'Identifier')
call s:Link('typescriptFuncName',            'FunctionDef')
call s:Link('typescriptMethodName',          'FunctionDef')
call s:Link('typescriptCall',                'Function')

call s:Link('typescriptType',               'Type')
call s:Link('typescriptTypeReference',      'Identifier')
call s:Link('typescriptTypeAnnotation',     'Operator')

" call s:Link('typescriptTypeParameter',      'Type')
call s:Link('typescriptInterfaceName',      'Type')
call s:Link('typescriptClassName',          'Type')
call s:Link('typescriptEnumName',           'Type')

call s:Link('typescriptAliasDeclaration',   'Type')
call s:Link('typescriptAliasKeyWord',       'Operator')
call s:Link('typescriptInterfaceKeyword',   'Operator')

call s:Link('typescriptImport', 'Keyword')
call s:Link('typescriptExport', 'Keyword')

call s:Link('typescriptVariable',           'Keyword')
call s:Link('typescriptBlock',              'FunctionDef')
call s:Link('typescriptStatementKeyword',   'Identifier')
call s:Link('typescriptDefaultImportName',  'Identifier')
call s:Link('typescriptTypeBlock',          'Identifier')


call s:Link('tsxTagDelimiter', 'Delimiter')
call s:Link('tsxCloseTag',     'htmlEndTag')
call s:Link('tsxTagName',      'htmlTag')
call s:Link('tsxAttribName',   'Identifier')

call s:Link('jsxTagName',       'Comment')
call s:Link('jsxAttrib',        'Function')
call s:Link('jsxAttribKeyword', 'Identifier')

" ---------------------------------------------------------------------------
"  JSON
" ---------------------------------------------------------------------------
call s:Link('jsonQuote', 'Identifier')
call s:Link('jsonKeyword', 'Identifier')
call s:Link('jsonNoise', 'Identifier')

let g:blackspice_palette = copy(s:p)
