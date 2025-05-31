return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
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
        snippets = { min_keyword_length = 2 },
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
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 0 },
          },
        },
      },
      documentation = {
        window = {
          border = "single",
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
      ["<C-n>"] = {}, -- used by neocodeium
      ["<C-p>"] = {}, -- used by neocodeium
      ["<S-CR>"] = {}, -- make new line (ignore cmp)
      ["<CR>"] = {}, -- for accepting from blink
      ["<Tab>"] = { "select_and_accept", "fallback" }, -- for accepting from blink
      ["<C-CR>"] = { "select_and_accept", "fallback" }, -- for accepting from blink
      ["<C-e>"] = { "hide", "show", "fallback" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },
}
