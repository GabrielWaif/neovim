local lsp = require("lsp-zero")

local system = "linux";

lsp.preset("recommended") -- Chooses the default settings for LSP

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'jdtls',
  'lua_ls'
}) -- The LSP libraries that are automatically installed 

vim.keymap.set("n", "<leader>lr", ":w<CR>:LspRestart<CR>", {}); -- Lsp reload

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select), -- Goes to next option on LSP
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select), -- Goes to next option on LSP
  ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Goes to confirms option in LSP
  ["<C-Space>"] = cmp.mapping.complete(), -- Calls LSP
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
}) -- Saves the cmp options 

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
}) -- The letters that appear in the side of the line when there is a information to be displayed

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)

if system == "windows" then
	local user = 'gabri'
	local workspace_dir = 'G:/src/java/'
	local jdtls_path = 'C:/Users/'..user..'/AppData/Local/nvim-data/mason/share/jdtls'
	local path_to_lsp_server = "C:/Users/"..user.."/AppData/Local/nvim-data/mason/packages/jdtls/config_win"
	local path_to_plugins = jdtls_path .. "/plugins/"
	local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

	local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local root_dir = require("jdtls.setup").find_root(root_markers);

	local java_root_finder = (function()
		return root_dir;
	end)

	lsp.configure('jdtls',
		{
			cmd = {
				'java',
				'-Declipse.application=org.eclipse.jdt.ls.core.id1',
				'-Dosgi.bundles.defaultStartLevel=4',
				'-Declipse.product=org.eclipse.jdt.ls.core.product',
				'-Dlog.protocol=true',
				'-Dlog.level=ALL',
				'-Xms1g',
				'--add-modules=ALL-SYSTEM',
				'--add-opens', 'java.base/java.util=ALL-UNNAMED',
				'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

				'-jar', path_to_jar,
				'-configuration', path_to_lsp_server,
				'-data', workspace_dir,
			},
			root_dir = java_root_finder,
		}
	)
else end

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
