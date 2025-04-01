-- use R to run any file! very nice
-- this overrides the vim native replace mode, which i never use
return {
  "CRAG666/code_runner.nvim",
  event = "LazyFile",
  dependencies = {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n" },
        { "R", "<cmd>RunCode<cr>", desc = "Run Code" },
      },
    },
  },
  config = true,
  opts = {
    project_path = vim.fn.expand("~/.config/nvim/project_manager.json"),
    mode = "term",
    startinsert = false,
    filetype = {
      python = "python -u '$dir/$fileName'",
      javascript = "node",
      java = "cd $dir && javac $fileName -d bin/ && java -cp $dir/bin/ $fileNameWithoutExt",
      cpp = {
        'cd "$dir" &&',
        "g++ $fileName",
        "-o /tmp/$fileNameWithoutExt &&",
        "/tmp/$fileNameWithoutExt",
      },
    },
    project = {
      ["~/grade%-12/csa/2/AmusementPark/src/.-"] = {
        name = "Amusement Park",
        description = "Amusement Park Game",
        -- javac */java -d bin/ && java -cp bin/ src.Main
        command = "rjall",
      },
      ["~/college/cs31/proj5/.-"] = {
        name = "Project 5",
        description = "Project 5",
        command = "clang++ *.cpp -o /tmp/a.out && /tmp/a.out",
      },
    },
    term = {
      position = "bot", -- horiz, top, vert
      size = 18,
    },
  },
  init = function()
    -- Close Code Runner buffers with 'q'
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "crunner",
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        vim.opt_local.scrolloff = 0
      end,
    })
    -- go to top of buffer when runner is opened
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      pattern = "crunner",
      callback = function()
        vim.cmd([[norm gg]])
      end,
    })
  end,
}
