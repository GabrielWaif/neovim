local use_java = false

local system = ""
local user = 'gabri'
local workspace_dir = 'G:/src/java/'

if not use_java then
	return
end

if system == 'windows' then
	local jdtls_path = 'C:/Users/'..user..'/AppData/Local/nvim-data/mason/share/jdtls'
	local path_to_lsp_server = "C:/Users/"..user.."/AppData/Local/nvim-data/mason/packages/jdtls/config_win"
	local path_to_plugins = jdtls_path .. "/plugins/"
	local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

	local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local root_dir = require("jdtls.setup").find_root(root_markers);
	if root_dir == nil then
		return
	else root_dir = string.gsub(root_dir, '\\', '/')
	end

	local config = {
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
		root_dir = root_dir,
		filetypes = { 'java' },
		settings = {
			java = {
			};
		},
		init_options = {
			bundles = {}
		},
	}
	require('jdtls').start_or_attach(config)
else end
