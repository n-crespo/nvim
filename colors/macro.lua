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
local normalBg              = "#0a0a0a"
local cursorlineBg          = "#1D1D1D"
local selectionBg           = "#2e2e2e"
local ashGrey               = "#626462"
local quoteFg               = "#898989"
local normalFg              = "#C9C9C9"

local brightRed            = "#C34043"
local dimRed               = "#C4746E"
local darkRed              = "#43242B"

local brightOrange         = "#FF9E3B"
local dimOrange            = "#B98D7B"
local darkOrange           = "#3B2B24"

local dimYellow            = "#C8AE81"
local darkYellow           = "#322E29"

local brightGreen          = "#98BB6C"
local dimGreen             = "#8A9A7B"
local darkGreen            = "#2E322D"

local brightBlue           = "#2D4F67" -- used in search
local dimBlue              = "#88a3bc"
local darkBlue             = "#252535"

local brightTeal           = "#949FB5"
local dimTeal              = "#8992A7"

local brightPurple         = "#5F5F87"
local dimPurple            = "#A292A3" -- used for number
local darkPurple           = "#292E42"

vim.g.terminal_color_0="#0D0D0D"
vim.g.terminal_color_1="#C4746E"
vim.g.terminal_color_2="#8A9A7B"
vim.g.terminal_color_3="#C8AE81"
vim.g.terminal_color_4="#88a3bc"
vim.g.terminal_color_5="#A292A3"
vim.g.terminal_color_6="#8992A7"
vim.g.terminal_color_7="#C5C9C9"

vim.g.terminal_color_8="#949494"
vim.g.terminal_color_9="#C34043"
vim.g.terminal_color_10="#98BB6C"
vim.g.terminal_color_11="#FF9E3B"
vim.g.terminal_color_12="#2D4F67"
vim.g.terminal_color_13="#5F5F87"
vim.g.terminal_color_14="#949FB5"
vim.g.terminal_color_15="#FFFFFF"

-- stylua: ignore end
-- }}}

