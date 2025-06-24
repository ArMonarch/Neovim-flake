-- function for easier keymap setting
function map(mode, keys, func, options)
  vim.keymap.set(mode, keys, func, options)
end

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
-- Save File
map( { "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" } )

-- Open Netrw explorer
map( { "n" }, "<leader>sn", "<cmd>Ex<cr>", { desc = "Netrw File Explorer" })

-- LazyGit
if vim.fn.executable('lazygit') == 1 then
  -- TODO: Lazygit Root Directory [Snacks.lazygit({ cwd = root.git() })](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/root.lua#L178)
  map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = "Lazygit (Root Dir)" }) 
  map('n', '<leader>gG', function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" }) 
  map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
  map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
end

-- Git
map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({"n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })
