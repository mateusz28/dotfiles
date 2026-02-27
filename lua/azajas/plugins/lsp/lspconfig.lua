return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "nvimdev/lspsaga.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    local function setup_diags()
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
      })
    end

    local function tags_file_exists()
      local root_dir = vim.fn.getcwd()
      local tags_file = root_dir .. "/tags"
      return vim.fn.filereadable(tags_file) == 1
    end

    setup_diags()

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN]  = "▲",
          [vim.diagnostic.severity.HINT]  = "◆",
          [vim.diagnostic.severity.INFO]  = "●",
        },
      },
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("azajas.lsp", {}),
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local opts = { buffer = bufnr, noremap = true, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Fzf lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Fzf lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Fzf lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "glt", "<cmd>Fzf lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Fzf diagnostics_document<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[c", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]c", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", "<cmd>lsp restart<CR>", opts)

        if tags_file_exists() then
          vim.bo[bufnr].tagfunc = ""
        else
          vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        if client.name == "clangd" then
          opts.desc = "Switch header and source file"
          keymap.set("n", "gp", "<cmd>LspClangdSwitchSourceHeader<CR>", opts)
        end
      end,
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    vim.lsp.config("clangd", {
      capabilities = {
        offsetEncoding = { "utf-16" },
        textDocument = {
          completion = { editsNearCursor = true },
        },
      },
      root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git",
        })
        if root then
          on_dir(root)
        else
          local f = vim.api.nvim_buf_get_name(bufnr)
          if f and f ~= "" then
            on_dir(vim.fn.fnamemodify(f, ":p:h"))
          else
            on_dir(vim.fn.getcwd())
          end
        end
      end,
    })

    vim.lsp.config("cmake", {
      capabilities = capabilities,
      workspace_required = false,
      filetypes = { "cmake" },
    })

    local uname = vim.loop.os_uname()
    if uname.sysname == "Darwin" then
      vim.lsp.config("sourcekit", {
        cmd = { "xcrun", "sourcekit-lsp" },
        capabilities = capabilities,
        workspace_required = false,
        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
        root_markers = {
          "buildServer.json",
          "*.xcodeproj",
          "*.xcworkspace",
          "compile_commands.json",
          "Package.swift",
          ".git",
        },
      })
    end

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go" },
    })

    vim.lsp.enable({ "pyright", "lua_ls", "clangd", "cmake", "gopls" })
    if uname.sysname == "Darwin" then
      vim.lsp.enable("sourcekit")
    end
  end,
}
