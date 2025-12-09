local dap, dapui, dapvtext = require("dap"), require("dapui"), require("nvim-dap-virtual-text")
local dap_pkg_base_path = vim.fn.stdpath("data") .. "/mason"

dapvtext.setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = false,
    all_references = false,
    clear_on_continue = false,
    all_frames = false,
    virt_text_pos = "inline",
    virt_lines = false,
})

-- DAP Signs: DapBreakpoint|DapBreakpointCondition|DapLogPoint|DapStopped|DapBreakpointRejected

vim.fn.sign_define(
    "DapStopped",
    { text = "󱤴", texthl = "DiagnosticNrHint", linehl = "DiagnosticLineHint", numhl = "DiagnosticNrHint" }
)

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "󱤸", texthl = "DiagnosticNrInfo", linehl = "DiagnosticLineInfo", numhl = "DiagnosticNrInfo" }
)

--- @diagnostic disable: missing-fields
dapui.setup({
    icons = {
        expanded = "󰁆",
        collapsed = "󰜴",
        current_frame = "󰛄",
    },
    controls = {
        icons = {
            disconnect = "⏏",
            pause = "⏸",
            play = "▶",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "⏹",
        },
    },
})

dap.defaults.fallback.focus_terminal = true

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.attach["dapui_config"] = dapui.open
dap.listeners.before.launch["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- REPL commands
dap.repl.commands = vim.tbl_extend("force", dap.repl.commands, {
    exit = { "exit", ".exit", ".e" },
    next_ = { ".next", ".n" },
    continue = { ".continue", ".c" },
    step_back = { ".back", ".b" },
    into = { ".into", ".in" },
    out = { ".out", ".o" },
    scopes = { ".scopes" },
    threads = { ".threads" },
    frames = { ".frames" },
    up = { ".up", ".u" },
    down = { ".down", ".d" },
    goto_ = { ".goto" },
    pause = { ".pause", ".p" },
    clear = { ".clear" },
    capabilities = { ".capabilities" },
    help = { "help", ".help", ".h" },
    custom_commands = {
        [".restart"] = dap.restart,
    },
})

-- Preconfigured adapters

require("dap-python").setup("debugpy-adapter")

require("dap-go").setup({
    delve = {
        detached = vim.fn.has("win32") == 0,
    },
})

-- Adapters configuration

dap.adapters.bashdb = {
    type = "executable",
    command = dap_pkg_base_path .. "/packages/bash-debug-adapter/bash-debug-adapter",
    name = "bashdb",
}

dap.configurations.sh = {
    {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = dap_pkg_base_path .. "/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = dap_pkg_base_path .. "/packages/bash-debug-adapter/extension/bashdb_dir",
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        argsString = "",
        env = {},
        terminalKind = "integrated",
    },
}

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = dap_pkg_base_path .. "/bin/js-debug-adapter",
        args = { "${port}" },
    },
}

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.typescript = dap.configurations.javascript