-- Highlight groups {{{1
local hlgroups = {
  -- UI {{{2

  -- note: the below makes your background transparent. edit your terminal's settings
  -- to set it to a different color, or just add something like bg = "#11111"
  Normal = { fg = normalFg, bg = normalBg },
  NormalFloat = { link = "NormalFloat" },

  ColorColumn = { link = "CursorLine" },
  Conceal = { bold = true, fg = quoteFg },
  CurSearch = { link = "IncSearch" },
  Cursor = { bg = normalFg, fg = nil },
  CursorColumn = { link = "CursorLine" },
  CursorIM = { link = "Cursor" },
  CursorLine = { bg = cursorlineBg },
  CursorLineNr = { fg = quoteFg, bold = true },
  DebugPC = { link = "DiffDelete" },
  DiffAdd = { bg = darkGreen },
  DiffAdded = { fg = dimGreen },
  DiffChange = { bg = darkBlue },
  DiffChanged = { fg = dimYellow },
  DiffDelete = { bg = darkRed },
  DiffDeleted = { fg = brightRed },
  DiffNewFile = { link = "DiffAdded" },
  DiffOldFile = { link = "DiffDeleted" },
  DiffRemoved = { link = "DiffDeleted" },
  DiffText = { bg = darkGreen },
  Directory = { fg = dimBlue },
  EndOfBuffer = { fg = normalBg },
  ErrorMsg = { fg = dimRed },
  FloatBorder = { bg = nil, fg = brightPurple },
  CompletionBorder = { bg = nil, fg = brightPurple },
  FloatFooter = { bg = normalBg, fg = ashGrey },
  FloatTitle = { bg = normalBg, fg = quoteFg, bold = true },
  FoldColumn = { link = "NonText" },
  Folded = { bg = cursorlineBg, fg = ashGrey },
  Ignore = { link = "NonText" },
  IncSearch = { bg = dimYellow, fg = brightBlue },
  LineNr = { link = "NonText" },
  MatchParen = { link = "Visual" },
  ModeMsg = { fg = dimRed, bold = true },
  MoreMsg = { fg = dimBlue },
  MsgArea = { link = "Normal" },
  MsgSeparator = { bg = normalFg },
  NonText = { fg = ashGrey },
  SnippetTabstop = { link = "Snippet" },
  NormalNC = { link = "Normal" },
  Pmenu = { bg = cursorlineBg, fg = normalFg },
  PmenuSbar = { link = "CursorColumn" },
  PmenuSel = { link = "Visual" },
  PmenuThumb = { bg = ashGrey },
  PmenuExtra = { bg = nil, fg = nil },
  PmenuKind = { bg = nil, fg = nil },
  Question = { link = "MoreMsg" },
  QuickFixLine = { bg = normalBg },
  Search = { link = "Visual" },
  SignColumn = { fg = quoteFg },
  SpellBad = { underdashed = true, sp = dimRed },
  SpellCap = { underdashed = true, sp = dimYellow },
  SpellLocal = { underdashed = true, sp = dimYellow },
  SpellRare = { underdashed = true, sp = dimYellow },
  StatusLine = { bg = nil, fg = normalFg },
  StatusLineNC = { bg = cursorlineBg, fg = ashGrey },
  Substitute = { bg = brightRed, fg = normalFg },
  TabLine = { link = "Normal" },
  TabLineFill = { link = "Normal" },
  TabLineSel = { bg = cursorlineBg, fg = normalFg, bold = true },
  TermCursor = { link = "Cursor" },
  TermCursorNC = { fg = normalBg, bg = ashGrey },
  Title = { bold = true, fg = dimBlue },
  Underlined = { fg = brightTeal, underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { bg = selectionBg },
  VisualNOS = { link = "Visual" },
  WarningMsg = { fg = brightOrange },
  Whitespace = { fg = selectionBg },
  WildMenu = { link = "Pmenu" },
  WinBar = { bg = cursorlineBg, fg = normalFg },
  WinBarNC = { bg = cursorlineBg, fg = normalFg },
  WinSeparator = { fg = selectionBg },
  lCursor = { link = "Cursor" },
  -- }}}2

  -- Syntax {{{2
  Boolean = { fg = dimOrange, bold = true },
  Character = { link = "String" },
  Comment = { fg = ashGrey },
  Constant = { fg = dimOrange },
  Delimiter = { fg = quoteFg },
  Error = { fg = dimRed },
  Exception = { fg = dimRed },
  Float = { link = "Number" },
  Function = { fg = dimBlue },
  Identifier = { fg = normalFg },
  Keyword = { fg = dimTeal },
  Number = { fg = dimPurple },
  Operator = { fg = dimPurple }, -- changed from dimRed
  PreProc = { fg = dimRed },
  Special = { fg = brightTeal },
  SpecialKey = { fg = quoteFg },
  Statement = { fg = dimTeal },
  String = { fg = dimGreen },
  Todo = { fg = dimGreen },
  Type = { fg = dimBlue },
  -- }}}2

  -- Treesitter syntax {{{2
  ["@attribute"] = { link = "Constant" },
  ["@constructor"] = { fg = brightTeal },
  ["@constructor.lua"] = { fg = dimTeal },
  ["@keyword.exception"] = { bold = true, fg = dimRed },
  ["@keyword.import"] = { link = "PreProc" },
  ["@keyword.luap"] = { link = "@string.regexp" },
  ["@keyword.operator"] = { bold = true, fg = dimRed },
  ["@keyword.return"] = { fg = dimRed, italic = true },
  ["@module"] = { link = "Constant" },
  ["@operator"] = { link = "Operator" },
  ["@nospell.latex"] = { fg = dimBlue },
  ["@markup.math.latex"] = { fg = dimBlue },
  ["@operator.latex"] = { fg = dimRed },
  ["@variable.parameter"] = { fg = quoteFg },
  ["@punctuation.bracket"] = { fg = quoteFg },
  ["@punctuation.delimiter"] = { fg = quoteFg },
  ["@markup.list"] = { fg = brightTeal },
  ["@string.escape"] = { link = "Constant" },
  ["@string.regexp"] = { link = "Constant" },
  ["@string.special.url.comment"] = { fg = brightTeal, underline = true },
  ["@markup.link.label.symbol"] = { fg = dimBlue },
  ["@tag.attribute"] = { fg = normalFg },
  ["@tag.delimiter"] = { fg = quoteFg },
  ["@diff.delta"] = { link = "DiffChanged" },
  ["@diff.minus"] = { link = "DiffRemoved" },
  ["@diff.plus"] = { link = "DiffAdded" },
  ["@markup.emphasis"] = { italic = true },
  ["@markup.environment"] = { link = "Keyword" },
  ["@markup.environment.name"] = { link = "String" },
  ["@markup.raw"] = { link = "String" },
  ["@comment.info"] = { bg = nil, fg = brightBlue, bold = true }, -- bg turned to nil, old: "#6A9589"
  ["@markup.quote"] = { link = "@variable.parameter" },
  ["@markup.strong"] = { link = "markdownBold" },
  ["@markup.italic.markdown_inline"] = { italic = true },
  ["@markup.heading"] = { link = "Function" },
  -- stylua: ignore start
  ["@markup.heading.1.markdown"] = { fg = dimRed,       bg = darkRed, bold = true },
  ["@markup.heading.2.markdown"] = { fg = brightOrange, bg = darkOrange, bold = true },
  ["@markup.heading.3.markdown"] = { fg = dimYellow,    bg = darkYellow, bold = true },
  ["@markup.heading.4.markdown"] = { fg = brightGreen,  bg = darkGreen, bold = true },
  ["@markup.heading.5.markdown"] = { fg = dimBlue,      bg = brightBlue, bold = true },
  ["@markup.heading.6.markdown"] = { fg = brightPurple, bg = darkPurple, bold = true },
  -- stylua: ignore end
  ["@markup.heading.1.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.2.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.3.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.4.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.5.marker.markdown"] = { link = "Delimiter" },
  ["@markup.heading.6.marker.markdown"] = { link = "Delimiter" },
  -- ["@markup.markdown_inline"] = { fg = c_macroFg0 },
  ["@markup.strikethrough.markdown_inline"] = { strikethrough = true },
  ["@comment.todo.checked"] = { link = "Comment" },
  ["@comment.todo.unchecked"] = { fg = dimRed },
  ["@markup.link.label.markdown_inline"] = { link = "htmlLink" },
  ["@markup.link.url.markdown_inline"] = { fg = ashGrey, underline = true },
  -- below are overriden by todo-comments
  -- ["@comment.error"] = { bg = c_lotusRed1, fg = c_macroFg0, bold = true },
  -- ["@comment.warning"] = { bg = c_roninYellow, fg = c_waveBlue0, bold = true },
  ["@variable"] = { fg = normalFg },
  ["@variable.builtin"] = { fg = dimRed, italic = true },
  -- }}}

  -- LSP semantic {{{2
  ["@lsp.mod.readonly"] = { link = "Constant" },
  ["@lsp.mod.typeHint"] = { link = "Type" },
  ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
  ["@lsp.type.comment"] = { fg = "NONE" },
  ["@lsp.type.macro"] = { fg = dimPurple },
  ["@lsp.type.magicFunction"] = { link = "@function.builtin" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
  ["@lsp.type.variable"] = { fg = "NONE" },
  ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
  ["@lsp.typemod.function.readonly"] = { bold = true, fg = dimBlue },
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
  DiagnosticError = { fg = dimRed },
  DiagnosticHint = { fg = dimBlue },
  DiagnosticInfo = { fg = dimBlue },
  DiagnosticOk = { fg = dimGreen },
  DiagnosticWarn = { fg = dimYellow },
  DiagnosticSignError = { fg = dimRed },
  DiagnosticSignHint = { fg = dimBlue },
  DiagnosticSignInfo = { fg = dimBlue },
  DiagnosticSignWarn = { fg = dimYellow },
  DiagnosticUnderlineError = { sp = dimRed, undercurl = true },
  DiagnosticUnderlineHint = { sp = dimBlue, undercurl = true },
  DiagnosticUnderlineInfo = { sp = dimBlue, undercurl = true },
  DiagnosticUnderlineWarn = { sp = dimYellow, undercurl = true },
  DiagnosticVirtualTextError = { bg = darkRed, fg = dimRed },
  DiagnosticVirtualTextHint = { bg = darkGreen, fg = dimBlue },
  DiagnosticVirtualTextInfo = { bg = darkBlue, fg = dimBlue },
  DiagnosticVirtualTextWarn = { bg = darkYellow, fg = dimYellow },
  DiagnosticUnnecessary = {
    fg = ashGrey,
    sp = dimBlue,
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
  htmlH1 = { fg = dimBlue, bold = true },
  htmlH2 = { fg = dimYellow, bold = true },
  htmlH3 = { fg = brightGreen, bold = true },
  htmlH4 = { fg = dimGreen, bold = true },
  htmlH5 = { fg = brightPurple, bold = true },
  htmlH6 = { fg = dimTeal, bold = true },
  htmlItalic = { italic = true },
  htmlLink = { fg = dimBlue, underline = true, sp = dimBlue },
  htmlSpecialChar = { link = "SpecialChar" },
  htmlSpecialTagName = { fg = dimTeal },
  htmlString = { link = "String" },
  htmlTagName = { link = "Tag" },
  htmlTitle = { link = "Title" },

  -- Markdown
  markdownBold = { bold = true, fg = dimYellow },
  markdownBoldItalic = { bold = true, italic = true },
  markdownCode = { fg = dimGreen },
  markdownCodeBlock = { fg = dimGreen },
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
  healthError = { fg = dimRed },
  healthSuccess = { fg = brightGreen },
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
  BlinkCmpCompletionBorder = { bg = brightBlue, fg = brightBlue },
  BlinkCmpCompletionSbar = { link = "PmenuSbar" },
  BlinkCmpCompletionSel = { bg = brightBlue, fg = "NONE" },
  BlinkCmpCompletionThumb = { link = "PmenuThumb" },
  BlinkCmpDocumentation = { link = "NormalFloat" },
  BlinkCmpDocumentationBorder = { link = "FloatBorder" },
  BlinkCmpItemAbbr = { fg = quoteFg },
  BlinkCmpItemAbbrDeprecated = { fg = ashGrey, strikethrough = true },
  BlinkCmpItemAbbrMatch = { fg = dimRed },
  BlinkCmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
  BlinkCmpKindClass = { link = "Type" },
  BlinkCmpKindConstant = { link = "Constant" },
  BlinkCmpKindConstructor = { link = "@constructor" },
  BlinkCmpKindCopilot = { link = "String" },
  BlinkCmpKindDefault = { fg = ashGrey },
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
  BlinkCmpKindSnippet = { fg = brightTeal },
  BlinkCmpKindStruct = { link = "Type" },
  BlinkCmpKindText = { fg = quoteFg },
  BlinkCmpKindTypeParameter = { link = "Type" },
  BlinkCmpKindValue = { link = "String" },
  BlinkCmpKindVariable = { fg = dimOrange },
  BlinkCmpLabelMatch = { link = "Special" },

  -- gitsigns
  GitSignsAdd = { link = "DiffAdded" },
  GitSignsChange = { fg = brightPurple },
  GitSignsDelete = { fg = dimRed },
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
  GitSignsCurrentLineBlame = { fg = ashGrey, italic = true },

  --noice
  NoicePopupmenuSelected = { link = "Visual" },
  NoiceScrollBar = { bg = normalBg },
  NoiceMini = { link = "Comment" },

  -- nvim-dap-ui (one day I'll use this)
  DapUIBreakpointsCurrentLine = { bold = true, fg = normalFg },
  DapUIBreakpointsDisabledLine = { link = "Comment" },
  DapUIBreakpointsInfo = { fg = dimBlue },
  DapUIBreakpointsPath = { link = "Directory" },
  DapUIDecoration = { fg = brightPurple },
  DapUIFloatBorder = { fg = brightPurple },
  DapUILineNumber = { fg = brightTeal },
  DapUIModifiedValue = { bold = true, fg = brightTeal },
  DapUIPlayPause = { fg = dimGreen },
  DapUIRestart = { fg = dimGreen },
  DapUIScope = { link = "Special" },
  DapUISource = { fg = dimRed },
  DapUIStepBack = { fg = brightTeal },
  DapUIStepInto = { fg = brightTeal },
  DapUIStepOut = { fg = brightTeal },
  DapUIStepOver = { fg = brightTeal },
  DapUIStop = { fg = dimRed },
  DapUIStoppedThread = { fg = brightTeal },
  DapUIThread = { fg = normalFg },
  DapUIType = { link = "Type" },
  DapUIUnavailable = { link = "Comment" },
  DapUIWatchesEmpty = { fg = dimRed },
  DapUIWatchesError = { fg = dimRed },
  DapUIWatchesValue = { fg = normalFg },

  -- lazy.nvim
  LazyProgressTodo = { link = "NonText" },

  -- mini.files
  -- MiniFilesNormal = { bg = nil },
  MiniFilesNormal = { link = "NormalFloat" },
  MiniFilesTitle = { bg = nil, fg = quoteFg },
  MiniFilesDirectory = { fg = dimBlue },
  MiniFilesTitleFocused = { bg = nil, fg = quoteFg },
  MiniFilesBorder = { link = "FloatBorder" },

  -- incline
  InclineNormal = { link = "Pmenu" },
  InclineNormalNC = { link = "Pmenu" },

  -- snacks indent/picker
  SnacksIndent = { fg = selectionBg },
  SnacksIndentScope = { fg = brightPurple },
  SnacksPickerListCursorLine = { link = "Visual" },
  SnacksPickerPreviewCursorLine = { link = "CursorLine" },
  -- how to highlight chars that from query that match item in list
  -- using a special style here kinda sucks when searching highlights in picker
  SnacksPickerMatch = {},

  -- neocodeium
  NeoCodeiumSuggestion = { link = "NonText" },
  NeoCodeiumLabel = { fg = normalFg, bg = cursorlineBg },

  -- treesitter context
  TreesitterContext = { bg = nil },
  TreesitterContextLineNumber = { bg = nil, fg = brightPurple },
  TreesitterContextLineNumberBottom = { underdashed = false, bg = nil, sp = brightPurple },
  TreesitterContextBottom = { underdashed = false, bg = nil, sp = brightPurple },

  -- render-markdown.nvim
  RenderMarkdownH1Bg = { bg = darkRed },
  RenderMarkdownH2Bg = { bg = darkOrange },
  RenderMarkdownH3Bg = { link = "@markup.heading.3.markdown" },
  RenderMarkdownH4Bg = { link = "@markup.heading.4.markdown" },
  RenderMarkdownH5Bg = { link = "@markup.heading.5.markdown" },
  RenderMarkdownH6Bg = { link = "@markup.heading.6.markdown" },

  -- for lualine
  HostNameIcon = { fg = ashGrey, bg = nil },

  PVSBlue = { fg = "#007ad3" },
  -- }}}2
}
-- }}}1

-- Set highlight groups {{{1
for hlgroup_name, hlgroup_attr in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end
-- }}}1

-- !vim:ts=2:sw=2:sts=2:fdm=marker:fdl=1
