return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local function setup_diags()
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
      })
    end

    setup_diags()

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Fzf lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Fzf lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Fzf lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "glt", "<cmd>Fzf lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Fzf diagnostics_document<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[c", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]c", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { numhl = hl })
    end

    -- configure html server
    -- lspconfig["html"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure typescript server with plugin
    -- lspconfig["tsserver"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure css server
    -- lspconfig["cssls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure tailwindcss server
    -- lspconfig["tailwindcss"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure svelte server
    -- lspconfig["svelte"].setup({
    --   capabilities = capabilities,
    --   on_attach = function(client, bufnr)
    --     on_attach(client, bufnr)
    --
    --     vim.api.nvim_create_autocmd("BufWritePost", {
    --       pattern = { "*.js", "*.ts" },
    --       callback = function(ctx)
    --         if client.name == "svelte" then
    --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
    --         end
    --       end,
    --     })
    --   end,
    -- })

    -- configure prisma orm server
    -- lspconfig["prismals"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure graphql language server
    -- lspconfig["graphql"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- })

    -- configure emmet language server
    -- lspconfig["emmet_ls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    -- })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    --configure clangd
    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        if client.name == "clangd" then
          -- Set up your key mappings here
          -- For example, to map 'gd' to go to definition:
          opts.desc = "Switch header and source file"
          keymap.set("n", "gp", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
        end
        -- Call the general on_attach function for all other setup
        on_attach(client, bufnr)
      end,
      filetypes = { "cpp", "c", "h", "hpp", "m", "mm" },
    })

    lspconfig["cmake"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      single_file_support = true,
      filetypes = { "cmake" },
    })

    lspconfig["sourcekit"].setup({
      cmd = { "xcrun", "sourcekit-lsp" },
      capabilities = capabilities,
      on_attach = on_attach,
      single_file_support = true,
      filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
      root_dir = lspconfig.util.root_pattern(
        "buildServer.json",
        "*.xcodeproj",
        "*.xcworkspace",
        "compile_commands.json",
        "Package.swift",
        ".git"
      ),
    })

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "go" },
    })
  end,
}
