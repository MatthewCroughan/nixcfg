{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
#    ./modules/masari.nix
    ./modules/hercules-ci-agent.nix
    users-deploy
    users-matthewcroughan
    profiles-wireless
    profiles-tailscale
    profiles-fail2ban
    mixins-openssh
    mixins-common
    mixins-gc
    mixins-zram
    editor-nvim
  ];

  _module.args = {
    nixinate = {
      host = "h1";
      sshUser = "deploy";
      buildOn = "remote";
    };
  };

  services.kubo = {
    enable = true;
    emptyRepo = true;
    settings.Addresses = {
      Gateway = "/ip4/0.0.0.0/tcp/8080";
      API = "/ip4/0.0.0.0/tcp/5001";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5001 8080 4001 ];


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = true;
    };
  };

  nix = {
    sshServe = {
      protocol = "ssh-ng";
      enable = true;
      write = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM/Y6IbpHHVmN0WX+gUmaEUEiechmHl5N9WdZY311ltP root@gabby"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq9gQxVP6k8TNYgkBR+oasyEIooP3QTPmWSkyvywic6 root@t480"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM38GVfgjAWLVRcIJld+Cv4dEg1ais4JSrKjh8dmb9vg julian@goatlap"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2hSitdOmLziKfsJBeph5T5iUrSjRSCleJuYY8812Mh pasha@newtoncrosby"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmTL3fC8QQ1M2Dc86XgxuSzlJLhjjlgYwC+GH1/ArGQTevsp3TwHTc9+oFZG424ytZBfgnq+LBRG2wbIG3iyTX+RD3iFXDga6QvOAx2M+8/jWDSasaA3dUe1Qd9MzCfg8zRtLA7N5NDDb9fpxOpR9HHKwOhqy3w0x/g1bE+dX7LM1MHDWOwMjOctmvrQwTBvvmF4WhqZDhO1oT8147Bg/YB6NRFRYC7UUWdsRAAiAUtIi3nNPSnf+3NsKKgONlO0vQX9Iv2xR1jlOLfmqidKMs4mWEiZL+EH6whSkLS31rWD6M3XVN9Oi3sYf8iAd6kkvXrFGbg8G+6x3iwsVemUa9t6vmx+44rHID4HJKTe2x2ifEdbiNqNAcx3ddfgJmQAaqqrp2X47lqYCtgrVzq1yI7+GahK9RwGZKu5FHStlYOmM7dc5hKdJ37aVn91mUx5NtORRAgxKkaEf3XNmzV2LQe0JdtuYkHsc1Q8YBYD9yJJAbd8zt/9IT5y62scEXpYk= emery@kiara"
      ];
    };
  };

  networking = {
    wireless.enable = true;
    hostName = "h1";
    nameservers = [ "127.0.0.53" "1.1.1.1" "8.8.8.8" ];
    defaultGateway.address = "192.168.3.1";
    interfaces.enp4s0 = {
      useDHCP = false;
      ipv4.addresses = [
        { address = "192.168.3.99";
          prefixLength = 24;
        }
      ];
    };
  };

  time.timeZone = "Europe/London";

  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
    };
  };

  services = {
    netdata = {
      enable = true;
      config = {
        global = {
          "memory mode" = "dbengine";
          "history" = 24*60*60*7; # 1 Week
        };
      };
    };
  };

  system.stateVersion = "22.11";
}

