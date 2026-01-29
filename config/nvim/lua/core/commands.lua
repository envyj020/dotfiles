local common = require("common")

vim.api.nvim_create_user_command("TSISync", function(args)
    if not common.headless then
        vim.notify(string.format("%s is meant to be executed in headless mode", args.name), vim.log.levels.ERROR)
        vim.cmd("cquit 1")
    end
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        vim.notify(args.name .. ": nvim-treesitter couldn't be loaded", vim.log.levels.ERROR)
        vim.cmd("cquit 1")
    end
    treesitter.install(require("extensions.treesitter.parsers")):wait(10 * 60 * 1000)
end, { desc = "Install Treesitter parsers synchronously" })

vim.api.nvim_create_user_command("MasonISync", function(args)
    if not common.headless then
        vim.notify(string.format("%s is meant to be executed in headless mode", args.name), vim.log.levels.ERROR)
        vim.cmd("cquit 1")
    end

    local ok, mason = pcall(require, "mason.api.command")
    if not ok then
        vim.notify(args.name .. ": mason API couldn't be loaded", vim.log.levels.ERROR)
        vim.cmd("cquit 1")
    end

    local registry = require("mason-registry")
    local packages = require("extensions.mason.packages").PACKAGES
    local mappings = require("mason-lspconfig.mappings")
    local server_mapping = mappings.get_mason_map()

    local mason_packages = vim.iter(packages)
        :map(function(package_identifier)
            local package, version = unpack(vim.split(package_identifier, "@"))
            local package_name = server_mapping.lspconfig_to_package[package]

            if not package_name then
                vim.notify(
                    string.format("%s: Package '%s' is not mapped to any mason package", args.name, package),
                    vim.log.levels.INFO
                )
                return nil
            end

            local package_id = version and string.format("%s@%s", package_name, version) or package_name
            return not registry.is_installed(package_name) and package_id or nil
        end)
        :totable()

    mason.MasonInstall(mason_packages)
end, { desc = "Install Mason packages synchronously" })
