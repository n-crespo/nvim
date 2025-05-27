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
local c_autumnGreen          = "#76946A"
local c_autumnRed            = "#C34043"
local c_autumnOrange         = "#E87D3E"
local c_autumnYellow         = "#DCA561"
local c_carpYellow           = "#C8AE81"
local c_katanaGray           = "#717C7C"
local c_lotusBlue            = "#9FB5C9"
local c_lotusGray            = "#716E61"
local c_lotusRed0            = "#D7474B"
local c_lotusRed1            = "#E84444"
local c_lotusRed2            = "#D9A594"
local c_macroAqua            = "#95AEAC"
local c_macroAsh             = "#626462"
local c_macroBg0             = "#0D0D0D"
local normal_bg              = "#111111"
local c_macroBg2             = "#1D1D1D"
local c_macroBg3             = "#0D0D0D" -- changed from #282727 to fix box in lualine
local selection_light_gray   = "#393939"
local c_macroBg5             = "#625E5A"
local c_macroBlue0           = "#658594"
local c_macroBlue1           = "#8BA4B0"
local c_macroFg0             = "#C9C9C9"
local c_macroFg1             = "#B4B3A7"
local c_macroFg2             = "#A09F95"
local c_macroGray0           = "#A6A69C"
local c_macroGray1           = "#9E9B93"
local c_macroGray2           = "#7A8382"
local c_macroGreen0          = "#87A987"
local c_macroGreen1          = "#8A9A7B"
local c_macroGreen2          = "#2f3b2a"
local c_macroOrange0         = "#B6927B"
local c_macroOrange1         = "#B98D7B"
local c_macroPink            = "#A292A3"
local c_macroRed             = "#C4746E"
local c_macroTeal            = "#949FB5"
local c_macroViolet          = "#8992A7"
local c_roninYellow          = "#FF9E3B"
local c_springBlue           = "#7FB4CA"
local c_springGreen          = "#98BB6C"
local c_springViolet         = "#938AA9"
local border_purple_ink      = "#5F5F87"
local c_waveAqua0            = "#6A9589"
local c_waveAqua1            = "#7AA89F"
local c_waveBlue0            = "#223249"
local c_waveBlue1            = "#2D4F67"
local c_waveRed              = "#E46876"
local c_winterBlue           = "#252535"
local c_winterGreen          = "#2E322D"
local c_winterRed            = "#43242B"
local c_winterRed2           = "#332828"
local c_winterYellow         = "#322E29"
local c_winterPurple         = "#292E42"
local c_winterOrange         = "#3B2B24"
-- stylua: ignore end
-- }}}

-- Terminal colors {{{
-- stylua: ignore start

vim.g.terminal_color_0  = c_macroBg0[1]
vim.g.terminal_color_1  = c_macroRed[1]
vim.g.terminal_color_2  = c_macroGreen1[1]
vim.g.terminal_color_3  = c_carpYellow[1]
vim.g.terminal_color_4  = c_macroBlue1[1]
vim.g.terminal_color_5  = c_macroPink[1]
vim.g.terminal_color_6  = c_macroAqua[1]
vim.g.terminal_color_7  = c_macroFg0[1]
vim.g.terminal_color_8  = selection_light_gray[1]
vim.g.terminal_color_9  = c_waveRed[1]
vim.g.terminal_color_10 = c_macroGreen0[1]
vim.g.terminal_color_11 = c_autumnYellow[1]
vim.g.terminal_color_12 = c_springBlue[1]
vim.g.terminal_color_13 = c_springViolet[1]
vim.g.terminal_color_14 = c_waveAqua1[1]
vim.g.terminal_color_15 = c_macroFg0[1]

vim.g.terminal_color_16 = c_macroOrange0[1]
vim.g.terminal_color_17 = c_macroOrange1[1]
-- stylua: ignore end
--- }}}

