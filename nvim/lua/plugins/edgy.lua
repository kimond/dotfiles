return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {
    left = {
      { title = "Neotest Summary", ft = "neotest-summary" },
      {
        title = "Neo-Tree",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { height = 0.5 },
      },
    },
  },
}
