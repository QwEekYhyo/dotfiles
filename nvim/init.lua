require("config.lazy")

local vim = vim

local o = vim.opt
 
-- Appearance
o.termguicolors  = true
o.number         = true
o.relativenumber = true
o.cursorline     = true
o.signcolumn     = "yes"
o.showmode       = false   -- lualine handles this
o.scrolloff      = 8
o.sidescrolloff  = 8
o.wrap           = false
o.list           = true
o.listchars      = { tab = "→ ", trail = "·", nbsp = "␣" }
 
-- Indentation
o.expandtab      = true
o.shiftwidth     = 4
o.tabstop        = 4
o.smartindent    = true
 
-- Search
o.ignorecase     = true
o.smartcase      = true
o.hlsearch       = false
o.incsearch      = true
 
-- Splits
o.splitright     = true
o.splitbelow     = true
 
-- Behavior
o.clipboard      = "unnamedplus"  -- system clipboard
o.mouse          = "a"
o.undofile       = true           -- persistent undo
o.updatetime     = 150
o.timeoutlen     = 300
o.completeopt    = { "menuone", "noselect" }
o.shortmess:append("c")

-- ── LSP ──────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

-- Enable terminal transparency
local function set_transparent_background()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "NonText",
    "SignColumn",
    "EndOfBuffer",
    "MsgArea",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, {
      bg = "NONE",
      ctermbg = "NONE",
    })
  end
end

set_transparent_background()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_transparent_background,
})

-- -- ── LSP ──────────────────────────────────────────────────────
-- local lsp_on_attach = function(_, bufnr)
--   local bmap = function(mode, lhs, rhs, desc)
--     vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
--   end
--   bmap("n", "gD",         vim.lsp.buf.declaration,     "Declaration")
--   bmap("n", "gd",         vim.lsp.buf.definition,      "Definition")
--   bmap("n", "gi",         vim.lsp.buf.implementation,  "Implementation")
--   bmap("n", "K",          vim.lsp.buf.hover,            "Hover")
--   bmap("n", "<leader>rn", vim.lsp.buf.rename,           "Rename")
--   bmap("n", "<leader>ca", vim.lsp.buf.code_action,      "Code action")
--   bmap("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format")
-- end
--  
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if cmp_lsp_ok then
--   capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
-- end
