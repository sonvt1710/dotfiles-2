-- savq/paq-nvim {{{
require("paq")({
  -- self
  "https://github.com/savq/paq-nvim",
  -- Language Server (LSP)
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/aerial.nvim",
  -- Autocompletion
  {
    "https://github.com/Saghen/blink.cmp",
    build = "cargo build --release",
  },
  "https://github.com/folke/lazydev.nvim",
  -- Tree Sitter
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
  },
  "https://github.com/tronikelis/ts-autotag.nvim",
  -- Git
  "https://github.com/junegunn/gv.vim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/sindrets/diffview.nvim",
  -- My Plugins
  "https://github.com/pappasam/nvim-repl",
  "https://github.com/pappasam/papercolor-theme-slim",
  "https://github.com/pappasam/vim-filetype-formatter",
  "https://github.com/pappasam/vim-keywordprg-commands",
  -- Remainder
  "https://github.com/fei6409/log-highlight.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/hedengran/fga.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/fladson/vim-kitty",
  "https://github.com/mikesmithgh/kitty-scrollback.nvim",
  "https://github.com/HiPhish/info.vim",
  "https://github.com/catgoose/nvim-colorizer.lua",
  "https://github.com/chrishrb/gx.nvim",
  {
    "https://github.com/iamcco/markdown-preview.nvim",
    build = vim.fn["mkdp#util#install"],
  },
  "https://github.com/sotte/presenting.nvim",
  "https://github.com/machakann/vim-sandwich",
  "https://github.com/echasnovski/mini.pairs",
})
-- }}}
-- nvim:lsp.txt {{{

vim.lsp.handlers["window/showMessage"] = vim.lsp.handlers.notify

vim.lsp.enable({
  "autotools_ls",
  "basedpyright",
  "bashls",
  "clangd", -- needs project-level compile-commands.json
  "cssls",
  "dockerls",
  "gh_actions_ls",
  "gopls",
  "graphql",
  "harper_ls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "mdx_analyzer",
  "prismals",
  "r_language_server",
  "rust_analyzer",
  "shopify_theme_ls",
  "svelte",
  "taplo",
  "terraformls",
  "ts_ls",
  "vimls",
  "vue_ls",
  "yamlls",
})

vim.lsp.config("*", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false, -- https://github.com/neovim/neovim/issues/23291
      },
    },
  },
})
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportAny = false,
          reportDeprecated = false,
          reportExplicitAny = false,
          reportImplicitStringConcatenation = false,
          reportMissingParameterType = false,
          reportMissingTypeArgument = false,
          reportMissingTypeStubs = false,
          reportUnannotatedClassAttribute = false,
          reportUninitializedInstanceVariable = false,
          reportUnknownArgumentType = false,
          reportUnknownMemberType = false,
          reportUnknownParameterType = false,
          reportUnknownVariableType = false,
          reportUnnecessaryComparison = false,
          reportUnnecessaryIsInstance = false,
          reportUnusedCallResult = false,
          reportUnusedFunction = false,
          reportUnusedParameter = false,
        },
      },
    },
  },
})
vim.lsp.config("gh_actions_ls", {
  filetypes = { "yaml.github" },
  init_options = {
    -- Requires the `repo` and `workflow` scopes
    sessionToken = os.getenv("GITHUB_ACTIONS_LS_TOKEN"),
  },
})
vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      linters = {
        LongSentences = false,
        SentenceCapitalization = false,
        Spaces = false,
        SpellCheck = false,
        ToDoHyphen = false,
      },
    },
  },
})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      -- Vue support. Will need to manually update if node version updated
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand(
          "$HOME/.local/share/mise/installs/node/22.8.0/lib/node_modules/@vue/typescript-plugin/"
        ),
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
})
vim.lsp.config("yamlls", {
  filetypes = { "yaml" },
  settings = {
    yaml = {
      schemas = {
        kubernetes = "", -- disable built-in kubernetes support because we use specific version below
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone/all.json"] = "*.k8s.yaml",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json"] = {
          "compose.yml",
          "compose.yaml",
        },
        ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
      },
      customTags = {
        "!ENV scalar",
        "!ENV sequence",
        "!relative scalar",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji",
        "tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format",
      },
      -- Add this to help with schema validation
      validate = true,
      -- This can help with schema conflicts
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
})

-- }}}
-- nvim:diagnostic.txt {{{

vim.diagnostic.config({
  jump = {
    float = true,
  },
})

-- }}}
-- nvim:treesitter.txt {{{
-- Manually run the following for new installations -> :TSInstall all

vim.treesitter.language.register("terraform", "terraform-vars")
vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("bash", "shell")

-- }}}
-- folke/snacks.nvim {{{
require("snacks").setup({
  explorer = { enabled = true },
  gitbrowse = { enabled = true },
  image = {
    enabled = false,
    ---@diagnostic disable-next-line: missing-fields
    convert = {
      notify = false,
    },
  },
  indent = {
    enabled = true,
    scope = {
      enabled = false,
    },
  },
  picker = {
    enabled = true,
    exclude = {
      "__pycache__",
    },
    include = {
      ".github",
      "/dotfiles/*",
      "instance",
    },
    sources = {
      explorer = {
        win = {
          list = {
            keys = {
              -- NOTE: pick_win triggered by <S-CR>
              ["o"] = "confirm",
              ["<c-t>"] = "tab",
              ["<c-x>"] = "edit_split",
              ["<c-v>"] = "edit_vsplit",
            },
          },
        },
      },
    },
  },
  rename = { enabled = true },
})

-- https://github.com/folke/snacks.nvim/issues/1552
Snacks.input = function(...)
  local opts, fn = ...
  opts.prompt = opts.prompt .. ": "
  return vim.ui.input(opts, fn)
end
-- }}}
-- stevearc/aerial.nvim {{{
require("aerial").setup({})
-- }}}
-- folke/lazydev.nvim {{{
---@diagnostic disable-next-line: missing-fields
require("lazydev").setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
-- }}}
-- Saghen/blink.cmp {{{
require("blink-cmp").setup({
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
  completion = {
    keyword = {
      range = "full",
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon" },
          { "source_id" },
        },
      },
    },
  },
  cmdline = {
    enabled = false,
  },
})
-- }}}
-- catgoose/nvim-colorizer.lua {{{
require("colorizer").setup({
  filetypes = {
    "css",
    "kitty",
    "markdown",
    "typescriptreact",
    "vim",
    "yaml",
  },
})
-- }}}
-- sindrets/diffview.nvim {{{
require("diffview").setup({
  enhanced_diff_hl = true,
  show_help_hints = false,
  file_panel = {
    listing_style = "tree",
    win_config = {
      width = 30,
    },
  },
  hooks = {
    diff_buf_read = function(_)
      vim.opt_local.wrap = false
    end,
  },
})
-- }}}
-- lewis6991/gitsigns.nvim {{{
require("gitsigns").setup({
  signcolumn = false,
  numhl = true,
  linehl = false,
  word_diff = false,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    -- Navigation
    map("n", "]g", function()
      if vim.wo.diff then
        return "]g"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })
    map("n", "[g", function()
      if vim.wo.diff then
        return "[g"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })
  end,
})
-- }}}
-- chrishrb/gx.nvim {{{
---@diagnostic disable-next-line: missing-fields
require("gx").setup({
  open_browser_app = "firefox",
  handlers = {
    cratesio = {
      name = "cratesio",
      filename = "Cargo.toml",
      handle = function(mode, line, _)
        local pkg = require("gx.helper").find(line, mode, "([^=%s]+)%s-=%s")
        if pkg then
          return "https://crates.io/crates/" .. pkg
        end
      end,
    },
    pypi = {
      name = "pypi",
      filename = "pyproject.toml",
      handle = function(mode, line, _)
        -- Match poetry dependencies (name = "version")
        local pkg = require("gx.helper").find(line, mode, "([^=%s]+)%s-=%s")
        if pkg then
          return "https://pypi.org/project/" .. pkg
        end
        -- Match builtin dependencies list format ("name>=version" or "name")
        local dep_pkg =
          require("gx.helper").find(line, mode, '"([^>=%s"]+)[^"]*"')
        if dep_pkg then
          return "https://pypi.org/project/" .. dep_pkg
        end
      end,
    },
    ruff = {
      name = "ruff",
      filetypes = { "python" },
      handle = function(mode, line, _)
        local rule =
          require("gx.helper").find(line, mode, "# noqa: ([A-Z][0-9]+)")
        if rule then
          return "https://docs.astral.sh/ruff/rules/" .. rule
        end
      end,
    },
    npmjs = {
      name = "npmjs",
      filename = "package.json",
      handle = function(mode, line, _)
        local pkg = require("gx.helper").find(line, mode, '"([^"]+)":')
        if pkg then
          return "https://www.npmjs.com/package/" .. pkg
        end
      end,
    },
  },
})
-- }}}
-- echasnovski/mini.pairs {{{
require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
})
-- }}}
-- tronikelis/ts-autotag.nvim {{{
require("ts-autotag").setup({})
-- }}}
-- kyazdani42/nvim-web-devicons {{{
require("nvim-web-devicons").setup({
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
})
-- }}}
-- sotte/presenting.nvim {{{
require("presenting").setup({
  options = {
    width = 60,
  },
  separator = {
    markdown = "^##? ", -- # or ##, but not ###+
  },
  configure_slide_buffer = function(_)
    vim.cmd([[
      Fidget suppress
      setlocal buftype=nofile filetype=markdown bufhidden=wipe nomodifiable wrap conceallevel=3 concealcursor=nc
      nnoremap <buffer> q <Cmd>Presenting<CR>
      nnoremap <buffer> <C-w> <NOP>
      cnoreabbrev <buffer> q Presenting
      echo
    ]])
  end,
})
-- }}}
-- j-hui/fidget.nvim {{{
require("fidget").setup({
  progress = {
    suppress_on_insert = true,
  },
})
-- }}}
-- hedengran/fga.nvim {{{
require("fga").setup({
  install_treesitter_grammar = false,
})
-- }}}
