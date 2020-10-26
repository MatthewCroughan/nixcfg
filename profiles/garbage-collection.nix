# Tries to prevent filling of the /boot partition, I'd like to find a way to
# limit the generations permitted to a value like 10, though I have not found a
# way to do this.

{
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";
}
