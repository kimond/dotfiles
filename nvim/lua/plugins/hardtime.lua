return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disabled = true,
    disable_mouse = false,
    disabled_keys = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<Left>"] = {},
      ["<Right>"] = {},
    },
  },
  keys = {
    {
      "<leader>uB",
      "<cmd>:Hardtime toggle<cr>",
      desc = "Toggle Hardtime",
    },
  },
}
