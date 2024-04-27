local M = {}

---@param from string
---@param to string
function M.on_rename(from, to)
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local method = "workspace/willRenameFiles"
    if client.supports_method(method) then
      local resp = client.request_sinc(method, {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

return M
