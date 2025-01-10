-- Base --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Keybinds --

Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

Map("v", "<", "<gv")
Map("v", ">", ">gv")

Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")
Map("n", "<leader>bd", ":bd<CR>")

Map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
Map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
Map("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
Map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
Map("n", "<leader>fc", "<cmd> Telescope current_buffer_fuzzy_find <CR>")
Map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
Map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
Map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
-- Map("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")
Map("n", "<leader>ft", "<cmd> Telescope treesitter<CR>")
Map("n", "<leader>fp", "<cmd> Telescope projects<CR>")
Map("n", "<leader>fy", "<cmd> YAMLTelescope <CR>")

Map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
Map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
Map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
Map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

Map("n", "<leader>nt", "<cmd> Neotree float <CR>")

Map("n", "<leader>gtf", "<cmd> GoTestFile -F <CR>")
Map("n", "<leader>gta", "<cmd> GoTest -F <CR>")
Map("n", "<leader>gc", "<cmd> GoCmt <CR>")
Map("n", "<leader>gq", "<cmd> GoFillStruct <CR>")
Map("n", "<leader>grr", "<cmd> GoRename <CR>")
Map("n", "<leader>ga", "<cmd> GoAltV! <CR>")



-- Package install --

require("packer").startup(function(use)
  -- Packer can manage itself
  use { "wbthomason/packer.nvim" }
  use { "zbirenbaum/copilot.lua" }
  use { "neovim/nvim-lspconfig" }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
  }
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "petertriho/cmp-git" }
  use { "L3MON4D3/LuaSnip" }
  use { "saadparwaiz1/cmp_luasnip" }
  use { "windwp/nvim-autopairs" }
  use { "ray-x/cmp-treesitter" }
  use { "saecki/crates.nvim" }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/gitsigns.nvim" }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }
  use { "ellisonleao/gruvbox.nvim" }
  use {
    "akinsho/bufferline.nvim", tag = "*", 
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    "cuducos/yaml.nvim",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim" -- optional
    },
  }
  use { "ray-x/go.nvim" }
  use { "ray-x/guihua.lua" }
  use { "goolord/alpha-nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
end)



-- Package Config --

--- LSP

--local lsp = require("lspconfig")
--
--lsp.sqlls.setup{}
--lsp.pyright.setup{}
--lsp.bashls.setup{}
--lsp.rust_analyzer.setup {
--  settings = {
--    ['rust-analyzer'] = {},
--  },
--}
--lsp.tsserver.setup {}

--- Copilot

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    ["*"] = false,
    python = true,
    sql = true,
    bash = true,
    lua = true,
    go = true,
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

--- Luasnip

require("luasnip/loaders/from_vscode").lazy_load()

--- CMP

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = vim.schedule_wrap(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'copilot' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
      { name = 'treesitter' },
      { name = 'path' },
      { name = 'crates' },
      { name = 'git' },

    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').sqlls.setup {
    capabilities = capabilities
  }
  require('lspconfig').dockerls.setup {
    capabilities = capabilities
  }
  require('lspconfig').pyright.setup {
    capabilities = capabilities
  }
  require('lspconfig').bashls.setup {
    capabilities = capabilities
  }
  require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {},
    },
  }
  require('lspconfig').tsserver.setup {
    capabilities = capabilities
  }
  require('lspconfig').gopls.setup {
    capabilities = capabilities
  }

--- Indent-blankline

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("ibl").setup({
			scope = {
				show_start = true,
        highlight = { "Function", "Label" },
			},
			indent = {
				char = "┊",
				tab_char = "┊",
        highlight = { "Function", "Label" },
				smart_indent_cap = true,
			},
			whitespace = {
        highlight = { "Function", "Label" },
				remove_blankline_trail = true,
			},
		})

--- Gitsigns

require("gitsigns").setup()

--- Lualine

require("lualine").setup {
  options = {
    theme = "gruvbox_dark",
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
    lualine_c = {"filename", require("yaml_nvim").get_yaml_key},
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

-- Color Scheme --

require("gruvbox").setup({
  contrast = "soft"
})

vim.o.background="dark"
vim.cmd([[colorscheme gruvbox]])

--- Bufferline

vim.opt.termguicolors = true
require("bufferline").setup({
})

--- Neotree 

  require('neo-tree').setup({
    window = {
      mappings = {
        ["J"] = function(state)
          local tree = state.tree
          local node = tree:get_node()
          local siblings = tree:get_nodes(node:get_parent_id())
          local renderer = require('neo-tree.ui.renderer')
          renderer.focus_node(state, siblings[#siblings]:get_id())
        end,
        ["K"] = function(state)
          local tree = state.tree
          local node = tree:get_node()
          local siblings = tree:get_nodes(node:get_parent_id())
          local renderer = require('neo-tree.ui.renderer')
          renderer.focus_node(state, siblings[1]:get_id())
        end
      }
    }
  })

--- Project.nvim

require("project_nvim").setup {}

--- Go.nvim

require("go").setup()

--- Alpha.nvim

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
