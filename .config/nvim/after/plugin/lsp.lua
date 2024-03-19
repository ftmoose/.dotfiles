-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
	local keymap_opts = { buffer = buffer }

	vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
	vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
	vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
	vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
	vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)	

	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
end

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 200 })
	end,
	group = format_sync_grp,
})

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require('rust-tools').setup(opts)

local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
	preselect = true,
	
	snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<Tab>'] = cmp.mapping.confirm({select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	},

	sources = {
		{name = 'nvim_lsp'},
		{name = 'vsnip'},
		{name = 'path'},
		{name = 'buffer'},
	}

})
