-- function for easier keymap setting
function map(mode, keys, func, options)
  vim.keymap.set(mode, keys, func, options)
end

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
