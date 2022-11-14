{
  nix = {
    sshServe = {
      protocol = "ssh-ng";
      enable = true;
      write = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmMMQcZmI3NhunXl3hj/w7GnbgwbpF/og3OTSms5qvi" # distributedBuilderKey via agenix
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM38GVfgjAWLVRcIJld+Cv4dEg1ais4JSrKjh8dmb9vg julian@goatlap"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2hSitdOmLziKfsJBeph5T5iUrSjRSCleJuYY8812Mh pasha@newtoncrosby"
      ];
    };
  };
}
