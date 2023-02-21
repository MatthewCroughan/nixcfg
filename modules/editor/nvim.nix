{
  home-manager.users.matthew = { pkgs, ...}: {
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        (catppuccin-nvim.overrideAttrs (_: {
          patches = [
            (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/bfe533cb9c42c776a802f8f7802182b5fbf0876a.patch"; sha256 = "sha256-rxhpAJqXBp2rbAHqzyXGadr7zgYChafgaPDa4EpBaPA="; })
            (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/589571e86cc93b67023efe59ad74fc7fe9dc5d37.patch"; sha256 = "sha256-I+whdbdWj7OgNU16UNTl5CHPy6HqBVqiNpGgVgluBOg="; })
          ];
        }))
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        telescope-nvim
        telescope-manix
        nvim-web-devicons
        bufferline-nvim
        nvim-lspconfig
        vim-nix
        csv-vim
        nvim-compe
        vim-oscyank
        indent-blankline-nvim
        gitsigns-nvim
        nvim-cmp
        cmp-nvim-lsp
        cmp-path
      ];
      extraPackages = with pkgs;
        [
          # git is needed for gitsigns-nvim
          # ripgrep and fd are needed for telescope-nvim
          ripgrep git fd
          haskell-language-server
          # ghc, stack and cabal are required to run the language server
          stack
          ghc
          cabal-install
          manix
          nil
          ## TODO: Add
          ## https://github.com/nvim-treesitter/nvim-treesitter-context
          ## https://github.com/ggandor/lightspeed.nvim
          ## https://github.com/mrcjkb/telescope-manix
          ## Make injections for bash and stuff work
        ];
      extraConfig = ''
        " Configure Telescope
        " Find files using Telescope command-line sugar.
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>

        vmap <C-c> y:OSCYank<cr>

        nnoremap <silent><A-h> :BufferLineCyclePrev<CR>
        nnoremap <silent><A-l> :BufferLineCycleNext<CR>
        nnoremap <silent><A-c> :bdelete!<CR>

        set completeopt=menuone,noselect
        set mouse-=a
        set tw=80
        set wrap linebreak
        set number
        set signcolumn=yes:2
        set foldexpr=nvim_treesitter#foldexpr()

        lua << EOF
        require("catppuccin").setup({
         flavour = "mocha",
         term_colors = true,
         color_overrides = {
           latte = {
            text = "#000000";
            base = "#E1EEF5",
           },
           mocha = {
            text = "#FFFFFF",
            base = "#000000",
           },
          },
          highlight_overrides = {
            latte = function(_)
              return {
                NvimTreeNormal = { bg = "#D1E5F0" },
              }
            end,
            mocha = function(mocha)
              return {
                TabLineSel = { bg = mocha.pink },
                NvimTreeNormal = { bg = mocha.none },
                CmpBorder = { fg = mocha.surface2 },
                GitSignsChange = { fg = mocha.blue },
              }
            end,
          },
        })
        vim.cmd.colorscheme "catppuccin"

        local actions = require('telescope.actions')
        require('gitsigns').setup()
        require('telescope').setup {
          defaults = {
            mappings = {
              i = {
                ["<A-j>"] = actions.move_selection_next,
                ["<A-k>"] = actions.move_selection_previous
              }
            }
          }
        }
        require'nvim-treesitter.configs'.setup {
          indent = {
            enable = true
          }
        }
        require('bufferline').setup {
          options = {
            show_close_icon = false,
            show_buffer_close_icons = false
          }
        }
        require("indent_blankline").setup {
          options = {
            space_char_blankline = " ",
            show_current_context = true,
            char = "|"
          }
        }

        vim.cmd[[
          match ExtraWhitespace /\s\+$/
          highlight ExtraWhitespace ctermbg=red guibg=red
        ]]

        vim.opt.list = true
        vim.opt.listchars = {
            eol = "↴",
        }

        -- LSP + nvim-cmp setup
        local lspc = require('lspconfig')
        lspc.hls.setup {}
        local cmp = require("cmp")
        cmp.setup {
          sources = {
            { name = "nvim_lsp" },
            { name = "path" },
          },
          formatting = {
            format = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                path = "[Path]",
              })[entry.source.name]
              return vim_item
            end
          },
          mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          },
        }

        local servers = { 'nil_ls' }
        for _, lsp in ipairs(servers) do
          require('lspconfig')[lsp].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            on_attach = on_attach,
          }
        end
        EOF
      '';
    };
  };
}
