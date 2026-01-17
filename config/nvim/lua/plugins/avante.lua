require("avante").setup({
    mode = "agentic",
    provider = "gemini",
    instructions_file = "AGENT.md",
    providers = {
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-5-20250929",
            disable_tools = true,
            timeout = 30000,
            extra_request_body = {
                temperature = 0.65,
                max_tokens = 8192,
            },
        },
        gemini = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
            model = "gemini-2.5-flash",
            timeout = 30000,
            context_window = 32768,
            extra_request_body = {
                generationConfig = {
                    temperature = 0.65,
                },
            },
        },
    },
    input = {
        provider = "snacks",
        provider_opts = {
            title = "Avante Input",
            icon = "󰯄 ",
            placeholder = "Enter your API key...",
        },
    },
    behaviour = {
        auto_suggestions = false,
        minimize_diff = false,
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
    },
})
