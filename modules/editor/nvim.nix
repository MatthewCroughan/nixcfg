let
  theme = rec {
    name = "Tomorrow-Night-Bright";
    src =  ./. + "/colors/${name}.vim";
  };
in
{
  home-manager.users.matthew = { pkgs, ...}: {
    xdg.configFile."nvim/colors/Tomorrow-Night-Bright.vim".source = "${theme.src}";
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        telescope-nvim
        nvim-web-devicons
        bufferline-nvim
        nvim-lspconfig
        vim-nix
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
          # ripgrep and fd is needed for telescope-nvim
          ripgrep git fd

          haskell-language-server
          # ghc, stack and cabal are required to run the language server
          stack
          ghc
          cabal-install
          rnix-lsp
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
        set termguicolors
        set foldexpr=nvim_treesitter#foldexpr()

        colorscheme ${theme.name}

        lua << EOF
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

        local lspc = require('lspconfig')
        lspc.rnix.setup {}
        lspc.hls.setup {}

        -- cmp configuration
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
        EOF
      '';
    };
  };
}
