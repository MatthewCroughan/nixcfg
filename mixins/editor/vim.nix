# The following documents helped me understand this
# https://github.com/NixOS/nixpkgs/blob/ca4e26d1e662231d33831651c2e2ed83b1442cb7/doc/languages-frameworks/vim.section.md#managing-plugins-with-vim-plug
# https://nicknovitski.com/vim-nix-syntax

# name = "vim" makes the name of the executable 'vim'. If I set it to 'myVim'
# then I will have to run 'myVim' on the cli to access this custom version of
# Vim which is being created by vim_configurable.customize

{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ (import ./rnix-lsp-overlay.nix).overlay ];

  nixpkgs.config.vim.ftNix = false;
  environment.systemPackages = with pkgs; [
    pkgs.rnix-lsp_0_2_0
    (vim_configurable.customize {
      vimrcConfig.customRC = ''
        set mouse-=a
        set tw=80
        set fo+=t
        set wrap linebreak
        syntax on
        filetype plugin on
        set omnifunc=syntaxcomplete#Complete
        set backspace=indent,eol,start

        if executable('rnix-lsp')
            au User lsp_setup call lsp#register_server({
                \ 'name': 'rnix-lsp',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'rnix-lsp']},
                \ 'whitelist': ['nix'],
                \ })
        endif

        function! s:on_lsp_buffer_enabled() abort
            setlocal omnifunc=lsp#complete
            setlocal signcolumn=no
            if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
            nmap <buffer> gd <plug>(lsp-definition)
            nmap <buffer> gs <plug>(lsp-document-symbol-search)
            nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
            nmap <buffer> gr <plug>(lsp-references)
            nmap <buffer> gi <plug>(lsp-implementation)
            nmap <buffer> gt <plug>(lsp-type-definition)
            nmap <buffer> <leader>rn <plug>(lsp-rename)
            nmap <buffer> [g <plug>(lsp-previous-diagnostic)
            nmap <buffer> ]g <plug>(lsp-next-diagnostic)
            nmap <buffer> K <plug>(lsp-hover)
            inoremap <buffer> <expr><c-f> lsp#scroll(+4)
            inoremap <buffer> <expr><c-d> lsp#scroll(-4)

            let g:lsp_format_sync_timeout = 1000
            autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

            " refer to doc to add more commands
        endfunction

        augroup lsp_install
            au!
            " call s:on_lsp_buffer_enabled only for languages that has the server registered.
            autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
        augroup END

      '';
      name = "vim";
      vimrcConfig.packages.vim =
        with pkgs.vimPlugins; {
          start = [ vim-nix vim-surround vim-lsp ];
        };
      }
    )
  ];
}
