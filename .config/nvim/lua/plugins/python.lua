return {
  -- Python LSP設定
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Pyright: 型チェックとコード補完
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- "off", "basic", "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        -- Ruff: 高速なリンターとフォーマッター
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
      },
    },
  },

  -- Python デバッガー
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- uvで管理される仮想環境のPythonを使用
      local python_path = vim.fn.getcwd() .. "/.venv/bin/python"
      if vim.fn.filereadable(python_path) == 0 then
        python_path = "python3"
      end
      require("dap-python").setup(python_path)
    end,
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
  },

  -- Neotest Python サポート
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        },
      },
    },
  },

  -- uv対応の仮想環境選択
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      name = {
        ".venv",
        "venv",
      },
      -- uvで作成される.venvを自動検出
      auto_refresh = true,
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
}