-- Highlight groups {{{1
local hlgroups = {
  -- UI {{{2

  -- note: the below makes your background transparent. edit your terminal's settings
  -- to set it to a different color, or just add something like bg = "#11111"
  Normal = { fg = c_macroFg0, bg = nil },
  NormalFloat = { link = "NormalFloat" },

  ColorColumn = { link = "CursorLine" },
  Conceal = { bold = true, fg = c_macroGray2 },
  CurSearch = { link = "IncSearch" },
  Cursor = { bg = c_macroFg0, fg = nil },
  CursorColumn = { link = "CursorLine" },
  CursorIM = { link = "Cursor" },
  CursorLine = { bg = c_macroBg2 },
  CursorLineNr = { fg = c_macroGray0, bold = true },
  DebugPC = { link = "DiffDelete" },
  DiffAdd = { bg = c_winterGreen },
  DiffAdded = { fg = c_autumnGreen },
  DiffChange = { bg = c_winterBlue },
  DiffChanged = { fg = c_autumnYellow },
  DiffDelete = { bg = c_winterRed },
  DiffDeleted = { fg = c_autumnRed },
  DiffNewFile = { link = "DiffAdded" },
  DiffOldFile = { link = "DiffDeleted" },
  DiffRemoved = { link = "DiffDeleted" },
  DiffText = { bg = border_purple_ink },
  Directory = { fg = c_macroBlue1 },
  EndOfBuffer = { fg = normal_bg },
  ErrorMsg = { fg = c_lotusRed1 },
  FloatBorder = { bg = nil, fg = border_purple_ink },
  CompletionBorder = { bg = nil, fg = border_purple_ink },
  FloatFooter = { bg = c_macroBg0, fg = c_macroBg5 },
  FloatTitle = { bg = c_macroBg0, fg = c_macroGray2, bold = true },
  FoldColumn = { link = "NonText" },
  Folded = { bg = c_macroBg2, fg = c_lotusGray },
  Ignore = { link = "NonText" },
  IncSearch = { bg = c_carpYellow, fg = c_waveBlue0 },
  LineNr = { link = "NonText" },
  MatchParen = { link = "Visual" },
  ModeMsg = { fg = c_macroRed, bold = true },
  MoreMsg = { fg = c_macroBlue0 },
  MsgArea = { fg = c_macroFg1 },
  MsgSeparator = { bg = c_macroBg0 },
  NonText = { fg = c_macroBg5 },
  SnippetTabstop = { link = "Snippet" },
  NormalNC = { link = "Normal" },
  Pmenu = { bg = c_macroBg2, fg = c_macroFg1 },
  PmenuSbar = { link = "CursorColumn" },
  PmenuSel = { link = "Visual" },
  PmenuThumb = { bg = c_macroBg5 },
  PmenuExtra = { bg = nil, fg = nil },
  PmenuKind = { bg = nil, fg = nil },
  Question = { link = "MoreMsg" },
  QuickFixLine = { bg = c_macroBg3 },
  Search = { link = "Visual" },
  SignColumn = { fg = c_macroGray2 },
  SpellBad = { fg = c_lotusRed0, underdashed = true },
  SpellCap = { underdashed = true },
  SpellLocal = { underdashed = true },
  SpellRare = { underdashed = true },
  StatusLine = { bg = nil, fg = c_macroFg0 },
  StatusLineNC = { bg = c_macroBg2, fg = c_macroBg5 },
  Substitute = { bg = c_autumnRed, fg = c_macroFg0 },
  TabLine = { link = "Comment" },
  TabLineFill = { bg = nil, fg = c_macroFg1 },
  TabLineSel = { bg = c_macroBg2, fg = c_macroFg0, bold = true },
  TermCursor = { link = "Cursor" },
  TermCursorNC = { fg = normal_bg, bg = c_macroAsh },
  Title = { bold = true, fg = c_macroBlue1 },
  Underlined = { fg = c_macroTeal, underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { bg = selection_light_gray },
  VisualNOS = { link = "Visual" },
  WarningMsg = { fg = c_roninYellow },
  Whitespace = { fg = selection_light_gray },
  WildMenu = { link = "Pmenu" },
  WinBar = { bg = c_macroBg2, fg = c_macroFg0 },
  WinBarNC = { bg = c_macroBg2, fg = c_macroFg1 },
  WinSeparator = { fg = selection_light_gray },
  lCursor = { link = "Cursor" },
  -- }}}2

  -- Syntax {{{2
  Boolean = { fg = c_macroOrange0, bold = true },
  Character = { link = "String" },
  Comment = { fg = c_macroAsh },
  Constant = { fg = c_macroOrange0 },
  Delimiter = { fg = c_macroGray1 },
  Error = { fg = c_lotusRed1 },
  Exception = { fg = c_macroRed },
  Float = { link = "Number" },
  Function = { fg = c_macroBlue1 },
  Identifier = { fg = c_macroFg0 },
  Keyword = { fg = c_macroViolet },
  Number = { fg = c_macroPink },
  Operator = { fg = c_macroRed },
  PreProc = { fg = c_macroRed },
  Special = { fg = c_macroTeal },
  SpecialKey = { fg = c_macroGray2 },
  Statement = { fg = c_macroViolet },
  String = { fg = c_macroGreen1 },
  Todo = { fg = c_macroBg0, bg = c_macroBlue0, bold = true },
  Type = { fg = c_macroAqua },
  -- }}}2

  -- Treesitter syntax {{{2
  ["@attribute"] = { link = "Constant" },
  ["@constructor"] = { fg = c_macroTeal },
  ["@constructor.lua"] = { fg = c_macroViolet },
  ["@keyword.exception"] = { bold = true, fg = c_macroRed },
  ["@keyword.import"] = { link = "PreProc" },
  ["@keyword.luap"] = { link = "@string.regexp" },
  ["@keyword.operator"] = { bold = true, fg = c_macroRed },
  ["@keyword.return"] = { fg = c_macroRed, italic = true },
  ["@module"] = { link = "Constant" },
  ["@operator"] = { link = "Operator" },
  ["@nospell.latex"] = { fg = c_macroBlue1 },
  ["@markup.math.latex"] = { fg = c_macroBlue1 },
  ["@operator.latex"] = { fg = c_macroRed },
  ["@variable.parameter"] = { fg = c_macroGray0 },
  ["@punctuation.bracket"] = { fg = c_macroGray1 },
  ["@punctuation.delimiter"] = { fg = c_macroGray1 },
  ["@markup.list"] = { fg = c_macroTeal },
  ["@string.escape"] = { link = "Constant" },
  ["@string.regexp"] = { link = "Constant" },
  ["@string.special.url.comment"] = { fg = c_macroTeal, underline = true },
  ["@markup.link.label.symbol"] = { fg = c_macroFg0 },
  ["@tag.attribute"] = { fg = c_macroFg0 },
  ["@tag.delimiter"] = { fg = c_macroGray1 },
  ["@diff.delta"] = { link = "DiffChanged" },
  ["@diff.minus"] = { link = "DiffRemoved" },
  ["@diff.plus"] = { link = "DiffAdded" },
  ["@markup.emphasis"] = { italic = true },
  ["@markup.environment"] = { link = "Keyword" },
  ["@markup.environment.name"] = { link = "String" },
  ["@markup.raw"] = { link = "String" },
  ["@comment.info"] = { bg = c_waveAqua0, fg = c_waveBlue0, bold = true },
  ["@markup.quote"] = { link = "@variable.parameter" },
  ["@markup.strong"] = { link = "markdownBold" },
  ["@markup.italic.markdown_inline"] = { italic = true },
  ["@markup.heading"] = { link = "Function" },
  ["@markup.heading.1.markdown"] = { fg = c_macroRed, bg = c_winterRed2, bold = true },
  ["@markup.heading.2.markdown"] = { fg = c_autumnOrange, bg = c_winterOrange, bold = true },
  ["@markup.heading.3.markdown"] = { fg = c_autumnYellow, bg = c_winterYellow, bold = true },
  ["@markup.heading.4.markdown"] = { fg = c_springGreen, bg = c_winterGreen, bold = true },
  ["@markup.heading.5.markdown"] = { fg = c_springBlue, bg = c_waveBlue0, bold = true },
  ["@markup.heading.6.markdown"] = { fg = c_springViolet, bg = c_winterPurple, bold = true },
  ["@markup.heading.1.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.2.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.3.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.4.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.5.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.6.marker.markdown"] = { link = "Delimiter" },
  -- ["@markup.markdown_inline"] = { fg = c_macroFg0 },
  ["@markup.strikethrough.markdown_inline"] = { strikethrough = true },
  ["@comment.todo.checked"] = { link = "Comment" },
  ["@comment.todo.unchecked"] = { fg = c_macroRed },
  ["@markup.link.label.markdown_inline"] = { link = "htmlLink" },
  ["@markup.link.url.markdown_inline"] = { fg = c_macroAsh, underline = true },
  -- below are overriden by todo-comments
  -- ["@comment.error"] = { bg = c_lotusRed1, fg = c_macroFg0, bold = true },
  -- ["@comment.warning"] = { bg = c_roninYellow, fg = c_waveBlue0, bold = true },
  ["@variable"] = { fg = c_macroFg0 },
  ["@variable.builtin"] = { fg = c_macroRed, italic = true },
  -- }}}

  -- LSP semantic {{{2
  ["@lsp.mod.readonly"] = { link = "Constant" },
  ["@lsp.mod.typeHint"] = { link = "Type" },
  ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
  ["@lsp.type.comment"] = { fg = "NONE" },
  ["@lsp.type.macro"] = { fg = c_macroPink },
  ["@lsp.type.magicFunction"] = { link = "@function.builtin" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
  ["@lsp.type.variable"] = { fg = "NONE" },
  ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.readonly"] = { bold = true, fg = c_macroBlue1 },
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
  DiagnosticError = { fg = c_macroRed },
  DiagnosticHint = { fg = c_macroAqua },
  DiagnosticInfo = { fg = c_macroBlue1 },
  DiagnosticOk = { fg = c_macroGreen1 },
  DiagnosticWarn = { fg = c_carpYellow },
  DiagnosticSignError = { fg = c_macroRed },
  DiagnosticSignHint = { fg = c_macroAqua },
  DiagnosticSignInfo = { fg = c_macroBlue1 },
  DiagnosticSignWarn = { fg = c_carpYellow },
  DiagnosticUnderlineError = { sp = c_macroRed, undercurl = true },
  DiagnosticUnderlineHint = { sp = c_macroAqua, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c_macroBlue1, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c_carpYellow, undercurl = true },
  DiagnosticVirtualTextError = { bg = c_winterRed, fg = c_macroRed },
  DiagnosticVirtualTextHint = { bg = c_winterGreen, fg = c_macroAqua },
  DiagnosticVirtualTextInfo = { bg = c_winterBlue, fg = c_macroBlue1 },
  DiagnosticVirtualTextWarn = { bg = c_winterYellow, fg = c_carpYellow },
  DiagnosticUnnecessary = {
    fg = c_macroAsh,
    sp = c_macroAqua,
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
  htmlH1 = { fg = c_springBlue, bold = true },
  htmlH2 = { fg = c_autumnYellow, bold = true },
  htmlH3 = { fg = c_springGreen, bold = true },
  htmlH4 = { fg = c_autumnGreen, bold = true },
  htmlH5 = { fg = c_springViolet, bold = true },
  htmlH6 = { fg = c_macroViolet, bold = true },
  htmlItalic = { italic = true },
  htmlLink = { fg = c_lotusBlue, underline = true },
  htmlSpecialChar = { link = "SpecialChar" },
  htmlSpecialTagName = { fg = c_macroViolet },
  htmlString = { link = "String" },
  htmlTagName = { link = "Tag" },
  htmlTitle = { link = "Title" },

  -- Markdown
  markdownBold = { bold = true, fg = c_carpYellow },
  markdownBoldItalic = { bold = true, italic = true },
  markdownCode = { fg = c_macroGreen1 },
  markdownCodeBlock = { fg = c_macroGreen1 },
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
  healthError = { fg = c_lotusRed0 },
  healthSuccess = { fg = c_springGreen },
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
  BlinkCmpCompletionBorder = { bg = c_waveBlue0, fg = c_waveBlue1 },
  BlinkCmpCompletionSbar = { link = "PmenuSbar" },
  BlinkCmpCompletionSel = { bg = c_waveBlue1, fg = "NONE" },
  BlinkCmpCompletionThumb = { link = "PmenuThumb" },
  BlinkCmpDocumentation = { link = "NormalFloat" },
  BlinkCmpDocumentationBorder = { link = "FloatBorder" },
  BlinkCmpItemAbbr = { fg = c_macroFg2 },
  BlinkCmpItemAbbrDeprecated = { fg = c_macroAsh, strikethrough = true },
  BlinkCmpItemAbbrMatch = { fg = c_macroRed },
  BlinkCmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
  BlinkCmpKindClass = { link = "Type" },
  BlinkCmpKindConstant = { link = "Constant" },
  BlinkCmpKindConstructor = { link = "@constructor" },
  BlinkCmpKindCopilot = { link = "String" },
  BlinkCmpKindDefault = { fg = c_katanaGray },
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
  BlinkCmpKindSnippet = { fg = c_macroTeal },
  BlinkCmpKindStruct = { link = "Type" },
  BlinkCmpKindText = { fg = c_macroFg2 },
  BlinkCmpKindTypeParameter = { link = "Type" },
  BlinkCmpKindValue = { link = "String" },
  BlinkCmpKindVariable = { fg = c_lotusRed2 },
  BlinkCmpLabelMatch = { link = "Special" },

  -- gitsigns
  GitSignsAdd = { link = "DiffAdded" },
  GitSignsChange = { fg = border_purple_ink },
  GitSignsDelete = { fg = c_lotusRed0 },
  GitSignsDeletePreview = { link = "DiffDelete" },
  GitSignsDeleteInline = { link = "GitSignsDeletePreview" },
  GitSignsDeleteLnInline = { link = "GitSignsDeletePreview" },
  GitSignsDeleteVirtLnInLine = { link = "GitSignsDeletePreview" },
  GitSignsChangeInline = { link = "GitSignsChangeLn" },
  GitSignsChangeLnInline = { link = "GitSignsChangeLn" },
  GitSignsChangeVirtLnInLine = { link = "GitSignsChangeLn" },
  GitSignsAddInline = { link = "GitSignsAddLn" },
  GitSignsAddLnInline = { link = "GitSignsAddLn" },
  GitSignsAddVirtLnInLine = { link = "GitSignsAddLn" },
  GitSignsCurrentLineBlame = { fg = selection_light_gray, italic = true },

  --noice
  NoicePopupmenuSelected = { link = "Visual" },
  NoiceScrollBar = { bg = normal_bg },

  -- telescope
  TelescopeBorder = { link = "FloatBorder" },
  TelescopeMatching = { fg = c_macroRed, bold = true },
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
  DapUIBreakpointsCurrentLine = { bold = true, fg = c_macroFg0 },
  DapUIBreakpointsDisabledLine = { link = "Comment" },
  DapUIBreakpointsInfo = { fg = c_macroBlue0 },
  DapUIBreakpointsPath = { link = "Directory" },
  DapUIDecoration = { fg = border_purple_ink },
  DapUIFloatBorder = { fg = border_purple_ink },
  DapUILineNumber = { fg = c_macroTeal },
  DapUIModifiedValue = { bold = true, fg = c_macroTeal },
  DapUIPlayPause = { fg = c_macroGreen1 },
  DapUIRestart = { fg = c_macroGreen1 },
  DapUIScope = { link = "Special" },
  DapUISource = { fg = c_macroRed },
  DapUIStepBack = { fg = c_macroTeal },
  DapUIStepInto = { fg = c_macroTeal },
  DapUIStepOut = { fg = c_macroTeal },
  DapUIStepOver = { fg = c_macroTeal },
  DapUIStop = { fg = c_lotusRed0 },
  DapUIStoppedThread = { fg = c_macroTeal },
  DapUIThread = { fg = c_macroFg0 },
  DapUIType = { link = "Type" },
  DapUIUnavailable = { link = "Comment" },
  DapUIWatchesEmpty = { fg = c_lotusRed0 },
  DapUIWatchesError = { fg = c_lotusRed0 },
  DapUIWatchesValue = { fg = c_macroFg0 },

  -- lazy.nvim
  LazyProgressTodo = { link = "NonText" },

  -- statusline
  StatusLineGitAdded = { bg = c_macroBg3, fg = c_macroGreen1 },
  StatusLineGitChanged = { bg = c_macroBg3, fg = c_carpYellow },
  StatusLineGitRemoved = { bg = c_macroBg3, fg = c_macroRed },
  StatusLineHeader = { bg = c_macroBg5, fg = c_macroFg1 },
  StatusLineHeaderModified = { bg = c_macroRed, fg = normal_bg },

  -- mini.files
  -- MiniFilesNormal = { bg = nil },
  MiniFilesNormal = { link = "NormalFloat" },
  MiniFilesTitle = { bg = nil, fg = c_macroFg2 },
  MiniFilesDirectory = { fg = c_macroBlue1 },
  MiniFilesTitleFocused = { bg = nil, fg = c_macroFg2 },
  MiniFilesBorder = { link = "FloatBorder" },

  -- incline
  InclineNormal = { link = "Pmenu" },
  InclineNormalNC = { link = "Pmenu" },

  -- snacks indent/picker
  SnacksIndent = { fg = selection_light_gray },
  SnacksIndentScope = { fg = border_purple_ink },
  SnacksPickerListCursorLine = { link = "Visual" },
  SnacksPickerPreviewCursorLine = { link = "CursorLine" },

  -- neocodeium
  NeoCodeiumSuggestion = { link = "NonText" },
  NeoCodeiumLabel = { fg = c_macroFg0, bg = c_macroBg2 },

  -- treesitter context
  TreesitterContext = { bg = c_macroBg0 },
  TreesitterContextLineNumber = { bg = c_macroBg0, fg = border_purple_ink },
  TreesitterContextLineNumberBottom = { underline = true, bg = c_macroBg0, sp = border_purple_ink },
  TreesitterContextBottom = { underline = true, bg = c_macroBg0, sp = border_purple_ink },

  -- render-markdown.nvim
  RenderMarkdownH1Bg = { bg = c_winterRed2 },
  RenderMarkdownH2Bg = { bg = c_winterOrange },
  RenderMarkdownH3Bg = { bg = c_winterYellow },
  RenderMarkdownH4Bg = { link = "DiffAdd" },
  RenderMarkdownH5Bg = { bg = c_waveBlue0 },
  RenderMarkdownH6Bg = { bg = c_winterPurple },

  -- for lualine
  HostNameIcon = { fg = c_macroAsh, bg = nil },
  -- }}}2
}
-- }}}1

-- Set highlight groups {{{1
for hlgroup_name, hlgroup_attr in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end
-- }}}1

-- !vim:ts=2:sw=2:sts=2:fdm=marker:fdl=1
