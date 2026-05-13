
print("Loading webdev")

local run_in_terminal = function(command)
    local terminal_job_id = 0;
    vim.cmd.vnew()
    vim.cmd.term()
    terminal_job_id = vim.bo.channel
    vim.fn.chansend(terminal_job_id, command .. "\r\n")
end

vim.keymap.set("n", "<leader>tt", function()
    run_in_terminal("bun test")
end)

vim.keymap.set("n", "<leader>tr", function()
    run_in_terminal("bun start")
end)
