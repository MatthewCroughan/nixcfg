{
  oembed_providers = {
    buildTool = "mix";
    deps = [
      "glob"
      "jason"
    ];
    fetchHex = {
      sha256 = "9b336ee5f3ca20ee4ed005383c74b154d30d0abeb98e95828855c0e2841ae46b";
      url = "https://repo.hex.pm/tarballs/oembed_providers-0.1.0.tar";
    };
    version = "0.1.0";
  };
  hpax = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "09a75600d9d8bbd064cdd741f21fc06fc1f4cf3d0fcc335e5aa19be1a7235c84";
      url = "https://repo.hex.pm/tarballs/hpax-0.1.2.tar";
    };
    version = "0.1.2";
  };
  cowboy_telemetry = {
    buildTool = "rebar3";
    deps = [
      "cowboy"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "f239f68b588efa7707abce16a84d0d2acf3a0f50571f8bb7f56a15865aae820c";
      url = "https://repo.hex.pm/tarballs/cowboy_telemetry-0.4.0.tar";
    };
    version = "0.4.0";
  };
  db_connection = {
    buildTool = "mix";
    deps = [
      "connection"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "f92e79aff2375299a16bcb069a14ee8615c3414863a6fef93156aee8e86c2ff3";
      url = "https://repo.hex.pm/tarballs/db_connection-2.4.2.tar";
    };
    version = "2.4.2";
  };
  phoenix_live_dashboard = {
    buildTool = "mix";
    deps = [
      "ecto"
      "ecto_psql_extras"
      "mime"
      "phoenix_live_view"
      "telemetry_metrics"
    ];
    fetchHex = {
      sha256 = "0769470265eb13af01b5001b29cb935f4710d6adaa1ffc18417a570a337a2f0f";
      url = "https://repo.hex.pm/tarballs/phoenix_live_dashboard-0.6.2.tar";
    };
    version = "0.6.2";
  };
  crypt = {
    buildTool = "mix";
    fetchGit = {
      rev = "f75cd55325e33cbea198fb41fe41871392f8fb76";
      url = "https://github.com/msantos/crypt.git";
    };
    version = "f75cd55325e33cbea198fb41fe41871392f8fb76";
  };
  ex_syslogger = {
    buildTool = "mix";
    deps = [
      "poison"
      "syslog"
    ];
    fetchHex = {
      sha256 = "72b6aa2d47a236e999171f2e1ec18698740f40af0bd02c8c650bf5f1fd1bac79";
      url = "https://repo.hex.pm/tarballs/ex_syslogger-1.5.2.tar";
    };
    version = "1.5.2";
  };
  cowboy = {
    buildTool = "make";
    deps = [
      "cowlib"
      "ranch"
    ];
    fetchHex = {
      sha256 = "865dd8b6607e14cf03282e10e934023a1bd8be6f6bacf921a7e2a96d800cd452";
      url = "https://repo.hex.pm/tarballs/cowboy-2.9.0.tar";
    };
    version = "2.9.0";
  };
  telemetry_poller = {
    buildTool = "rebar3";
    deps = [
      "telemetry"
    ];
    fetchHex = {
      sha256 = "db91bb424e07f2bb6e73926fcafbfcbcb295f0193e0a00e825e589a0a47e8453";
      url = "https://repo.hex.pm/tarballs/telemetry_poller-1.0.0.tar";
    };
    version = "1.0.0";
  };
  makeup_elixir = {
    buildTool = "mix";
    deps = [
      "makeup"
    ];
    fetchHex = {
      sha256 = "4f0e96847c63c17841d42c08107405a005a2680eb9c7ccadfd757bd31dabccfb";
      url = "https://repo.hex.pm/tarballs/makeup_elixir-0.14.1.tar";
    };
    version = "0.14.1";
  };
  ssl_verify_fun = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "cf344f5692c82d2cd7554f5ec8fd961548d4fd09e7d22f5b62482e5aeaebd4b0";
      url = "https://repo.hex.pm/tarballs/ssl_verify_fun-1.1.6.tar";
    };
    version = "1.1.6";
  };
  bbcode_pleroma = {
    buildTool = "mix";
    deps = [
      "nimble_parsec"
    ];
    fetchHex = {
      sha256 = "d36f5bca6e2f62261c45be30fa9b92725c0655ad45c99025cb1c3e28e25803ef";
      url = "https://repo.hex.pm/tarballs/bbcode_pleroma-0.2.0.tar";
    };
    version = "0.2.0";
  };
  ueberauth_twitter = {
    buildTool = "mix";
    deps = [
      "httpoison"
      "oauther"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "4b98620341bc91bac90459093bba093c650823b6e2df35b70255c493c17e9227";
      url = "https://repo.hex.pm/tarballs/ueberauth_twitter-0.4.0.tar";
    };
    version = "0.4.0";
  };
  cowlib = {
    buildTool = "make";
    fetchHex = {
      sha256 = "0b9ff9c346629256c42ebe1eeb769a83c6cb771a6ee5960bd110ab0b9b872063";
      url = "https://repo.hex.pm/tarballs/cowlib-2.11.0.tar";
    };
    version = "2.11.0";
  };
  ueberauth_google = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "dc0e8417061c74107a3ba1419943cc930d3403b5c536b3757886964a3a70c333";
      url = "https://repo.hex.pm/tarballs/ueberauth_google-0.8.0.tar";
    };
    version = "0.8.0";
  };
  html_entities = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "9e47e70598da7de2a9ff6af8758399251db6dbb7eebe2b013f2bbd2515895c3c";
      url = "https://repo.hex.pm/tarballs/html_entities-0.5.2.tar";
    };
    version = "0.5.2";
  };
  cors_plug = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "316f806d10316e6d10f09473f19052d20ba0a0ce2a1d910ddf57d663dac402ae";
      url = "https://repo.hex.pm/tarballs/cors_plug-2.0.3.tar";
    };
    version = "2.0.3";
  };
  prom_ex = {
    buildTool = "mix";
    deps = [
      "ecto"
      "finch"
      "jason"
      "oban"
      "phoenix"
      "phoenix_live_view"
      "plug"
      "plug_cowboy"
      "telemetry"
      "telemetry_metrics"
      "telemetry_metrics_prometheus_core"
      "telemetry_poller"
    ];
    fetchHex = {
      sha256 = "39331ee3fe6f9a8587d8208bf9274a253bb80281700e127dd18786cda5e08c37";
      url = "https://repo.hex.pm/tarballs/prom_ex-1.7.1.tar";
    };
    version = "1.7.1";
  };
  floki = {
    buildTool = "mix";
    deps = [
      "html_entities"
    ];
    fetchHex = {
      sha256 = "75d35526d3a1459920b6e87fdbc2e0b8a3670f965dd0903708d2b267e0904c55";
      url = "https://repo.hex.pm/tarballs/floki-0.30.1.tar";
    };
    version = "0.30.1";
  };
  parallel_stream = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "b967be2b23f0f6787fab7ed681b4c45a215a81481fb62b01a5b750fa8f30f76c";
      url = "https://repo.hex.pm/tarballs/parallel_stream-1.0.6.tar";
    };
    version = "1.0.6";
  };
  gettext = {
    buildTool = "mix";
    fetchGit = {
      rev = "72fb2496b6c5280ed911bdc3756890e7f38a4808";
      url = "https://github.com/tusooa/gettext.git";
    };
    version = "72fb2496b6c5280ed911bdc3756890e7f38a4808";
  };
  deep_merge = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "b4aa1a0d1acac393bdf38b2291af38cb1d4a52806cf7a4906f718e1feb5ee961";
      url = "https://repo.hex.pm/tarballs/deep_merge-1.0.0.tar";
    };
    version = "1.0.0";
  };
  ecto_enum = {
    buildTool = "mix";
    deps = [
      "ecto"
      "ecto_sql"
      "postgrex"
    ];
    fetchHex = {
      sha256 = "d14b00e04b974afc69c251632d1e49594d899067ee2b376277efd8233027aec8";
      url = "https://repo.hex.pm/tarballs/ecto_enum-1.4.0.tar";
    };
    version = "1.4.0";
  };
  jason = {
    buildTool = "mix";
    deps = [
      "decimal"
    ];
    fetchHex = {
      sha256 = "e855647bc964a44e2f67df589ccf49105ae039d4179db7f6271dfd3843dc27e6";
      url = "https://repo.hex.pm/tarballs/jason-1.4.0.tar";
    };
    version = "1.4.0";
  };
  phoenix_template = {
    buildTool = "mix";
    deps = [
      "phoenix_html"
    ];
    fetchHex = {
      sha256 = "c57bc5044f25f007dc86ab21895688c098a9f846a8dda6bc40e2d0ddc146e38f";
      url = "https://repo.hex.pm/tarballs/phoenix_template-1.0.0.tar";
    };
    version = "1.0.0";
  };
  finch = {
    buildTool = "mix";
    deps = [
      "castore"
      "mint"
      "nimble_options"
      "nimble_pool"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "9ad27d68270d879f73f26604bb2e573d40f29bf0e907064a9a337f90a16a0312";
      url = "https://repo.hex.pm/tarballs/finch-0.10.2.tar";
    };
    version = "0.10.2";
  };
  eblurhash = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "7da4255aaea984b31bb71155f673257353b0e0554d0d30dcf859547e74602582";
      url = "https://repo.hex.pm/tarballs/eblurhash-1.2.2.tar";
    };
    version = "1.2.2";
  };
  gen_smtp = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "9f51960c17769b26833b50df0b96123605a8024738b62db747fece14eb2fbfcc";
      url = "https://repo.hex.pm/tarballs/gen_smtp-0.15.0.tar";
    };
    version = "0.15.0";
  };
  csv = {
    buildTool = "mix";
    deps = [
      "parallel_stream"
    ];
    fetchHex = {
      sha256 = "50e32749953b6bf9818dbfed81cf1190e38cdf24f95891303108087486c5925e";
      url = "https://repo.hex.pm/tarballs/csv-2.4.1.tar";
    };
    version = "2.4.1";
  };
  parse_trans = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "16328ab840cc09919bd10dab29e431da3af9e9e7e7e6f0089dd5a2d2820011d8";
      url = "https://repo.hex.pm/tarballs/parse_trans-3.3.1.tar";
    };
    version = "3.3.1";
  };
  ueberauth = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "d42ace28b870e8072cf30e32e385579c57b9cc96ec74fa1f30f30da9c14f3cc0";
      url = "https://repo.hex.pm/tarballs/ueberauth-0.6.3.tar";
    };
    version = "0.6.3";
  };
  websockex = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "92b7905769c79c6480c02daacaca2ddd49de936d912976a4d3c923723b647bf0";
      url = "https://repo.hex.pm/tarballs/websockex-0.4.3.tar";
    };
    version = "0.4.3";
  };
  phoenix_view = {
    buildTool = "mix";
    deps = [
      "phoenix_html"
      "phoenix_template"
    ];
    fetchHex = {
      sha256 = "e676c3058cdfd878faece9cc791fe2f7c810877fdf002db46ee8c01403b4b801";
      url = "https://repo.hex.pm/tarballs/phoenix_view-2.0.0.tar";
    };
    version = "2.0.0";
  };
  ueberauth_facebook = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "9ec8571f804dd5c06f4e305d70606b39fc0ac8a8f43ed56ebb76012a97d14729";
      url = "https://repo.hex.pm/tarballs/ueberauth_facebook-0.8.0.tar";
    };
    version = "0.8.0";
  };
  ecto = {
    buildTool = "mix";
    deps = [
      "decimal"
      "jason"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "67173b1687afeb68ce805ee7420b4261649d5e2deed8fe5550df23bab0bc4396";
      url = "https://repo.hex.pm/tarballs/ecto-3.9.1.tar";
    };
    version = "3.9.1";
  };
  eimp = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "fc297f0c7e2700457a95a60c7010a5f1dcb768a083b6d53f49cd94ab95a28f22";
      url = "https://repo.hex.pm/tarballs/eimp-1.0.14.tar";
    };
    version = "1.0.14";
  };
  mochiweb = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "eb55f1db3e6e960fac4e6db4e2db9ec3602cc9f30b86cd1481d56545c3145d2e";
      url = "https://repo.hex.pm/tarballs/mochiweb-2.18.0.tar";
    };
    version = "2.18.0";
  };
  decimal = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "a78296e617b0f5dd4c6caf57c714431347912ffb1d0842e998e9792b5642d697";
      url = "https://repo.hex.pm/tarballs/decimal-2.0.0.tar";
    };
    version = "2.0.0";
  };
  ranch = {
    buildTool = "make";
    fetchHex = {
      sha256 = "8c7a100a139fd57f17327b6413e4167ac559fbc04ca7448e9be9057311597a1d";
      url = "https://repo.hex.pm/tarballs/ranch-1.8.0.tar";
    };
    version = "1.8.0";
  };
  web_push_encryption = {
    buildTool = "mix";
    deps = [
      "httpoison"
      "jose"
    ];
    fetchHex = {
      sha256 = "76d0e7375142dfee67391e7690e89f92578889cbcf2879377900b5620ee4708d";
      url = "https://repo.hex.pm/tarballs/web_push_encryption-0.3.1.tar";
    };
    version = "0.3.1";
  };
  earmark_parser = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "6f3c7e94170377ba45241d394389e800fb15adc5de51d0a3cd52ae766aafd63f";
      url = "https://repo.hex.pm/tarballs/earmark_parser-1.4.17.tar";
    };
    version = "1.4.17";
  };
  phoenix_swoosh = {
    buildTool = "mix";
    deps = [
      "finch"
      "hackney"
      "phoenix"
      "phoenix_html"
      "phoenix_view"
      "swoosh"
    ];
    fetchHex = {
      sha256 = "f8e4780705c9f254cc853f7a40e25f7198ba4d91102bcfad2226669b69766b35";
      url = "https://repo.hex.pm/tarballs/phoenix_swoosh-1.1.0.tar";
    };
    version = "1.1.0";
  };
  phoenix_html = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "1c1219d4b6cb22ac72f12f73dc5fad6c7563104d083f711c3fcd8551a1f4ae11";
      url = "https://repo.hex.pm/tarballs/phoenix_html-3.2.0.tar";
    };
    version = "3.2.0";
  };
  prometheus_phoenix = {
    buildTool = "mix";
    deps = [
      "phoenix"
      "prometheus_ex"
    ];
    fetchHex = {
      sha256 = "c4b527e0b3a9ef1af26bdcfbfad3998f37795b9185d475ca610fe4388fdd3bb5";
      url = "https://repo.hex.pm/tarballs/prometheus_phoenix-1.3.0.tar";
    };
    version = "1.3.0";
  };
  mock = {
    buildTool = "mix";
    deps = [
      "meck"
    ];
    fetchHex = {
      sha256 = "75b3bbf1466d7e486ea2052a73c6e062c6256fb429d6797999ab02fa32f29e03";
      url = "https://repo.hex.pm/tarballs/mock-0.3.7.tar";
    };
    version = "0.3.7";
  };
  bunt = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "951c6e801e8b1d2cbe58ebbd3e616a869061ddadcc4863d0a2182541acae9a38";
      url = "https://repo.hex.pm/tarballs/bunt-0.2.0.tar";
    };
    version = "0.2.0";
  };
  ex_doc = {
    buildTool = "mix";
    deps = [
      "earmark_parser"
      "makeup_elixir"
      "makeup_erlang"
    ];
    fetchHex = {
      sha256 = "e4c26603830c1a2286dae45f4412a4d1980e1e89dc779fcd0181ed1d5a05c8d9";
      url = "https://repo.hex.pm/tarballs/ex_doc-0.24.2.tar";
    };
    version = "0.24.2";
  };
  phoenix_live_view = {
    buildTool = "mix";
    deps = [
      "jason"
      "phoenix"
      "phoenix_html"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "63f52a6f9f6983f04e424586ff897c016ecc5e4f8d1e2c22c2887af1c57215d8";
      url = "https://repo.hex.pm/tarballs/phoenix_live_view-0.17.5.tar";
    };
    version = "0.17.5";
  };
  syslog = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "6419a232bea84f07b56dc575225007ffe34d9fdc91abe6f1b2f254fd71d8efc2";
      url = "https://repo.hex.pm/tarballs/syslog-1.1.0.tar";
    };
    version = "1.1.0";
  };
  meck = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "85ccbab053f1db86c7ca240e9fc718170ee5bda03810a6292b5306bf31bae5f5";
      url = "https://repo.hex.pm/tarballs/meck-0.9.2.tar";
    };
    version = "0.9.2";
  };
  unsafe = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "a27e1874f72ee49312e0a9ec2e0b27924214a05e3ddac90e91727bc76f8613d8";
      url = "https://repo.hex.pm/tarballs/unsafe-1.0.1.tar";
    };
    version = "1.0.1";
  };
  plug_static_index_html = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "840123d4d3975585133485ea86af73cb2600afd7f2a976f9f5fd8b3808e636a0";
      url = "https://repo.hex.pm/tarballs/plug_static_index_html-1.0.0.tar";
    };
    version = "1.0.0";
  };
  plug_cowboy = {
    buildTool = "mix";
    deps = [
      "cowboy"
      "cowboy_telemetry"
      "plug"
    ];
    fetchHex = {
      sha256 = "62894ccd601cf9597e2c23911ff12798a8a18d237e9739f58a6b04e4988899fe";
      url = "https://repo.hex.pm/tarballs/plug_cowboy-2.5.2.tar";
    };
    version = "2.5.2";
  };
  certifi = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "6f2a475689dd47f19fb74334859d460a2dc4e3252a3324bd2111b8f0429e7e21";
      url = "https://repo.hex.pm/tarballs/certifi-2.9.0.tar";
    };
    version = "2.9.0";
  };
  unplug = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "8ec2479de0baa9a6283c04a1cc616c5ca6c5b80b8ff1d857481bb2943368dbbc";
      url = "https://repo.hex.pm/tarballs/unplug-1.0.0.tar";
    };
    version = "1.0.0";
  };
  file_system = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "fb082005a9cd1711c05b5248710f8826b02d7d1784e7c3451f9c1231d4fc162d";
      url = "https://repo.hex.pm/tarballs/file_system-0.2.10.tar";
    };
    version = "0.2.10";
  };
  fast_sanitize = {
    buildTool = "mix";
    deps = [
      "fast_html"
      "plug"
    ];
    fetchHex = {
      sha256 = "3cbbaebaea6043865dfb5b4ecb0f1af066ad410a51470e353714b10c42007b81";
      url = "https://repo.hex.pm/tarballs/fast_sanitize-0.2.2.tar";
    };
    version = "0.2.2";
  };
  eternal = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "d1641c86368de99375b98d183042dd6c2b234262b8d08dfd72b9eeaafc2a1abd";
      url = "https://repo.hex.pm/tarballs/eternal-1.2.2.tar";
    };
    version = "1.2.2";
  };
  oauth2 = {
    buildTool = "mix";
    deps = [
      "hackney"
    ];
    fetchHex = {
      sha256 = "632e8e8826a45e33ac2ea5ac66dcc019ba6bb5a0d2ba77e342d33e3b7b252c6e";
      url = "https://repo.hex.pm/tarballs/oauth2-0.9.4.tar";
    };
    version = "0.9.4";
  };
  ecto_sql = {
    buildTool = "mix";
    deps = [
      "db_connection"
      "ecto"
      "postgrex"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "2bb21210a2a13317e098a420a8c1cc58b0c3421ab8e3acfa96417dab7817918c";
      url = "https://repo.hex.pm/tarballs/ecto_sql-3.9.0.tar";
    };
    version = "3.9.0";
  };
  poison = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "d9eb636610e096f86f25d9a46f35a9facac35609a7591b3be3326e99a0484665";
      url = "https://repo.hex.pm/tarballs/poison-3.1.0.tar";
    };
    version = "3.1.0";
  };
  pot = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "81b511b1fa7c3123171c265cb7065a1528cebd7277b0cbc94257c50a8b2e4c17";
      url = "https://repo.hex.pm/tarballs/pot-1.0.1.tar";
    };
    version = "1.0.1";
  };
  poolboy = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "392b007a1693a64540cead79830443abf5762f5d30cf50bc95cb2c1aaafa006b";
      url = "https://repo.hex.pm/tarballs/poolboy-1.5.2.tar";
    };
    version = "1.5.2";
  };
  mimerl = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "67e2d3f571088d5cfd3e550c383094b47159f3eee8ffa08e64106cdf5e981be3";
      url = "https://repo.hex.pm/tarballs/mimerl-1.2.0.tar";
    };
    version = "1.2.0";
  };
  telemetry_metrics_prometheus_core = {
    buildTool = "mix";
    deps = [
      "telemetry"
      "telemetry_metrics"
    ];
    fetchHex = {
      sha256 = "c98b1c580de637bfeac00db41b9fb91fb4c3548ee3d512a8ed7299172312eaf3";
      url = "https://repo.hex.pm/tarballs/telemetry_metrics_prometheus_core-1.0.2.tar";
    };
    version = "1.0.2";
  };
  httpoison = {
    buildTool = "mix";
    deps = [
      "hackney"
    ];
    fetchHex = {
      sha256 = "6b85dea15820b7804ef607ff78406ab449dd78bed923a49c7160e1886e987a3d";
      url = "https://repo.hex.pm/tarballs/httpoison-1.8.0.tar";
    };
    version = "1.8.0";
  };
  http_signatures = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "ca7ebc1b61542b163644c8c3b1f0e0f41037d35f2395940d3c6c7deceab41fd8";
      url = "https://repo.hex.pm/tarballs/http_signatures-0.1.1.tar";
    };
    version = "0.1.1";
  };
  prometheus_ecto = {
    buildTool = "mix";
    deps = [
      "ecto"
      "prometheus_ex"
    ];
    fetchHex = {
      sha256 = "3dd4da1812b8e0dbee81ea58bb3b62ed7588f2eae0c9e97e434c46807ff82311";
      url = "https://repo.hex.pm/tarballs/prometheus_ecto-1.4.3.tar";
    };
    version = "1.4.3";
  };
  cachex = {
    buildTool = "mix";
    deps = [
      "eternal"
      "jumper"
      "sleeplocks"
      "unsafe"
    ];
    fetchHex = {
      sha256 = "6f2ebb8f27491fe39121bd207c78badc499214d76c695658b19d6079beeca5c2";
      url = "https://repo.hex.pm/tarballs/cachex-3.3.0.tar";
    };
    version = "3.3.0";
  };
  phoenix_pubsub = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "ba04e489ef03763bf28a17eb2eaddc2c20c6d217e2150a61e3298b0f4c2012b5";
      url = "https://repo.hex.pm/tarballs/phoenix_pubsub-2.1.1.tar";
    };
    version = "2.1.1";
  };
  ueberauth_microsoft = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "1c0be9c218e93c426e32c416421e9d41ea59fdf1e3b24310ed5be41df46ddcc1";
      url = "https://repo.hex.pm/tarballs/ueberauth_microsoft-0.4.0.tar";
    };
    version = "0.4.0";
  };
  idna = {
    buildTool = "rebar3";
    deps = [
      "unicode_util_compat"
    ];
    fetchHex = {
      sha256 = "8a63070e9f7d0c62eb9d9fcb360a7de382448200fbbd1b106cc96d3d8099df8d";
      url = "https://repo.hex.pm/tarballs/idna-6.1.1.tar";
    };
    version = "6.1.1";
  };
  plug_crypto = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "8f77d13aeb32bfd9e654cb68f0af517b371fb34c56c9f2b58fe3df1235c1251a";
      url = "https://repo.hex.pm/tarballs/plug_crypto-1.2.3.tar";
    };
    version = "1.2.3";
  };
  jose = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "59da64010c69aad6cde2f5b9248b896b84472e99bd18f246085b7b9fe435dcdb";
      url = "https://repo.hex.pm/tarballs/jose-1.11.1.tar";
    };
    version = "1.11.1";
  };
  connection = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "ff2a49c4b75b6fb3e674bfc5536451607270aac754ffd1bdfe175abe4a6d7a68";
      url = "https://repo.hex.pm/tarballs/connection-1.1.0.tar";
    };
    version = "1.1.0";
  };
  fast_html = {
    buildTool = "mix";
    deps = [
      "elixir_make"
      "nimble_pool"
    ];
    fetchHex = {
      sha256 = "c61760340606c1077ff1f196f17834056cb1dd3d5cb92a9f2cabf28bc6221c3c";
      url = "https://repo.hex.pm/tarballs/fast_html-2.0.5.tar";
    };
    version = "2.0.5";
  };
  tesla = {
    buildTool = "mix";
    deps = [
      "castore"
      "finch"
      "gun"
      "hackney"
      "jason"
      "mime"
      "mint"
      "poison"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "bb89aa0c9745190930366f6a2ac612cdf2d0e4d7fff449861baa7875afd797b2";
      url = "https://repo.hex.pm/tarballs/tesla-1.4.4.tar";
    };
    version = "1.4.4";
  };
  metrics = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "25f094dea2cda98213cecc3aeff09e940299d950904393b2a29d191c346a8486";
      url = "https://repo.hex.pm/tarballs/metrics-1.0.1.tar";
    };
    version = "1.0.1";
  };
  castore = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "deb5b9ab02400561b6f5708f3e7660fc35ca2d51bfc6a940d2f513f89c2975fc";
      url = "https://repo.hex.pm/tarballs/castore-0.1.18.tar";
    };
    version = "0.1.18";
  };
  benchee = {
    buildTool = "mix";
    deps = [
      "deep_merge"
    ];
    fetchHex = {
      sha256 = "66b211f9bfd84bd97e6d1beaddf8fc2312aaabe192f776e8931cb0c16f53a521";
      url = "https://repo.hex.pm/tarballs/benchee-1.0.1.tar";
    };
    version = "1.0.1";
  };
  table_rex = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "0c67164d1714b5e806d5067c1e96ff098ba7ae79413cc075973e17c38a587caa";
      url = "https://repo.hex.pm/tarballs/table_rex-3.1.1.tar";
    };
    version = "3.1.1";
  };
  bcrypt_elixir = {
    buildTool = "mix";
    deps = [
      "comeonin"
      "elixir_make"
    ];
    fetchHex = {
      sha256 = "6cb662d5c1b0a8858801cf20997bd006e7016aa8c52959c9ef80e0f34fb60b7a";
      url = "https://repo.hex.pm/tarballs/bcrypt_elixir-2.3.0.tar";
    };
    version = "2.3.0";
  };
  captcha = {
    buildTool = "mix";
    fetchGit = {
      rev = "e0f16822d578866e186a0974d65ad58cddc1e2ab";
      url = "https://gitlab.com/soapbox-pub/elixir-libraries/elixir-captcha.git";
    };
    version = "e0f16822d578866e186a0974d65ad58cddc1e2ab";
  };
  inet_cidr = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "a05744ab7c221ca8e395c926c3919a821eb512e8f36547c062f62c4ca0cf3d6e";
      url = "https://repo.hex.pm/tarballs/inet_cidr-1.0.4.tar";
    };
    version = "1.0.4";
  };
  calendar = {
    buildTool = "mix";
    deps = [
      "tzdata"
    ];
    fetchHex = {
      sha256 = "f52073a708528482ec33d0a171954ca610fe2bd28f1e871f247dc7f1565fa807";
      url = "https://repo.hex.pm/tarballs/calendar-1.0.0.tar";
    };
    version = "1.0.0";
  };
  elixir_make = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "7dffacd77dec4c37b39af867cedaabb0b59f6a871f89722c25b28fcd4bd70530";
      url = "https://repo.hex.pm/tarballs/elixir_make-0.6.2.tar";
    };
    version = "0.6.2";
  };
  ueberauth_slack = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "ec8f6c96e1d41a458a00b5d8cd918c1f387998884fe4636e67dd88b1bd06f928";
      url = "https://repo.hex.pm/tarballs/ueberauth_slack-0.3.0.tar";
    };
    version = "0.3.0";
  };
  websocket_client = {
    buildTool = "mix";
    fetchGit = {
      rev = "9a6f65d05ebf2725d62fb19262b21f1805a59fbf";
      url = "https://github.com/jeremyong/websocket_client.git";
    };
    version = "9a6f65d05ebf2725d62fb19262b21f1805a59fbf";
  };
  mogrify = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "a26f107c4987477769f272bd0f7e3ac4b7b75b11ba597fd001b877beffa9c068";
      url = "https://repo.hex.pm/tarballs/mogrify-0.9.1.tar";
    };
    version = "0.9.1";
  };
  ecto_psql_extras = {
    buildTool = "mix";
    deps = [
      "ecto_sql"
      "postgrex"
      "table_rex"
    ];
    fetchHex = {
      sha256 = "5d43fd088d39a158c860b17e8d210669587f63ec89ea122a4654861c8c6e2db4";
      url = "https://repo.hex.pm/tarballs/ecto_psql_extras-0.7.4.tar";
    };
    version = "0.7.4";
  };
  ueberauth_keycloak_strategy = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "5ed0471a1cbb2ad4c0b371ab9f2a8e413070d9f307a2e55925a613254e7be619";
      url = "https://repo.hex.pm/tarballs/ueberauth_keycloak_strategy-0.2.0.tar";
    };
    version = "0.2.0";
  };
  ex_aws_s3 = {
    buildTool = "mix";
    deps = [
      "ex_aws"
      "sweet_xml"
    ];
    fetchHex = {
      sha256 = "07a09de557070320e264893c0acc8a1d2e7ddf80155736e0aed966486d1988e6";
      url = "https://repo.hex.pm/tarballs/ex_aws_s3-2.2.0.tar";
    };
    version = "2.2.0";
  };
  credo = {
    buildTool = "mix";
    deps = [
      "bunt"
      "file_system"
      "jason"
    ];
    fetchHex = {
      sha256 = "e8f422026f553bc3bebb81c8e8bf1932f498ca03339856c7fec63d3faac8424b";
      url = "https://repo.hex.pm/tarballs/credo-1.5.5.tar";
    };
    version = "1.5.5";
  };
  comeonin = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "5c2f893d05c56ae3f5e24c1b983c2d5dfb88c6d979c9287a76a7feb1e1d8d646";
      url = "https://repo.hex.pm/tarballs/comeonin-5.3.2.tar";
    };
    version = "5.3.2";
  };
  ex_machina = {
    buildTool = "mix";
    deps = [
      "ecto"
      "ecto_sql"
    ];
    fetchHex = {
      sha256 = "b792cc3127fd0680fecdb6299235b4727a4944a09ff0fa904cc639272cd92dc7";
      url = "https://repo.hex.pm/tarballs/ex_machina-2.7.0.tar";
    };
    version = "2.7.0";
  };
  prometheus = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "1ce1e1002b173c336d61f186b56263346536e76814edd9a142e12aeb2d6c1ad2";
      url = "https://repo.hex.pm/tarballs/prometheus-4.8.0.tar";
    };
    version = "4.8.0";
  };
  jumper = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "3c00542ef1a83532b72269fab9f0f0c82bf23a35e27d278bfd9ed0865cecabff";
      url = "https://repo.hex.pm/tarballs/jumper-1.0.1.tar";
    };
    version = "1.0.1";
  };
  nimble_options = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "c89babbab52221a24b8d1ff9e7d838be70f0d871be823165c94dd3418eea728f";
      url = "https://repo.hex.pm/tarballs/nimble_options-0.4.0.tar";
    };
    version = "0.4.0";
  };
  nimble_pool = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "91f2f4c357da4c4a0a548286c84a3a28004f68f05609b4534526871a22053cde";
      url = "https://repo.hex.pm/tarballs/nimble_pool-0.2.6.tar";
    };
    version = "0.2.6";
  };
  makeup = {
    buildTool = "mix";
    deps = [
      "nimble_parsec"
    ];
    fetchHex = {
      sha256 = "d5a830bc42c9800ce07dd97fa94669dfb93d3bf5fcf6ea7a0c67b2e0e4a7f26c";
      url = "https://repo.hex.pm/tarballs/makeup-1.0.5.tar";
    };
    version = "1.0.5";
  };
  mint = {
    buildTool = "mix";
    deps = [
      "castore"
      "hpax"
    ];
    fetchHex = {
      sha256 = "50330223429a6e1260b2ca5415f69b0ab086141bc76dc2fbf34d7c389a6675b2";
      url = "https://repo.hex.pm/tarballs/mint-1.4.2.tar";
    };
    version = "1.4.2";
  };
  prometheus_phx = {
    buildTool = "mix";
    fetchGit = {
      allRefs = true;
      rev = "9cd8f248c9381ffedc799905050abce194a97514";
      url = "https://gitlab.com/soapbox-pub/elixir-libraries/prometheus-phx.git";
    };
    version = "9cd8f248c9381ffedc799905050abce194a97514";
  };
  earmark = {
    buildTool = "mix";
    deps = [
      "earmark_parser"
    ];
    fetchHex = {
      sha256 = "618c4ff1563450d1832b7fb41dc6755e470f91a6fd4c70f350a58b14f64a7db8";
      url = "https://repo.hex.pm/tarballs/earmark-1.4.18.tar";
    };
    version = "1.4.18";
  };
  oauther = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "82b399607f0ca9d01c640438b34d74ebd9e4acd716508f868e864537ecdb1f76";
      url = "https://repo.hex.pm/tarballs/oauther-1.3.0.tar";
    };
    version = "1.3.0";
  };
  hackney = {
    buildTool = "rebar3";
    deps = [
      "certifi"
      "idna"
      "metrics"
      "mimerl"
      "parse_trans"
      "ssl_verify_fun"
      "unicode_util_compat"
    ];
    fetchHex = {
      sha256 = "f48bf88f521f2a229fc7bae88cf4f85adc9cd9bcf23b5dc8eb6a1788c662c4f6";
      url = "https://repo.hex.pm/tarballs/hackney-1.18.1.tar";
    };
    version = "1.18.1";
  };
  telemetry = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "a589817034a27eab11144ad24d5c0f9fab1f58173274b1e9bae7074af9cbee51";
      url = "https://repo.hex.pm/tarballs/telemetry-1.1.0.tar";
    };
    version = "1.1.0";
  };
  sweet_xml = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "debb256781c75ff6a8c5cbf7981146312b66f044a2898f453709a53e5031b45b";
      url = "https://repo.hex.pm/tarballs/sweet_xml-0.7.3.tar";
    };
    version = "0.7.3";
  };
  prometheus_plugs = {
    buildTool = "mix";
    deps = [
      "accept"
      "plug"
      "prometheus_ex"
    ];
    fetchHex = {
      sha256 = "25933d48f8af3a5941dd7b621c889749894d8a1082a6ff7c67cc99dec26377c5";
      url = "https://repo.hex.pm/tarballs/prometheus_plugs-1.1.5.tar";
    };
    version = "1.1.5";
  };
  postgrex = {
    buildTool = "mix";
    deps = [
      "connection"
      "db_connection"
      "decimal"
      "jason"
    ];
    fetchHex = {
      sha256 = "fcc4035cc90e23933c5d69a9cd686e329469446ef7abba2cf70f08e2c4b69810";
      url = "https://repo.hex.pm/tarballs/postgrex-0.16.5.tar";
    };
    version = "0.16.5";
  };
  concurrent_limiter = {
    buildTool = "mix";
    deps = [
      "telemetry"
    ];
    fetchHex = {
      sha256 = "43ae1dc23edda1ab03dd66febc739c4ff710d047bb4d735754909f9a474ae01c";
      url = "https://repo.hex.pm/tarballs/concurrent_limiter-0.1.1.tar";
    };
    version = "0.1.1";
  };
  glob = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "b4d54d66e7797ce037cdd18f2587fc9932187355340e222cafe125cd333d7a0a";
      url = "https://repo.hex.pm/tarballs/glob-1.0.0.tar";
    };
    version = "1.0.0";
  };
  phoenix = {
    buildTool = "mix";
    deps = [
      "castore"
      "jason"
      "phoenix_pubsub"
      "phoenix_view"
      "plug"
      "plug_cowboy"
      "plug_crypto"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "0a1d96bbc10747fd83525370d691953cdb6f3ccbac61aa01b4acb012474b047d";
      url = "https://repo.hex.pm/tarballs/phoenix-1.6.15.tar";
    };
    version = "1.6.15";
  };
  esshd = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "d4dd4c46698093a40a56afecce8a46e246eb35463c457c246dacba2e056f31b5";
      url = "https://repo.hex.pm/tarballs/esshd-0.1.1.tar";
    };
    version = "0.1.1";
  };
  custom_base = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "4a832a42ea0552299d81652aa0b1f775d462175293e99dfbe4d7dbaab785a706";
      url = "https://repo.hex.pm/tarballs/custom_base-0.2.1.tar";
    };
    version = "0.2.1";
  };
  ex_const = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "d06e540c9d834865b012a17407761455efa71d0ce91e5831e86881b9c9d82448";
      url = "https://repo.hex.pm/tarballs/ex_const-0.2.4.tar";
    };
    version = "0.2.4";
  };
  remote_ip = {
    buildTool = "mix";
    fetchGit = {
      rev = "b647d0deecaa3acb140854fe4bda5b7e1dc6d1c8";
      url = "https://gitlab.com/soapbox-pub/elixir-libraries/remote_ip.git";
    };
    version = "b647d0deecaa3acb140854fe4bda5b7e1dc6d1c8";
  };
  oban = {
    buildTool = "mix";
    deps = [
      "ecto_sql"
      "jason"
      "postgrex"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "c0ce48be26598d0d1439e4867ac32fdc89fa7511fb0a7e61c44decafa2e36633";
      url = "https://repo.hex.pm/tarballs/oban-2.4.3.tar";
    };
    version = "2.4.3";
  };
  covertool = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "54acff6cddd88d28dea663cd2e1fe20dd32fcf5f5d3aff7d59031ce44ce39efa";
      url = "https://repo.hex.pm/tarballs/covertool-2.0.4.tar";
    };
    version = "2.0.4";
  };
  telemetry_metrics = {
    buildTool = "mix";
    deps = [
      "telemetry"
    ];
    fetchHex = {
      sha256 = "315d9163a1d4660aedc3fee73f33f1d355dcc76c5c3ab3d59e76e3edf80eef1f";
      url = "https://repo.hex.pm/tarballs/telemetry_metrics-0.6.1.tar";
    };
    version = "0.6.1";
  };
  ueberauth_github = {
    buildTool = "mix";
    deps = [
      "oauth2"
      "ueberauth"
    ];
    fetchHex = {
      sha256 = "637067c5500f7b13c18caca3db66d09eba661524e0d0e9518b54151e99484bad";
      url = "https://repo.hex.pm/tarballs/ueberauth_github-0.7.0.tar";
    };
    version = "0.7.0";
  };
  unicode_util_compat = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "bc84380c9ab48177092f43ac89e4dfa2c6d62b40b8bd132b1059ecc7232f9a78";
      url = "https://repo.hex.pm/tarballs/unicode_util_compat-0.7.0.tar";
    };
    version = "0.7.0";
  };
  plug = {
    buildTool = "mix";
    deps = [
      "mime"
      "plug_crypto"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "41eba7d1a2d671faaf531fa867645bd5a3dce0957d8e2a3f398ccff7d2ef017f";
      url = "https://repo.hex.pm/tarballs/plug-1.10.4.tar";
    };
    version = "1.10.4";
  };
  combine = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "eff8224eeb56498a2af13011d142c5e7997a80c8f5b97c499f84c841032e429f";
      url = "https://repo.hex.pm/tarballs/combine-0.10.0.tar";
    };
    version = "0.10.0";
  };
  prometheus_ex = {
    buildTool = "mix";
    fetchGit = {
      rev = "31f7fbe4b71b79ba27efc2a5085746c4011ceb8f";
      url = "https://gitlab.com/soapbox-pub/elixir-libraries/prometheus.ex.git";
    };
    version = "31f7fbe4b71b79ba27efc2a5085746c4011ceb8f";
  };
  majic = {
    buildTool = "mix";
    deps = [
      "elixir_make"
      "mime"
      "nimble_pool"
      "plug"
    ];
    fetchHex = {
      sha256 = "37e50648db5f5c2ff0c9fb46454d034d11596c03683807b9fb3850676ffdaab3";
      url = "https://repo.hex.pm/tarballs/majic-1.0.0.tar";
    };
    version = "1.0.0";
  };
  sleeplocks = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "3d462a0639a6ef36cc75d6038b7393ae537ab394641beb59830a1b8271faeed3";
      url = "https://repo.hex.pm/tarballs/sleeplocks-1.1.1.tar";
    };
    version = "1.1.1";
  };
  nimble_parsec = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "90e2eca3d0266e5c53f8fbe0079694740b9c91b6747f2b7e3c5d21966bba8300";
      url = "https://repo.hex.pm/tarballs/nimble_parsec-0.5.0.tar";
    };
    version = "0.5.0";
  };
  linkify = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "fb66be139fdf1656ecb31f78a93592724d1b78d960a1b3598bd661013ea0e3c7";
      url = "https://repo.hex.pm/tarballs/linkify-0.5.2.tar";
    };
    version = "0.5.2";
  };
  open_api_spex = {
    buildTool = "mix";
    deps = [
      "jason"
      "plug"
      "poison"
    ];
    fetchHex = {
      sha256 = "94e9521ad525b3fcf6dc77da7c45f87fdac24756d4de588cb0816b413e7c1844";
      url = "https://repo.hex.pm/tarballs/open_api_spex-3.10.0.tar";
    };
    version = "3.10.0";
  };
  accept = {
    buildTool = "rebar3";
    fetchHex = {
      sha256 = "b33b127abca7cc948bbe6caa4c263369abf1347cfa9d8e699c6d214660f10cd1";
      url = "https://repo.hex.pm/tarballs/accept-0.3.5.tar";
    };
    version = "0.3.5";
  };
  gun = {
    buildTool = "make";
    deps = [
      "cowlib"
    ];
    fetchHex = {
      sha256 = "7c489a32dedccb77b6e82d1f3c5a7dadfbfa004ec14e322cdb5e579c438632d2";
      url = "https://repo.hex.pm/tarballs/gun-2.0.0-rc.2.tar";
    };
    version = "2.0.0-rc.2";
  };
  trailing_format_plug = {
    buildTool = "mix";
    deps = [
      "plug"
    ];
    fetchHex = {
      sha256 = "64b877f912cf7273bed03379936df39894149e35137ac9509117e59866e10e45";
      url = "https://repo.hex.pm/tarballs/trailing_format_plug-0.0.7.tar";
    };
    version = "0.0.7";
  };
  tzdata = {
    buildTool = "mix";
    deps = [
      "hackney"
    ];
    fetchHex = {
      sha256 = "69f1ee029a49afa04ad77801febaf69385f3d3e3d1e4b56b9469025677b89a28";
      url = "https://repo.hex.pm/tarballs/tzdata-1.0.5.tar";
    };
    version = "1.0.5";
  };
  joken = {
    buildTool = "mix";
    deps = [
      "jose"
    ];
    fetchHex = {
      sha256 = "62a979c46f2c81dcb8ddc9150453b60d3757d1ac393c72bb20fc50a7b0827dc6";
      url = "https://repo.hex.pm/tarballs/joken-2.3.0.tar";
    };
    version = "2.3.0";
  };
  base62 = {
    buildTool = "mix";
    deps = [
      "custom_base"
    ];
    fetchHex = {
      sha256 = "85c6627eb609317b70f555294045895ffaaeb1758666ab9ef9ca38865b11e629";
      url = "https://repo.hex.pm/tarballs/base62-1.2.2.tar";
    };
    version = "1.2.2";
  };
  timex = {
    buildTool = "mix";
    deps = [
      "combine"
      "gettext"
      "tzdata"
    ];
    fetchHex = {
      sha256 = "3eca56e23bfa4e0848f0b0a29a92fa20af251a975116c6d504966e8a90516dfd";
      url = "https://repo.hex.pm/tarballs/timex-3.7.5.tar";
    };
    version = "3.7.5";
  };
  flake_id = {
    buildTool = "mix";
    deps = [
      "base62"
      "ecto"
    ];
    fetchHex = {
      sha256 = "7716b086d2e405d09b647121a166498a0d93d1a623bead243e1f74216079ccb3";
      url = "https://repo.hex.pm/tarballs/flake_id-0.1.0.tar";
    };
    version = "0.1.0";
  };
  makeup_erlang = {
    buildTool = "mix";
    deps = [
      "makeup"
    ];
    fetchHex = {
      sha256 = "3fcb7f09eb9d98dc4d208f49cc955a34218fc41ff6b84df7c75b3e6e533cc65f";
      url = "https://repo.hex.pm/tarballs/makeup_erlang-0.1.1.tar";
    };
    version = "0.1.1";
  };
  mime = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "3676436d3d1f7b81b5a2d2bd8405f412c677558c81b1c92be58c00562bb59095";
      url = "https://repo.hex.pm/tarballs/mime-2.0.3.tar";
    };
    version = "2.0.3";
  };
  ex_aws = {
    buildTool = "mix";
    deps = [
      "hackney"
      "jason"
      "sweet_xml"
    ];
    fetchHex = {
      sha256 = "dc4865ecc20a05190a34a0ac5213e3e5e2b0a75a0c2835e923ae7bfeac5e3c31";
      url = "https://repo.hex.pm/tarballs/ex_aws-2.1.9.tar";
    };
    version = "2.1.9";
  };
  mox = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "4b3c7005173f47ff30641ba044eb0fe67287743eec9bd9545e37f3002b0a9f8b";
      url = "https://repo.hex.pm/tarballs/mox-1.0.0.tar";
    };
    version = "1.0.0";
  };
  swoosh = {
    buildTool = "mix";
    deps = [
      "cowboy"
      "ex_aws"
      "finch"
      "gen_smtp"
      "hackney"
      "jason"
      "mime"
      "plug_cowboy"
      "telemetry"
    ];
    fetchHex = {
      sha256 = "af9a22ab2c0d20b266f61acca737fa11a121902de9466a39e91bacdce012101c";
      url = "https://repo.hex.pm/tarballs/swoosh-1.8.2.tar";
    };
    version = "1.8.2";
  };
  phoenix_ecto = {
    buildTool = "mix";
    deps = [
      "ecto"
      "phoenix_html"
      "plug"
    ];
    fetchHex = {
      sha256 = "13f124cf0a3ce0f1948cf24654c7b9f2347169ff75c1123f44674afee6af3b03";
      url = "https://repo.hex.pm/tarballs/phoenix_ecto-4.2.1.tar";
    };
    version = "4.2.1";
  };
  recon = {
    buildTool = "mix";
    fetchHex = {
      sha256 = "430ffa60685ac1efdfb1fe4c97b8767c92d0d92e6e7c3e8621559ba77598678a";
      url = "https://repo.hex.pm/tarballs/recon-2.5.1.tar";
    };
    version = "2.5.1";
  };
}

