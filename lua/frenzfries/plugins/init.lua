-- NOTE: nixCats: might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end

local lazyOptions = {
  lockfile = getlockfilepath(),
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}

-- NOTE: Here is where you install your plugins.
-- NOTE: nixCats: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require("nixCatsUtils.lazyCat").setup( nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  -- load plugins here

  -- NOTE: Themes
  -- Choose theme by using the config option.

  -- [ "tokyonight", "tokyonight-day":light, "tokyonight-storm", "tokyonight-moon", "tokyonight-night" ]
  {'folke/tokyonight.nvim'},
  -- [ "catppuccin", "catppuccin-latte":light, "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha", ]
  {'catppuccin/nvim'},
  -- [ "gruvbox-material" ]
  {'sainnhe/gruvbox-material'},

  -- NOTE: load mini-icons including nvim-dev-icons
  { import = 'frenzfries.plugins.mini-icons' },

  -- NOTE: animate cursor
  { import = 'frenzfries.plugins.smear-cursor' },

  -- NOTE: Which Keys
  { import = 'frenzfries.plugins.which-keys' },

  -- NOTE: Todo Comments
  { import = 'frenzfries.plugins.todo-comments' },

  -- NOTE: better diagnostics list and others
  { import = 'frenzfries.plugins.trouble' },

  -- NOTE: Git Signs
  { import = 'frenzfries.plugins.git-signs' },

  -- NOTE: Lualine
  { import = 'frenzfries.plugins.lualine' },

  -- NOTE: Folke Snacks
  { import = 'frenzfries.plugins.snacks' },

  -- NOTE: better comments
  { import = 'frenzfries.plugins.ts-comments'},

  -- NOTE: Fuzzy Finder (files, lsp, etc) Telescope
  { import = 'frenzfries.plugins.telescope' },

  -- NOTE: Markdown preview
  { import = 'frenzfries.plugins.render-markdown' },

  -- NOTE: Highlight, edit, and navigate code
  { import = 'frenzfries.plugins.treesitter' },

  -- NOTE: Mini Pairs
  { import = 'frenzfries.plugins.mini-pairs' },

  -- NOTE: properly configures LuaLS for editing your Neovim config
  { import = 'frenzfries.plugins.lazydev'},

  -- NOTE:: autocomplete via blink.cmp
  { import = 'frenzfries.plugins.blink-cmp'},

}, lazyOptions )

-- NOTE: Set theme from nixCats config and activate it
local colorscheme = nixCats( 'colorscheme' )
if colorscheme == nil then
  colorscheme = 'tokyonight-day'
end
vim.cmd.colorscheme( colorscheme )
