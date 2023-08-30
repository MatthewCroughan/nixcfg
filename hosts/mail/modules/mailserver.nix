{ config, lib, pkgs, ... }:
{
  services.fail2ban = {
    enable = true;
    jails = {
      DEFAULT = ''
        bantime  = 3600
      '';
      sshd = ''
        filter = sshd
        maxretry = 4
        action   = iptables[name=ssh, port=ssh, protocol=tcp]
        enabled  = true
      '';
      sshd-ddos = ''
        filter = sshd-ddos
        maxretry = 2
        action   = iptables[name=ssh, port=ssh, protocol=tcp]
        enabled  = true
      '';
      postfix = ''
        filter   = postfix
        maxretry = 3
        action   = iptables[name=postfix, port=smtp, protocol=tcp]
        enabled  = true
      '';
      postfix-sasl = ''
        filter   = postfix-sasl
        maxretry = 3
        action   = iptables[name=postfix, port=smtp, protocol=tcp]
        enabled  = true
      '';
      postfix-ddos = ''
        filter   = postfix-ddos
        maxretry = 3
        action   = iptables[name=postfix, port=submission, protocol=tcp]
        bantime  = 7200
        enabled  = true
      '';
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "letsencrypt@croughan.sh";
  };
  systemd.services.postfix.serviceConfig = {
    PrivateMounts = lib.mkForce true;
    PrivateTmp = lib.mkForce true;
    ProtectControlGroups = lib.mkForce true;
    ProtectHome = lib.mkForce true;
    ProtectSystem = lib.mkForce "full";
  };
  mailserver = {
    enable = true;
    enableImap = true;
    enablePop3 = true;
    enableImapSsl = true;
    enablePop3Ssl = true;
    fqdn = "mail.croughan.sh";
    domains = [ "nix.how" "defenestrate.it" ];
    certificateScheme = "acme-nginx";
    loginAccounts = {
      "admin@defenestrate.it" = {
        hashedPassword = "$2y$05$Z.G9c0y8Z8obEVgl/FfuWOCytK6wLOEqMQ9DKT/VsbRcDC6u9LghS";
      };
      "matthew.croughan@nix.how" = {
        hashedPassword = "$2y$05$6Zy8pMTIzF65FIlw1pq1wuJrrrzIZTKnB3ffOrPh.RhNkqPwzkiiy";
        catchAll = [ "nix.how" ];
      };
    };
    fullTextSearch = {
      enable = true;
      autoIndex = true;
      indexAttachments = true;
      enforced = "body";
    };
  };
}
