{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 51820 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable Wireguard
  networking.wg-quick.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      address = [ "192.168.4.3/24" ];
      dns = [ "192.168.4.1" ];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      # privateKeyFile = "path to private key file";
      privateKey = "<privkey>";

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = "<pubkey>";

          # Forward all the traffic via VPN.
          #allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          allowedIPs = [ "192.168.4.0/24" ];

          # Set this to the server IP and port.
          endpoint = "<domain>:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
