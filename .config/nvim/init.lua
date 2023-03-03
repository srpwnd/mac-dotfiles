-- Base --

vim.opt.number = true 
vim.opt.mouse = 'a'
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true


-- Package install --

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'ms-jpq/coq_nvim'
  use 'nanotee/sqls.nvim'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
  use {
    "cuducos/yaml.nvim",
    ft = {"yaml"}, -- optional
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim" -- optional
    },
  }
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release' -- To use the latest release
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { "catppuccin/nvim", as = "catppuccin",}
  use {
    'akinsho/bufferline.nvim', tag = "v2.*", 
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use { 'https://codeberg.org/esensar/nvim-dev-container' }
  use { "NTBBloodbath/rest.nvim" }
  use { 
    'PedramNavid/dbtpal'
  }
end)



-- Package Config --

--- Coq and LSP

vim.g.coq_settings = { ['auto_start']= 'shut-up' }

local lsp = require("lspconfig")
local coq = require("coq")

lsp.sqls.setup{coq.lsp_ensure_capabilities{
		on_attach = function(client, bufnr)
 			require('sqls').on_attach(client, bufnr)
		end
		}
	}

--- Tree-sitter

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "comment", "http", "sql", "typescript", "lua", "markdown", "bash", "dockerfile", "json", "jsonc", "python", "vim", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--- Indent-blankline

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

--- Gitsigns

require('gitsigns').setup()

--- Lualine

require('lualine').setup {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


--- Devcontainer

require("devcontainer").setup{}

--- Rest.nvim

require("rest-nvim").setup{}

-- Color Scheme --

require("catppuccin").setup({
  flavour = "macchiato",
  background = {
    light = "latte",
    dark = "macchiato",
  },
  integrations = {
    gitsigns = true,
    treesitter = true,
    telescope = true,
  },
  indent_blankline = {
    enabled = true,
    colored_indent_levels = false,
  },
})

--- Bufferline

require("bufferline").setup({
  highlights = require("catppuccin.groups.integrations.bufferline").get()
})

--- dbtpal

local path = vim.fn.expand("%:p")
vim.g.dbtpal_log_level = "debug"


require("dbtpal").setup({
  path_to_dbt = "docker",
  pre_cmd_args = {
    "exec",
    "$(docker ps | grep meltano-airflow-scheduler | sed -e \'s/ .*$//\')",
    "meltano",
    "invoke",
    "dbt-duckdb"
  },
  path_to_dbt_project = "/project/transform",
  -- path_to_dbt_profiles_dir = (path:match("(.*transform/)") or "") .. "profiles/duckdb",
  path_to_dbt_profiles_dir = "/project/transform/profiles/duckdb",
  extended_path_search = true,
  protect_compiled_files = true
})

vim.keymap.set('n', '<leader>drf', require("dbtpal").run)
vim.keymap.set('n', '<leader>drp', require("dbtpal").run_all)
vim.keymap.set('n', '<leader>dtf', require("dbtpal").test)
vim.keymap.set('n', '<leader>dm', require('dbtpal.telescope').dbt_picker)

require('telescope').load_extension('dbtpal')

