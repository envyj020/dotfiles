require("avante").setup({
    provider = "gemini",
    providers = {
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-20250514",
            disable_tools = true,
            timeout = 30000,
            extra_request_body = {
                temperature = 0,
                max_tokens = 8192,
            },
        },
        gemini = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
            model = "gemini-2.5-flash-preview-09-2025",
            timeout = 30000,
            extra_request_body = {
                temperature = 0.25,
            },
        },
    },
    behaviour = {
        auto_suggestions = false,
        minimize_diff = false,
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
    },
})
