# manipulates pkgs.lib.evalModules in order to manipulate what is available in
# the scope of imported nix files. This solution was given to me by 'clever' in
# #nixos on Freenode IRC.

# See these for examples:
# https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix#L21
# https://github.com/cleverca22/nix-tests/tree/master/module-example

self:
{
    matthew = {
        imports = [ ./matthew ];
        _module.args.inputs = self.inputs;
        _module.args.self = self;
    };
}

# I used to do it like this, but this meant I would later have to set
# _module.args.inputs = self.inputs; in ./users/default.nix, as can be seen in
# the comment in the head of that file.
# self:
# 
# {
#   matthew = import ./matthew self; # pass 'self' in order to allow ./users/default.nix -> ./users/matthew/default.nix to access ${self}, to provide a path relative to flake.nix.
# }

