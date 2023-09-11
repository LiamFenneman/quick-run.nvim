local M = {}
local config = {}
local state = {}

local default_config = {
    default_cmd = 'echo "Hello World"',
    mappings = {
        quick_run = '<F5>',
    },
    callbacks = {
        on_stdout = function(_, data, _)
            vim.api.nvim_out_write(table.concat(data, '\n'))
        end,
        on_stderr = function(_, data, _)
            vim.api.nvim_err_write(table.concat(data, '\n'))
        end,
        on_exit = function(_, data, _) end,
    },
}

local function merge_tbl(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k]) == 'table' then
                t1[k] = merge_tbl(t1[k], t2[k])
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

--- Setup quick-run plugin.
function M.setup(cfg)
    -- Merge user config with default config
    cfg = cfg or {}
    cfg = merge_tbl(default_config, cfg)
    config = cfg

    -- Setup state
    state.cmd = config.default_cmd

    -- Setup mappings
    vim.keymap.set({ 'n', 'v' }, config.mappings.quick_run, M.run, { silent = false, desc = "Quick Run" })

    -- Setup commands
    vim.api.nvim_create_user_command('QuickRun', M.set_cmd, { nargs = '?' })
end

-- Set command to run.
function M.set_cmd(opts)
    state.cmd = opts.args or state.cmd
end

-- Run the command previously set or the default command.
function M.run()
    local job = vim.fn.jobstart(state.cmd, {
        on_stdout = config.callbacks.on_stdout,
        on_stderr = config.callbacks.on_stderr,
        on_exit = config.callbacks.on_exit
    })
end

return M
