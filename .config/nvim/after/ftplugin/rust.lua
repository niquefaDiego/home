vim.api.nvim_create_user_command(
    "Wf",
    function()
        vim.cmd("w")
        vim.cmd("!cargo check")
    end,
    { nargs = 0 }
);

vim.api.nvim_create_user_command(
    "Wr",
    function()
        vim.cmd("w")
        if vim.fn.filereadable("./run.ps1") == 1 then
            vim.cmd("!powershell.exe -File run.ps1")
        else
            vim.cmd("!cargo run")
        end
    end,
    { nargs = 0 }
);

