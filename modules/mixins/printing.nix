{
  imports = [ ../profiles/avahi.nix ];
  services.printing = {
    enable = true;
    browsing = true;
    stateless = true;
  };
}
