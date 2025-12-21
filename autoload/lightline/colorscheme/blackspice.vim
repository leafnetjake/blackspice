" autoload/lightline/colorscheme/blackspice.vim
"
" Lightline palette for blackspice (semantic keys)

if !exists('g:lightline')
  finish
endif

" Prefer palette exported by colorscheme (hex + cterm index)
let s:pal = exists('g:blackspice_palette') ? g:blackspice_palette : {}

" Hex colors for lightline (lightline uses gui colors here)
let s:bg       = s:pal['bg'][0]
let s:surface  = s:pal['surface'][0]
let s:surface2 = s:pal['surface2'][0]
let s:border   = s:pal['border'][0]
let s:line     = s:pal['line'][0]
let s:muted    = s:pal['muted'][0]
let s:fg_dim   = s:pal['fg_dim'][0]
let s:fg       = s:pal['fg'][0]

let s:err      = s:pal['accent.error'][0]
let s:warn     = s:pal['accent.warn'][0]
let s:yellow   = s:pal['accent.yellow'][0]
let s:green    = s:pal['accent.green'][0]
let s:primary   = s:pal['accent.primary'][0]
let s:info     = s:pal['accent.info'][0]
let s:purple   = s:pal['accent.purple'][0]

let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}

" Inactive (subtle)
let s:p.inactive.left   = [ [ s:fg_dim, s:surface ], [ s:muted, s:surface ] ]
let s:p.inactive.middle = [ [ s:muted,  s:surface ] ]
let s:p.inactive.right  = [ [ s:muted,  s:surface ], [ s:fg_dim, s:surface ] ]

" Normal mode (green accent)
let s:p.normal.left   = [ [ s:bg, s:green, 'bold' ], [ s:fg_dim, s:surface2, 'bold' ] ]
let s:p.normal.middle = [ [ s:muted, s:surface ] ]
let s:p.normal.right  = [ [ s:bg, s:green ], [ s:fg_dim, s:surface2 ] ]

" Insert mode (primary accent)
let s:p.insert.left   = [ [ s:bg, s:primary, 'bold' ], [ s:fg_dim, s:surface2, 'bold' ] ]
let s:p.insert.middle = s:p.normal.middle
let s:p.insert.right  = [ [ s:bg, s:primary ], [ s:fg_dim, s:surface2 ] ]

" Replace mode (error accent)
let s:p.replace.left   = [ [ s:bg, s:err, 'bold' ], [ s:fg_dim, s:surface2, 'bold' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right  = [ [ s:bg, s:err ], [ s:fg_dim, s:surface2 ] ]

" Visual mode (orange accent)
let s:p.visual.left   = [ [ s:bg, s:orange, 'bold' ], [ s:fg_dim, s:surface2, 'bold' ] ]
let s:p.visual.middle = s:p.normal.middle
let s:p.visual.right  = [ [ s:bg, s:orange ], [ s:fg_dim, s:surface2 ] ]

" Terminal mode (warn/yellow accent)
let s:p.terminal.left   = [ [ s:bg, s:yellow, 'bold' ], [ s:fg_dim, s:surface2, 'bold' ] ]
let s:p.terminal.middle = s:p.normal.middle
let s:p.terminal.right  = [ [ s:bg, s:yellow ], [ s:fg_dim, s:surface2 ] ]

" Tabline
let s:p.tabline.left   = [ [ s:muted, s:surface2 ] ]
let s:p.tabline.middle = [ [ s:muted, s:surface ] ]
let s:p.tabline.right  = [ [ s:bg,    s:warn ] ]
let s:p.tabline.tabsel = [ [ s:fg,    s:border, 'bold' ] ]

" Lightline diagnostic segments (used by some components)
let s:p.normal.error   = [ [ s:bg, s:err ] ]
let s:p.normal.warning = [ [ s:bg, s:warn ] ]

let g:lightline#colorscheme#blackspice#palette = lightline#colorscheme#fill(s:p)
