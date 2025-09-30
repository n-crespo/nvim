return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  -- build = "cargo build --release",
  opts = {
    cmdline = {
      enabled = true,
      keymap = {
        ["<C-j>"] = {
          "select_next",
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true)
          end,
        },
        ["<C-k>"] = {
          "select_prev",
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
          end,
        },
        ["<C-n>"] = {
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true)
          end,
        },
        ["<C-p>"] = {

          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
          end,
        },
        ["<C-space>"] = { "show", "hide" }, -- used by neocodeium
        ["<Tab>"] = {
          "select_and_accept",
          "fallback",
        },
      },
      completion = { menu = { auto_show = true } },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
    },
    fuzzy = { sorts = { "exact", "score", "sort_text" } }, -- prioritize exact matches
    sources = {
      providers = {
        snippets = {
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
          end,
        },
        markdown = {
          name = "RenderMarkdown",
          module = "render-markdown.integ.blink",
          fallbacks = { "lsp" },
        },
        buffer = {
          opts = {
            -- get words from all active buffers for cmp list
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
        path = {
          opts = {
            show_hidden_files_by_default = true,
          },
        },
      },
    },
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      -- menu = {
      -- border = "none",
      -- auto_show = true,
      -- draw = {
      --   columns = {
      --     { "label", "label_description", gap = 1 },
      --     { "kind_icon", "kind", gap = 0 },
      --   },
      -- },
      -- },
      documentation = {
        window = {
          border = "rounded",
          winhighlight = "FloatBorder:FloatBorder",
        },
      },
    },
    signature = {
      enabled = true,
      trigger = {
        show_on_insert = true,
        show_on_insert_on_trigger_character = true,
      },
      window = {
        show_documentation = true,
        border = "rounded",
        winhighlight = "FloatBorder:FloatBorder",
      },
    },
    keymap = {
      ["<C-n>"] = {},
      ["<C-p>"] = {},
      ["<S-CR>"] = {},
      ["<CR>"] = {},
      ["<C-space>"] = { "show", "hide" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-CR>"] = { "select_and_accept", "fallback" }, -- for accepting from blink
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
    },
  },
}
