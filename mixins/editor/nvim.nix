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
        telescope-nvim
        nvim-treesitter
        nvim-web-devicons
        nvim-bufferline-lua
        nvim-lspconfig
        vim-nix
        nvim-compe
      ];
      extraConfig = ''
        " Configure Telescope
        " Find files using Telescope command-line sugar.
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>

        nnoremap <silent><A-h> :BufferLineCyclePrev<CR>
        nnoremap <silent><A-l> :BufferLineCycleNext<CR>
        nnoremap <silent><A-c> :bdelete!<CR>

        set completeopt=menuone,noselect
        set mouse-=a
        set tw=80
        set wrap linebreak
        set number
        set signcolumn=number
        set termguicolors
        colorscheme ${theme.name}

        lua << EOF
        local actions = require('telescope.actions')
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
        require('bufferline').setup {
          options = {
            show_close_icon = false,
            show_buffer_close_icons = false
          }
        }
        local lspc = require('lspconfig')
        lspc.rnix.setup {}
        EOF
      '';
    };
  };
}