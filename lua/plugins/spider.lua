-- w, e, and b respect pascalCase/CamelCase/snake_case/etc and ignore non-essential characters
return {
  "chrisgrieser/nvim-spider",
  vscode = true,
  keys = {
    {
      "e",
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "w",
      function()
        require("spider").motion("w")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "e",
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "b",
      function()
        require("spider").motion("b")
      end,
      mode = { "n", "o", "x" },
    },
    {
      "ge",
      function()
        require("spider").motion("ge")
      end,
      mode = { "n", "o", "x" },
    },
  },
}
