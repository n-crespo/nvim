-- use R to run any file! very nice
-- this overrides the vim native replace mode which i never use
return {
  "CRAG666/code_runner.nvim",
  keys = {
    {
      "R",
      function()
        require("code_runner").run_code()
      end,
      desc = "Run Code",
    },
    {
      "q",
      "<cmd>close<cr>",
      buffer = true,
      ft = "crunner",
      silent = true,
    },
  },
  config = true,
  opts = {
    project_path = vim.fn.expand("~/.config/nvim/project_manager.json"),
    mode = "term",
    startinsert = false,
    filetype = {
      python = "python3 -u '$dir/$fileName'",
      ghostty = "echo Validating config...;ghostty +validate-config --config-file=$dir/$fileName",
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
}
