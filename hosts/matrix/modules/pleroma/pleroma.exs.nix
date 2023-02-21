{ pkgs }:
let
  soapbox-fe-static-dir = pkgs.runCommand "soapbox-fe" {
    buildInputs = [ pkgs.unzip ];
    src = pkgs.fetchurl {
      name = "soapbox.zip";
      url = "https://gitlab.com/soapbox-pub/soapbox/-/jobs/artifacts/v3.2.0/download?job=build-production";
      sha256 = "sha256-AdW6JK7JkIKLZ8X+N9STeOHqmGNUdhcXyC9jsQPTa9o=";
    };
  }
  ''
    mkdir -p $out/frontends/soapbox/stable
    unzip $src
    mv static/* $out/frontends/soapbox/stable
  '';
in
''
  import Config

  config :pleroma, Pleroma.Web.Endpoint,
    url: [host: "social.defenestrate.it", scheme: "https", port: 443],
    http: [ip: {127, 0, 0, 1}, port: 4000]

  config :pleroma, Pleroma.Web.WebFinger, domain: "defenestrate.it"

  config :pleroma, :http_security,
    sts: true

  config :pleroma, :instance,
    name: "defenestrate.it",
    description: "Throw it out the window",
    email: "admin@defenestrate.it",
    notify_email: "noreply@defenestrate.it",
    limit: 5000,
    registrations_open: false,
    invites_enabled: true,
    public: true,
    allow_relay: true,
    federating: true

  config :pleroma, :media_proxy,
    enabled: false

  config :pleroma, Pleroma.Repo,
    adapter: Ecto.Adapters.Postgres,
      socket_dir: "/run/postgresql",
      database: "pleroma",
      pool_size: 10,
      prepare: :named,
      parameters: [
        plan_cache_mode: "force_custom_plan"
      ]

  config :pleroma, :database, rum_enabled: false
  config :pleroma, :instance, static_dir: "${soapbox-fe-static-dir}"
  config :pleroma, Pleroma.Uploaders.Local, uploads: "/var/lib/pleroma/uploads"
  config :pleroma, configurable_from_database: false

  config :pleroma, Pleroma.Upload, filters: [Pleroma.Upload.Filter.Exiftool, Pleroma.Upload.Filter.AnonymizeFilename, Pleroma.Upload.Filter.Dedupe]

  config :web_push_encryption, :vapid_details,
    subject: "mailto:admin@defenestrate.it"

  config :pleroma, :shout,
    enabled: true

  config :pleroma, :restrict_unauthenticated,
    timelines:  %{local: false, federated: true},
    profiles:   %{local: false, remote: false},
    activities: %{local: false, remote: false}

  config :pleroma, :frontend_configurations,
    pleroma_fe: %{
      redirectRootNoLogin: "/main/public",
      theme: "pleroma-dark"
  }

  config :pleroma, :frontends,
    primary: %{
      "name" => "soapbox",
      "ref" => "stable"
    }
''
