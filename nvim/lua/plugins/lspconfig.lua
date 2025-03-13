return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        filetypes_include = { "templ", "jinja" },
        -- to fully override the default_config, change the below
        -- filetypes = {}
      },
    },
  },
}
