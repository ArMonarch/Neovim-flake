return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  -- cmd = "Telescope",
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      -- NOTE: nixCats: use lazyAdd to only run build steps if nix wasnt involved.
      -- because nix already did this.
      build = require('nixCatsUtils').lazyAdd 'make',
      enabled = require('nixCatsUtils').lazyAdd(function() return vim.fn.executabel 'make' == 1 end)
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },

  keys = function()
    local symbols_filter = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    }

    local builtin = require('telescope.builtin')

    return {
      { "<leader>/", builtin.live_grep, desc = "Grep (Root Dir)" },
      { "<leader>:", builtin.command_history, desc = "Command History" },
      { "<leader><space>", builtin.find_files, desc = "Find Files (Root Dir)" },
      -- find
      {
        "<leader>fb",
        function() builtin.buffers( { sort_mru = true, sort_lastused = false, ignore_current_buffer = true } ) end,
        desc = "Buffers",
      },
      -- { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>ff", builtin.find_files, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Find Files (cwd)" },
      { "<leader>fg", builtin.git_files, desc = "Find Files (git-files)" },
      { "<leader>fr", builtin.oldfiles, desc = "Recent" },
      { "<leader>fR", function() builtin.oldfiles({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Recent (cwd)" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },

      -- search
      { '<leader>s"', builtin.registers, desc = "Registers" },
      { '<leader>sa', builtin.autocommands, desc = "Auto Commands" },
      { "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "Buffer" },
      { "<leader>sc", builtin.command_history, desc = "Command History" },
      { "<leader>sC", builtin.commands, desc = "Commands" },
      { "<leader>sd", function() builtin.diagnostics( {bufnr = 0} ) end, desc = "Document Diagnostics" },
      { "<leader>sD", builtin.diagnostics, desc = "Workspace Diagnostics" },
      { "<leader>sg", builtin.live_grep, desc = "Grep (Root Dir)" },
      { "<leader>sG", function() builtin.live_grep( { cwd = vim.fn.expand('%:p:h') } ) end, desc = "Grep (cwd)" },
      { "<leader>sh", builtin.help_tags, desc = "Help Pages" },
      { "<leader>sH", builtin.highlights, desc = "Search Highlight Groups" },
      { "<leader>sj", builtin.jumplist, desc = "Jumplist" },
      { "<leader>sk", builtin.keymaps, desc = "Key Maps" },
      { "<leader>sl", builtin.loclist, desc = "Location List" },
      { "<leader>sM", builtin.man_pages, desc = "Man Pages" },
      { "<leader>sm", builtin.marks, desc = "Jump to Mark" },
      { "<leader>so", builtin.vim_options, desc = "Options" },
      { "<leader>sr", builtin.resume , desc = "Resume" },
      { "<leader>sq", builtin.quickfix, desc = "Quickfix List" },
      { "<leader>sw", builtin.grep_string, desc = "Word (Root Dir)" },
      { "<leader>sw", builtin.grep_string, mode = 'v', desc = "Word (Root Dir)" },
      { "<leader>sW", function() builtin.grep_string( { cwd = vim.fn.expand('%:p:h') } ) end, desc = "Word (cwd)" },
      { "<leader>sW", function() builtin.grep_string( { cwd = vim.fn.expand('%:p:h') } ) end, mode = 'v', desc = "Word (cwd)" },
      { "<leader>uC", function() builtin.colorscheme( { enable_preview = true } ) end, desc = "Colorscheme with Preview" },
      {
        "<leader>ss",
        function()
          builtin.lsp_document_symbols( {symbols = symbols_filter} )
        end,
        desc = "Goto Symbol (filter)",
      },
      {
        "<leader>sS",
        function()
          builtin.lsp_dynamic_workspace_symbols( {symbols = symbols_filter} )
        end,
        desc = "Goto Symbol (Workspace)",
      },
    }
  end,

  opts = function()
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    local actions = require('telescope.actions')
    return {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end

          end
          return 0
        end,

        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },

        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    }
  end,

  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown(), }
  },

}
