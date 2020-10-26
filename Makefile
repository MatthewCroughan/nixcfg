HOSTNAME = $(shell hostname)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error Hostname unknown)
endif

switch:
	sudo nixos-rebuild switch --flake .#${HOSTNAME} -L

boot:
	sudo nixos-rebuild boot --flake .#${HOSTNAME} -L

# https://github.com/NixOS/nix/issues/3779 changed the behavior of 
#
# nix flake update
#
# The old behavior still seems to be doable with:
#
# nix build  --update-locks
#
# update:
# 	jq --raw-output '.nodes.root.inputs | keys | .[]' < flake.lock | \
# 		xargs -n1 -P1 sudo nix flake update --update-input

update:
	sudo nix flake update

upgrade:
	make update && make switch
