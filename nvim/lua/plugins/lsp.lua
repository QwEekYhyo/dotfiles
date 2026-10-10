return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "rust_analyzer",
          "html",
          "cssls",
          "ts_ls",
          "jdtls",
        },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local function setup(server)
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end

      setup("clangd")
      setup("rust_analyzer")
      setup("html")
      setup("cssls")
      setup("ts_ls")
      setup("jdtls")
      setup("lua_ls")
      setup("pyright")
    end,
  },
}
