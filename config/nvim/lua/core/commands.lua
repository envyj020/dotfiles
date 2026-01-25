vim.api.nvim_create_user_command("TSISync", function(args)
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        print(args.name .. ": nvim-treesitter couldn't be loaded")
        vim.cmd("cquit 1")
    end
    treesitter.install(require("extensions.treesitter.parsers")):wait(10 * 60 * 1000)
end, { desc = "Install Treesitter parsers synchronously" })
