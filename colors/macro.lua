-- Name:         macro
-- Description:  Colorscheme for MΛCRO Neovim inspired by kanagawa-dragon @rebelot and mellifluous @ramojus
-- Author:       Bekaboo <kankefengjing@gmail.com>
-- Maintainer:   Bekaboo <kankefengjing@gmail.com>
-- License:      GPL-3.0
-- Last Updated: 2024-12-29 13:30

-- NOTE; this intentionally avoids the use of bright red and yellow (reserved for errors)
-- credits: https://github.com/Bekaboo/dot/blob/master/.config/nvim/colors/macro.lua

-- Clear hlgroups and set colors_name {{{
vim.cmd.hi("clear")
vim.g.colors_name = "macro"
-- }}}

-- {{{
-- stylua: ignore start
local autumnGreen          = "#76946A"
local autumnRed            = "#C34043"
local autumnOrange         = "#E87D3E"
local autumnYellow         = "#DCA561"
local carpYellow           = "#C8AE81"
local katanaGray           = "#717C7C"
local lotusBlue            = "#9FB5C9"
local lotusGray            = "#716E61"
local lotusRed0            = "#D7474B"
local lotusRed1            = "#E84444"
local lotusRed2            = "#D9A594"
local macroAqua            = "#95AEAC"
local macroAsh             = "#626462"
local macroBg0             = "#0D0D0D"
local normal_bg            = "#111111"
local macroBg2             = "#1D1D1D"
local macroBg3             = "#0D0D0D" -- changed from #282727 to fix box in lualine
local selection_light_gray = "#2e2e2e"
local macroBg5             = "#625E5A"
local macroBlue0           = "#658594"
local macroBlue1           = "#8BA4B0"
local macroFg0             = "#C9C9C9"
local macroFg1             = "#B4B3A7"
local macroFg2             = "#A09F95"
local macroGray0           = "#A6A69C"
local macroGray1           = "#9E9B93"
local macroGray2           = "#7A8382"
local macroGreen0          = "#87A987"
local macroGreen1          = "#8A9A7B"
local macroGreen2          = "#2f3b2a"
local macroOrange0         = "#B6927B"
local macroOrange1         = "#B98D7B"
local macroPink            = "#A292A3"
local macroRed             = "#C4746E"
local macroTeal            = "#949FB5"
local macroViolet          = "#8992A7"
local roninYellow          = "#FF9E3B"
local springBlue           = "#7FB4CA"
local springGreen          = "#98BB6C"
local springViolet         = "#938AA9"
local border_purple_ink    = "#5F5F87"
local waveAqua0            = "#6A9589"
local waveAqua1            = "#7AA89F"
local waveBlue0            = "#223249"
local waveBlue1            = "#2D4F67"
local waveRed              = "#E46876"
local winterBlue           = "#252535"
local winterGreen          = "#2E322D"
local winterRed            = "#43242B"
local winterRed2           = "#332828"
local winterYellow         = "#322E29"
local winterPurple         = "#292E42"
local winterOrange         = "#3B2B24"
-- stylua: ignore end
-- }}}

-- Terminal colors {{{
-- stylua: ignore start

vim.g.terminal_color_0  = macroBg0[1]
vim.g.terminal_color_1  = macroRed[1]
vim.g.terminal_color_2  = macroGreen1[1]
vim.g.terminal_color_3  = carpYellow[1]
vim.g.terminal_color_4  = macroBlue1[1]
vim.g.terminal_color_5  = macroPink[1]
vim.g.terminal_color_6  = macroAqua[1]
vim.g.terminal_color_7  = macroFg0[1]
vim.g.terminal_color_8  = selection_light_gray[1]
vim.g.terminal_color_9  = waveRed[1]
vim.g.terminal_color_10 = macroGreen0[1]
vim.g.terminal_color_11 = autumnYellow[1]
vim.g.terminal_color_12 = springBlue[1]
vim.g.terminal_color_13 = springViolet[1]
vim.g.terminal_color_14 = waveAqua1[1]
vim.g.terminal_color_15 = macroFg0[1]

vim.g.terminal_color_16 = macroOrange0[1]
vim.g.terminal_color_17 = macroOrange1[1]
-- stylua: ignore end
--- }}}

