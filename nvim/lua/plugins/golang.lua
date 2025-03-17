vim.api.nvim_create_user_command("Golines", function()
  return require("conform").format({
    -- async means discarded if the file is modified before the formatting is done
    async = true,
    lsp_format = "never",
    bufnr = 0,
    formatters = { "golines" },
  })
end, {})

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "golangci-lint", "golines" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "templ" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
}
