-- just disable telemetry
return {
  "zbirenbaum/copilot.lua",
  opts = {
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
  },
}
