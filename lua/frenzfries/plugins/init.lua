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
  {'sainnhe/gruvbox-material', config = function() vim.cmd.colorscheme("gruvbox-material") end},

  -- NOTE: Which Keys
  {import = 'frenzfries.plugins.which-keys'},

  -- NOTE: Todo Comments
  {import = 'frenzfries.plugins.todo-comments'},
  

}, lazyOptions )
