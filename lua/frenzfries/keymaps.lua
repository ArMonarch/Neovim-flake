-- function for easier keymap setting
function map(mode, keys, func, options)
  vim.keymap.set(mode, keys, func, options)
end

-- Save File
map( { "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" } )

-- Open Netrw explorer
map( { "n" }, "<leader>on", "<cmd>Ex<cr>", { desc = "Open Netrw file explorer" })
