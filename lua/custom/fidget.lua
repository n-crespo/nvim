local M = {}

function M.start_progress()
  if M.progress_handle then
    M.progress_handle.message = "Abort."
    M.progress_handle = nil
  end

  M.progress_handle = {
    title = "",
    message = "Thinking...",
    lsp_client = { name = "CodeCompanion" },
  }

  -- Simulate progress start (e.g., log or display a message)
  vim.notify(M.progress_handle.message)
end

function M.stop_progress()
  if M.progress_handle then
    M.progress_handle.message = "Done."
    -- Simulate progress stop (e.g., log or display a message)
    vim.notify(M.progress_handle.message)
    M.progress_handle = nil
  end
end

function M.setup_progress()
  -- New AU group:
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  -- Attach:
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        M.start_progress()
      elseif request.match == "CodeCompanionRequestFinished" then
        M.stop_progress()
      end
    end,
  })
end

return M
