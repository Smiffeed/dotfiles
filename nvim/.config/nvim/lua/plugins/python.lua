return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Don't show inline text errors while typing (prevents obstructing code)
        virtual_text = false,
      },
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                -- "off" silences Pyright's aggressive type checking & missing stub warnings
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },
}
