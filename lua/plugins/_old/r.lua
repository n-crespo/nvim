-- i no longer write R regularly
do
  return {}
end

M = {}

if vim.fn.executable("R") == 1 then
  M = {
    -- most of this is stolen from the extras/lang/r.lus from LazyVim
    {
      "R-nvim/R.nvim",
      ft = { "r", "rmarkdown", "rmd" },
      lazy = true,
      cond = vim.fn.executable("R") == 1,
      opts = {
        R_args = { "--quiet", "--no-save" },
        disable_cmds = {
          "RSaveClose",
          "RCustomStart",
          "RSweave",
          "RMakeODT",
          "RMakeWord",
          "RKnitRmCache",
          "RMakeAll",
          "RMakePDFKb",
          "RQuartoPreview",
          "RBibTeXK",
          "RBibTeX",
          "RQuartoStop",
          "RSeparatePathHere",
          "RShowEx",
          "RSeparatePathPaste",
          "RShowArgs",
          "RSummary",
          "RObjectNames",
          "RObjectStr",
          "RSPlot",
          "RSetwd",
          "RClearAll",
          "RShowRout",
          "RListSpace",
          "RObjectPr",
          "RPlot",
          "RSendLine",
          "RSendAllFun",
          "RSendCurrentFun",
          "RFormatNumbers",
          "RFormatSubsetting",
          "RSendChain",
          "RNLeftPart",
          "RNLeftPart",
          "RILeftPart",
          "RSendParagraph",
          "RDSendMBlock",
          "RDSendCurrentFun",
          "RDSendSelection",
          "RInsertLineOutput",
          "RIRightPart",
          "RDSendChunk",
          "RNRightPart",
          "RSendMotion",
          "RSendLAndOpenNewOne",
          "RSendMBlock",
          "RNextRChunk",
          "RPreviousRChunk",
          "ROBOpenLists",
          "ROBCloseLists",
          "RDSendParagraph",
          "RViewDFs",
          "RDputObj",
          "RUndebug",
          "RDebug",
          "ROBToggle", -- object browser (?)
          "RSendSelection",
        },
        hook = {
          on_filetype = function()
            vim.keymap.set("n", "<C-Enter>", "<Plug>RDSendLine", { buffer = true })
            vim.keymap.set("v", "<C-Enter>", "<Plug>RSendSelection", { buffer = true })
            vim.keymap.set("i", "<C-b>", "```{r}<cr><cr>```<up>", { buffer = true })

            local wk = require("which-key")
            wk.add({
              buffer = true,
              mode = { "n", "v" },
              { "<localleader>a", group = "all" },
              { "<localleader>b", group = "between marks" },
              { "<localleader>c", group = "code/chunks" },
              { "<localleader>f", group = "functions" },
              { "<localleader>g", group = "goto" },
              { "<localleader>i", group = "install" },
              { "<localleader>k", group = "knit" },
              { "<localleader>p", group = "paragraph" },
              { "<localleader>q", group = "quarto" },
              { "<localleader>r", group = "r general" },
              { "<localleader>s", group = "split or send" },
              { "<localleader>t", group = "terminal" },
              { "<localleader>v", group = "view" },
            })
          end,
        },
        pdfviewer = "",
      },
      config = function(_, opts)
        vim.g.rout_follow_colorscheme = true
        require("r").setup(opts)
        require("r.pdf.generic").open = vim.ui.open
      end,
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          r_language_server = {
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
                or vim.loop.os_homedir()
            end,
          },
        },
      },
    },
    {
      "saghen/blink.cmp",
      dependencies = {
        "R-nvim/cmp-r",
        "saghen/blink.compat",
      },
      opts = {
        sources = {
          compat = {
            cmp_r = { name = "cmp_r", module = "blink.compat.source" },
          },
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = { ensure_installed = { "r", "rnoweb" } },
    },
    {
      "nvim-neotest/neotest",
      optional = true,
      dependencies = {
        "shunsambongi/neotest-testthat",
      },
      opts = {
        adapters = {
          ["neotest-testthat"] = {},
        },
      },
    },
  }
end
return M
