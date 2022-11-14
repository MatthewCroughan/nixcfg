# Repo Layout

- `hosts/` - Machines/Hardware definitions.

  - `pyxis/` - My android phone, built with [Robotnix](https://github.com/danielfullmer/robotnix)

  - `t480/` - My laptop

  - `swordfish/` - My server

  - `h1/` - Another server

  - `hetznix/` - A hetznix server for random stuff

  - `mail/` - my mailserver

  - `matrix/` - my matrix server

  - `doesRouter/` - My router

- `modules/` - [Modules](https://nixos.wiki/wiki/Module) `nixosModules` that
  appear in the flake, automatically.

  - `mixins/` - Dotfiles/Configurations. Instead of imperatively configuring
    `/etc/` or `~/.config`, everything in here is written in Nix instead. This
    nix code implements the changes I want that would traditionally be done by
    modifying something in `/etc/` or `~/.config` using `vim`.

  - `profiles/` - Configurations that are often comprised of mixins that are
    intended to be imported into a given system.

  - `ssot/` - Single Source of Truth, stuff like my SSH Keys, etc.

  - `editor/` - Editor configs.

  - `users/` - [home-manager](https://github.com/nix-community/home-manager) configuration per user.

- `secrets/` - [`age`](https://github.com/FiloSottile/age) encrypted secrets,
  made possible by [`agenix`](https://github.com/ryantm/agenix)

- `environments/` - Environments/Shells for things I need to work with, such as
  [Yocto](https://www.yoctoproject.org/).

- `examples` - Things I don't necessarily want to use, but want to keep around
  and link to people online.
