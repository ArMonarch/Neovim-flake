-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd( 'TextYankPost', {
  desc = 'Highlight when yanking (copying) text | Briefly highlight yanked text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lsp_hishlight = vim.api.nvim_create_augroup('lsp-hishlight', { clear = false })

-- Highlight refrences of the word under the cursor
vim.api.nvim_create_autocmd({'CursorMoved', 'cursorMovedI'}, {
  desc = 'Highlight refrences of the word under the cursor',
  group = lsp_hishlight,
  pattern = {'*.c', '*.h', '*.py', '*.rs', '*.lua', '*.nix', '*.js', '*.ts', '*.jsx', '*.tsx', '*.zig'},
  callback = vim.lsp.buf.document_highlight,
})

-- Highlight refrences of the word under the cursor
vim.api.nvim_create_autocmd({'CursorMoved', 'cursorMovedI'}, {
  desc = 'Highlight refrences of the word under the cursor',
  group = lsp_hishlight,
  pattern = {'*.c', '*.h', '*.py', '*.rs', '*.lua', '*.nix', '*.js', '*.ts', '*.jsx', '*.tsx', '*.zig'},
  callback = vim.lsp.buf.clear_references,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