-- Highlight groups {{{1
local hlgroups = {
  -- UI {{{2

  -- note: the below makes your background transparent. edit your terminal's settings
  -- to set it to a different color, or just add something like bg = "#11111"
  Normal = { fg = macroFg0, bg = macroBg0 },
  NormalFloat = { link = "NormalFloat" },

  ColorColumn = { link = "CursorLine" },
  Conceal = { bold = true, fg = macroGray2 },
  CurSearch = { link = "IncSearch" },
  Cursor = { bg = macroFg0, fg = nil },
  CursorColumn = { link = "CursorLine" },
  CursorIM = { link = "Cursor" },
  CursorLine = { bg = macroBg2 },
  CursorLineNr = { fg = macroGray0, bold = true },
  DebugPC = { link = "DiffDelete" },
  DiffAdd = { bg = winterGreen },
  DiffAdded = { fg = autumnGreen },
  DiffChange = { bg = winterBlue },
  DiffChanged = { fg = autumnYellow },
  DiffDelete = { bg = winterRed },
  DiffDeleted = { fg = autumnRed },
  DiffNewFile = { link = "DiffAdded" },
  DiffOldFile = { link = "DiffDeleted" },
  DiffRemoved = { link = "DiffDeleted" },
  DiffText = { bg = border_purple_ink },
  Directory = { fg = macroBlue1 },
  EndOfBuffer = { fg = normal_bg },
  ErrorMsg = { fg = lotusRed1 },
  FloatBorder = { bg = nil, fg = border_purple_ink },
  CompletionBorder = { bg = nil, fg = border_purple_ink },
  FloatFooter = { bg = macroBg0, fg = macroBg5 },
  FloatTitle = { bg = macroBg0, fg = macroGray2, bold = true },
  FoldColumn = { link = "NonText" },
  Folded = { bg = macroBg2, fg = lotusGray },
  Ignore = { link = "NonText" },
  IncSearch = { bg = carpYellow, fg = waveBlue0 },
  LineNr = { link = "NonText" },
  MatchParen = { link = "Visual" },
  ModeMsg = { fg = macroRed, bold = true },
  MoreMsg = { fg = macroBlue0 },
  MsgArea = { fg = macroFg1 },
  MsgSeparator = { bg = macroBg0 },
  NonText = { fg = macroBg5 },
  SnippetTabstop = { link = "Snippet" },
  NormalNC = { link = "Normal" },
  Pmenu = { bg = macroBg2, fg = macroFg1 },
  PmenuSbar = { link = "CursorColumn" },
  PmenuSel = { link = "Visual" },
  PmenuThumb = { bg = macroBg5 },
  PmenuExtra = { bg = nil, fg = nil },
  PmenuKind = { bg = nil, fg = nil },
  Question = { link = "MoreMsg" },
  QuickFixLine = { bg = macroBg3 },
  Search = { link = "Visual" },
  SignColumn = { fg = macroGray2 },
  SpellBad = { undercurl = true, sp = lotusRed0 },
  SpellCap = { undercurl = true, sp = carpYellow },
  SpellLocal = { undercurl = true, sp = carpYellow },
  SpellRare = { undercurl = true, sp = carpYellow },
  StatusLine = { bg = nil, fg = macroFg0 },
  StatusLineNC = { bg = macroBg2, fg = macroBg5 },
  Substitute = { bg = autumnRed, fg = macroFg0 },
  TabLine = { link = "Comment" },
  TabLineFill = { bg = nil, fg = macroFg1 },
  TabLineSel = { bg = macroBg2, fg = macroFg0, bold = true },
  TermCursor = { link = "Cursor" },
  TermCursorNC = { fg = normal_bg, bg = macroAsh },
  Title = { bold = true, fg = macroBlue1 },
  Underlined = { fg = macroTeal, underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { bg = selection_light_gray },
  VisualNOS = { link = "Visual" },
  WarningMsg = { fg = roninYellow },
  Whitespace = { fg = selection_light_gray },
  WildMenu = { link = "Pmenu" },
  WinBar = { bg = macroBg2, fg = macroFg0 },
  WinBarNC = { bg = macroBg2, fg = macroFg1 },
  WinSeparator = { fg = selection_light_gray },
  lCursor = { link = "Cursor" },
  -- }}}2

  -- Syntax {{{2
  Boolean = { fg = macroOrange0, bold = true },
  Character = { link = "String" },
  Comment = { fg = macroAsh },
  Constant = { fg = macroOrange0 },
  Delimiter = { fg = macroGray1 },
  Error = { fg = lotusRed1 },
  Exception = { fg = macroRed },
  Float = { link = "Number" },
  Function = { fg = macroBlue1 },
  Identifier = { fg = macroFg0 },
  Keyword = { fg = macroViolet },
  Number = { fg = macroPink },
  Operator = { fg = macroRed },
  PreProc = { fg = macroRed },
  Special = { fg = macroTeal },
  SpecialKey = { fg = macroGray2 },
  Statement = { fg = macroViolet },
  String = { fg = macroGreen1 },
  Todo = { fg = macroBg0, bg = macroBlue0, bold = true },
  Type = { fg = macroAqua },
  -- }}}2

  -- Treesitter syntax {{{2
  ["@attribute"] = { link = "Constant" },
  ["@constructor"] = { fg = macroTeal },
  ["@constructor.lua"] = { fg = macroViolet },
  ["@keyword.exception"] = { bold = true, fg = macroRed },
  ["@keyword.import"] = { link = "PreProc" },
  ["@keyword.luap"] = { link = "@string.regexp" },
  ["@keyword.operator"] = { bold = true, fg = macroRed },
  ["@keyword.return"] = { fg = macroRed, italic = true },
  ["@module"] = { link = "Constant" },
  ["@operator"] = { link = "Operator" },
  ["@nospell.latex"] = { fg = macroBlue1 },
  ["@markup.math.latex"] = { fg = macroBlue1 },
  ["@operator.latex"] = { fg = macroRed },
  ["@variable.parameter"] = { fg = macroGray0 },
  ["@punctuation.bracket"] = { fg = macroGray1 },
  ["@punctuation.delimiter"] = { fg = macroGray1 },
  ["@markup.list"] = { fg = macroTeal },
  ["@string.escape"] = { link = "Constant" },
  ["@string.regexp"] = { link = "Constant" },
  ["@string.special.url.comment"] = { fg = macroTeal, underline = true },
  ["@markup.link.label.symbol"] = { fg = macroFg0 },
  ["@tag.attribute"] = { fg = macroFg0 },
  ["@tag.delimiter"] = { fg = macroGray1 },
  ["@diff.delta"] = { link = "DiffChanged" },
  ["@diff.minus"] = { link = "DiffRemoved" },
  ["@diff.plus"] = { link = "DiffAdded" },
  ["@markup.emphasis"] = { italic = true },
  ["@markup.environment"] = { link = "Keyword" },
  ["@markup.environment.name"] = { link = "String" },
  ["@markup.raw"] = { link = "String" },
  ["@comment.info"] = { bg = waveAqua0, fg = waveBlue0, bold = true },
  ["@markup.quote"] = { link = "@variable.parameter" },
  ["@markup.strong"] = { link = "markdownBold" },
  ["@markup.italic.markdown_inline"] = { italic = true },
  ["@markup.heading"] = { link = "Function" },
  ["@markup.heading.1.markdown"] = { fg = macroRed, bg = winterRed2, bold = true },
  ["@markup.heading.2.markdown"] = { fg = autumnOrange, bg = winterOrange, bold = true },
  ["@markup.heading.3.markdown"] = { fg = autumnYellow, bg = winterYellow, bold = true },
  ["@markup.heading.4.markdown"] = { fg = springGreen, bg = winterGreen, bold = true },
  ["@markup.heading.5.markdown"] = { fg = springBlue, bg = waveBlue0, bold = true },
  ["@markup.heading.6.markdown"] = { fg = springViolet, bg = winterPurple, bold = true },
  ["@markup.heading.1.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.2.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.3.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.4.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.5.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.6.marker.markdown"] = { link = "Delimiter" },
  -- ["@markup.markdown_inline"] = { fg = c_macroFg0 },
  ["@markup.strikethrough.markdown_inline"] = { strikethrough = true },
  ["@comment.todo.checked"] = { link = "Comment" },
  ["@comment.todo.unchecked"] = { fg = macroRed },
  ["@markup.link.label.markdown_inline"] = { link = "htmlLink" },
  ["@markup.link.url.markdown_inline"] = { fg = macroAsh, underline = true },
  -- below are overriden by todo-comments
  -- ["@comment.error"] = { bg = c_lotusRed1, fg = c_macroFg0, bold = true },
  -- ["@comment.warning"] = { bg = c_roninYellow, fg = c_waveBlue0, bold = true },
  ["@variable"] = { fg = macroFg0 },
  ["@variable.builtin"] = { fg = macroRed, italic = true },
  -- }}}

  -- LSP semantic {{{2
  ["@lsp.mod.readonly"] = { link = "Constant" },
  ["@lsp.mod.typeHint"] = { link = "Type" },
  ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
  ["@lsp.type.comment"] = { fg = "NONE" },
  ["@lsp.type.macro"] = { fg = macroPink },
  ["@lsp.type.magicFunction"] = { link = "@function.builtin" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
  ["@lsp.type.variable"] = { fg = "NONE" },
  ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.readonly"] = { bold = true, fg = macroBlue1 },
  ["@lsp.typemod.keyword.documentation"] = { link = "Special" },
  ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
  ["@lsp.typemod.operator.controlFlow"] = { link = "@keyword.exception" },
  ["@lsp.typemod.operator.injected"] = { link = "Operator" },
  ["@lsp.typemod.string.injected"] = { link = "String" },
  ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
  ["@lsp.typemod.variable.global"] = { link = "Constant" },
  ["@lsp.typemod.variable.injected"] = { link = "@variable" },
  ["@lsp.typemod.variable.static"] = { link = "Constant" },
  -- }}}

  -- LSP {{{2
  LspCodeLens = { link = "Comment" },
  LspInfoBorder = { link = "FloatBorder" },
  LspReferenceRead = { link = "LspReferenceText" },
  LspReferenceText = { bg = nil, underline = true },
  LspReferenceWrite = { bg = nil, underline = true },
  LspSignatureActiveParameter = { link = "WarningMsg" },
  -- }}}

  -- Diagnostic {{{2
  DiagnosticError = { fg = macroRed },
  DiagnosticHint = { fg = macroAqua },
  DiagnosticInfo = { fg = macroBlue1 },
  DiagnosticOk = { fg = macroGreen1 },
  DiagnosticWarn = { fg = carpYellow },
  DiagnosticSignError = { fg = macroRed },
  DiagnosticSignHint = { fg = macroAqua },
  DiagnosticSignInfo = { fg = macroBlue1 },
  DiagnosticSignWarn = { fg = carpYellow },
  DiagnosticUnderlineError = { sp = macroRed, undercurl = true },
  DiagnosticUnderlineHint = { sp = macroAqua, undercurl = true },
  DiagnosticUnderlineInfo = { sp = macroBlue1, undercurl = true },
  DiagnosticUnderlineWarn = { sp = carpYellow, undercurl = true },
  DiagnosticVirtualTextError = { bg = winterRed, fg = macroRed },
  DiagnosticVirtualTextHint = { bg = winterGreen, fg = macroAqua },
  DiagnosticVirtualTextInfo = { bg = winterBlue, fg = macroBlue1 },
  DiagnosticVirtualTextWarn = { bg = winterYellow, fg = carpYellow },
  DiagnosticUnnecessary = {
    fg = macroAsh,
    sp = macroAqua,
    undercurl = false,
  },
  -- }}}

  -- Filetype {{{2
  -- Git
  gitHash = { link = "Comment" },

  -- Sh/Bash
  bashSpecialVariables = { link = "Constant" },
  shAstQuote = { link = "Constant" },
  shCaseEsac = { link = "Operator" },
  shDeref = { link = "Special" },
  shDerefSimple = { link = "shDerefVar" },
  shDerefVar = { link = "Constant" },
  shNoQuote = { link = "shAstQuote" },
  shQuote = { link = "String" },
  shTestOpr = { link = "Operator" },

  -- HTML
  htmlBold = { bold = true },
  htmlBoldItalic = { bold = true, italic = true },
  htmlH1 = { fg = springBlue, bold = true },
  htmlH2 = { fg = autumnYellow, bold = true },
  htmlH3 = { fg = springGreen, bold = true },
  htmlH4 = { fg = autumnGreen, bold = true },
  htmlH5 = { fg = springViolet, bold = true },
  htmlH6 = { fg = macroViolet, bold = true },
  htmlItalic = { italic = true },
  htmlLink = { fg = lotusBlue, underline = true },
  htmlSpecialChar = { link = "SpecialChar" },
  htmlSpecialTagName = { fg = macroViolet },
  htmlString = { link = "String" },
  htmlTagName = { link = "Tag" },
  htmlTitle = { link = "Title" },

  -- Markdown
  markdownBold = { bold = true, fg = carpYellow },
  markdownBoldItalic = { bold = true, italic = true },
  markdownCode = { fg = macroGreen1 },
  markdownCodeBlock = { fg = macroGreen1 },
  markdownError = { link = "NONE" },
  markdownEscape = { fg = "NONE" },
  markdownH1 = { link = "htmlH1" },
  markdownH2 = { link = "htmlH2" },
  markdownH3 = { link = "htmlH3" },
  markdownH4 = { link = "htmlH4" },
  markdownH5 = { link = "htmlH5" },
  markdownH6 = { link = "htmlH6" },
  markdownListMarker = { link = "DiffChanged" },

  -- Checkhealth
  healthError = { fg = lotusRed0 },
  healthSuccess = { fg = springGreen },
  healthWarning = { link = "WarningMsg" },
  helpHeader = { link = "Title" },
  helpSectionDelim = { link = "Title" },

  -- Qf
  qfFileName = { link = "Directory" },
  qfLineNr = { link = "lineNr" },
  -- }}}

  -- Plugins {{{2
  -- nvim-cmp
  BlinkCmpCompletion = { link = "Pmenu" },
  BlinkCmpMenu = { link = "Pmenu" },
  BlinkCmpCompletionBorder = { bg = waveBlue0, fg = waveBlue1 },
  BlinkCmpCompletionSbar = { link = "PmenuSbar" },
  BlinkCmpCompletionSel = { bg = waveBlue1, fg = "NONE" },
  BlinkCmpCompletionThumb = { link = "PmenuThumb" },
  BlinkCmpDocumentation = { link = "NormalFloat" },
  BlinkCmpDocumentationBorder = { link = "FloatBorder" },
  BlinkCmpItemAbbr = { fg = macroFg2 },
  BlinkCmpItemAbbrDeprecated = { fg = macroAsh, strikethrough = true },
  BlinkCmpItemAbbrMatch = { fg = macroRed },
  BlinkCmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
  BlinkCmpKindClass = { link = "Type" },
  BlinkCmpKindConstant = { link = "Constant" },
  BlinkCmpKindConstructor = { link = "@constructor" },
  BlinkCmpKindCopilot = { link = "String" },
  BlinkCmpKindDefault = { fg = katanaGray },
  BlinkCmpKindEnum = { link = "Type" },
  BlinkCmpKindEnumMember = { link = "Constant" },
  BlinkCmpKindField = { link = "@variable.member" },
  BlinkCmpKindFile = { link = "Constant" },
  BlinkCmpKindFolder = { link = "Directory" },
  BlinkCmpKindFunction = { link = "Function" },
  BlinkCmpKindInterface = { link = "Type" },
  BlinkCmpKindKeyword = { link = "@keyword" },
  BlinkCmpKindMethod = { link = "Function" },
  BlinkCmpKindModule = { link = "@keyword.import" },
  BlinkCmpKindOperator = { link = "Operator" },
  BlinkCmpKindProperty = { link = "@property" },
  BlinkCmpKindReference = { link = "Type" },
  BlinkCmpKindSnippet = { fg = macroTeal },
  BlinkCmpKindStruct = { link = "Type" },
  BlinkCmpKindText = { fg = macroFg2 },
  BlinkCmpKindTypeParameter = { link = "Type" },
  BlinkCmpKindValue = { link = "String" },
  BlinkCmpKindVariable = { fg = lotusRed2 },
  BlinkCmpLabelMatch = { link = "Special" },

  -- gitsigns
  GitSignsAdd = { link = "DiffAdded" },
  GitSignsChange = { fg = border_purple_ink },
  GitSignsDelete = { fg = lotusRed0 },
  GitSignsDeletePreview = { link = "DiffDelete" },
  GitSignsDeleteInline = { strikethrough = true },
  GitSignsDeleteLnInline = { link = "GitSignsDeletePreview" },
  GitSignsDeleteVirtLnInLine = { link = "GitSignsDeletePreview" },
  GitSignsChangeInline = { underline = true },
  GitSignsChangeLnInline = {},
  GitSignsChangeVirtLnInLine = {},
  GitSignsAddInline = { underline = true },
  GitSignsAddLnInline = { link = "GitSignsAddLn" },
  GitSignsAddVirtLnInLine = { link = "GitSignsAddLn" },
  GitSignsCurrentLineBlame = { fg = macroAsh, italic = true },

  --noice
  NoicePopupmenuSelected = { link = "Visual" },
  NoiceScrollBar = { bg = normal_bg },

  -- telescope
  TelescopeBorder = { link = "FloatBorder" },
  TelescopeMatching = { fg = macroRed, bold = true },
  TelescopeNormal = { link = "NormalFloat" },
  TelescopeResultsClass = { link = "Structure" },
  TelescopeResultsField = { link = "@variable.member" },
  TelescopeResultsMethod = { link = "Function" },
  TelescopeResultsStruct = { link = "Structure" },
  TelescopeResultsVariable = { link = "@variable" },
  TelescopeSelection = { link = "Visual" },
  TelescopeTitle = { link = "SpecialKey" },
  TelescopePromptBorder = { link = "TelescopeBorder" },

  -- nvim-dap-ui (one day I'll use this)
  DapUIBreakpointsCurrentLine = { bold = true, fg = macroFg0 },
  DapUIBreakpointsDisabledLine = { link = "Comment" },
  DapUIBreakpointsInfo = { fg = macroBlue0 },
  DapUIBreakpointsPath = { link = "Directory" },
  DapUIDecoration = { fg = border_purple_ink },
  DapUIFloatBorder = { fg = border_purple_ink },
  DapUILineNumber = { fg = macroTeal },
  DapUIModifiedValue = { bold = true, fg = macroTeal },
  DapUIPlayPause = { fg = macroGreen1 },
  DapUIRestart = { fg = macroGreen1 },
  DapUIScope = { link = "Special" },
  DapUISource = { fg = macroRed },
  DapUIStepBack = { fg = macroTeal },
  DapUIStepInto = { fg = macroTeal },
  DapUIStepOut = { fg = macroTeal },
  DapUIStepOver = { fg = macroTeal },
  DapUIStop = { fg = lotusRed0 },
  DapUIStoppedThread = { fg = macroTeal },
  DapUIThread = { fg = macroFg0 },
  DapUIType = { link = "Type" },
  DapUIUnavailable = { link = "Comment" },
  DapUIWatchesEmpty = { fg = lotusRed0 },
  DapUIWatchesError = { fg = lotusRed0 },
  DapUIWatchesValue = { fg = macroFg0 },

  -- lazy.nvim
  LazyProgressTodo = { link = "NonText" },

  -- statusline
  StatusLineGitAdded = { bg = macroBg3, fg = macroGreen1 },
  StatusLineGitChanged = { bg = macroBg3, fg = carpYellow },
  StatusLineGitRemoved = { bg = macroBg3, fg = macroRed },
  StatusLineHeader = { bg = macroBg5, fg = macroFg1 },
  StatusLineHeaderModified = { bg = macroRed, fg = normal_bg },

  -- mini.files
  -- MiniFilesNormal = { bg = nil },
  MiniFilesNormal = { link = "NormalFloat" },
  MiniFilesTitle = { bg = nil, fg = macroFg2 },
  MiniFilesDirectory = { fg = macroBlue1 },
  MiniFilesTitleFocused = { bg = nil, fg = macroFg2 },
  MiniFilesBorder = { link = "FloatBorder" },

  -- incline
  InclineNormal = { link = "Pmenu" },
  InclineNormalNC = { link = "Pmenu" },

  -- snacks indent/picker
  SnacksIndent = { fg = selection_light_gray },
  SnacksIndentScope = { fg = border_purple_ink },
  SnacksPickerListCursorLine = { link = "Visual" },
  SnacksPickerPreviewCursorLine = { link = "CursorLine" },
  -- how to highlight chars that from query that match item in list
  -- using a special style here kinda sucks when searching highlights in picker
  SnacksPickerMatch = {},

  -- neocodeium
  NeoCodeiumSuggestion = { link = "NonText" },
  NeoCodeiumLabel = { fg = macroFg0, bg = macroBg2 },

  -- treesitter context
  TreesitterContext = { bg = nil },
  TreesitterContextLineNumber = { bg = nil, fg = border_purple_ink },
  TreesitterContextLineNumberBottom = { underdashed = false, bg = nil, sp = border_purple_ink },
  TreesitterContextBottom = { underdashed = false, bg = nil, sp = border_purple_ink },

  -- render-markdown.nvim
  RenderMarkdownH1Bg = { bg = winterRed2 },
  RenderMarkdownH2Bg = { bg = winterOrange },
  RenderMarkdownH3Bg = { bg = winterYellow },
  RenderMarkdownH4Bg = { link = "DiffAdd" },
  RenderMarkdownH5Bg = { bg = waveBlue0 },
  RenderMarkdownH6Bg = { bg = winterPurple },

  -- for lualine
  HostNameIcon = { fg = macroAsh, bg = nil },

  PvsFileIcon = { fg = "#007ad3" },
  -- }}}2
}
-- }}}1

-- Set highlight groups {{{1
for hlgroup_name, hlgroup_attr in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end
-- }}}1

-- !vim:ts=2:sw=2:sts=2:fdm=marker:fdl=1
