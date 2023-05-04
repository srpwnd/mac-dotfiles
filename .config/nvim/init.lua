-- Base --

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true


-- Package install --

require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use "zbirenbaum/copilot.lua"
  use "neovim/nvim-lspconfig"
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
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
    "lewis6991/gitsigns.nvim",
    tag = "release" -- To use the latest release
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }
  use { "catppuccin/nvim", as = "catppuccin",}
  use {
    "akinsho/bufferline.nvim", tag = "v2.*", 
    requires = "kyazdani42/nvim-web-devicons",
  }
  use { "NTBBloodbath/rest.nvim" }
end)



-- Package Config --

--- LSP

local lsp = require("lspconfig")

lsp.sqlls.setup{}
lsp.dockerls.setup{}
lsp.docker_compose_language_service.setup{}
lsp.yamlls.setup{}
lsp.pylsp.setup{}
lsp.bashls.setup{}

--- Copilot

require("copilot").setup({
  filetypes = {
    ["*"] = false,
    python = true,
    sql = true,
    bash = true,
    lua = true,
    typescript = true,
    dockerfile = true,
    dockercompose = true,
  },
})

--- Tree-sitter

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
    "bash",
    "c",
    "comment",
    "dockerfile",
    "gitignore",
    "go",
    "http",
    "jq",
    "json",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "norg",
    "prql",
    "python",
    "rust",
    "sql",
    "terraform",
    "typescript",
    "vim",
    "yaml",
  },

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
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
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

require("gitsigns").setup()

--- Lualine

require("lualine").setup {
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
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
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {"filename"},
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


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

