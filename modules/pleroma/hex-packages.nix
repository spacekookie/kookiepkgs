root: { stdenv, fetchurl, fetchzip, meson, ninja, pkgconfig, elixir, glib, rebar, rebar3 }:

with stdenv.lib;

let
  gzseek = stdenv.mkDerivation {
    name = "gzseek";

    src = fetchzip {
      url = "https://github.com/serokell/gzseek/archive/742ea67e84c8dfffcca3b239320cc9f321487d75.tar.gz";
      sha256 = "0pi871r60kh5xjlkz8paxsasqqjbgdddk8g4hmp4cp32cbx69xlw";
    };

    nativeBuildInputs = [ meson ninja pkgconfig ];
    buildInputs = [ glib ];
  };

  hex = fetchurl {
    url = "https://repo.hex.pm/installs/1.6.0/hex-0.18.1.ez";
    sha512 = "9c806664a3341930df4528be38b0da216a31994830c4437246555fe3027c047e073415bcb1b6557a28549e12b0c986142f5e3485825a66033f67302e87520119";
  };

  fetchHex = { pname, version, sha256 }: stdenv.mkDerivation {
    name = "hex-${pname}-${version}";

    src = fetchurl {
      url = "https://repo.hex.pm/tarballs/${pname}-${version}.tar";
      inherit sha256;

      postFetch = ''
        tar -xf $downloadedFile
        cat VERSION metadata.config contents.tar.gz > $out
      '';
    };

    buildCommand = ''
      mkdir $out && cd $out
      ${gzseek}/bin/gzseek $src | tar -zxf -
      echo ${pname},${version},${sha256},hexpm > .hex
    '';
  };

  closure = {
    html_entities = fetchHex {
      pname = "html_entities";
      version = "0.4.0";
      sha256 = "f2fee876858cf6aaa9db608820a3209e45a087c5177332799592142b50e89a6b";
    };
    ex_aws_s3 = fetchHex {
      pname = "ex_aws_s3";
      version = "2.0.1";
      sha256 = "9e09366e77f25d3d88c5393824e613344631be8db0d1839faca49686e99b6704";
    };
    plug_cowboy = fetchHex {
      pname = "plug_cowboy";
      version = "1.0.0";
      sha256 = "2e2a7d3409746d335f451218b8bb0858301c3de6d668c3052716c909936eb57a";
    };
    nimble_parsec = fetchHex {
      pname = "nimble_parsec";
      version = "0.4.0";
      sha256 = "ee261bb53214943679422be70f1658fff573c5d0b0a1ecd0f18738944f818efe";
    };
    decimal = fetchHex {
      pname = "decimal";
      version = "1.6.0";
      sha256 = "bfd84d90ff966e1f5d4370bdd3943432d8f65f07d3bab48001aebd7030590dcc";
    };
    plug = fetchHex {
      pname = "plug";
      version = "1.7.1";
      sha256 = "8516d565fb84a6a8b2ca722e74e2cd25ca0fc9d64f364ec9dbec09d33eb78ccd";
    };
    cachex = fetchHex {
      pname = "cachex";
      version = "3.0.2";
      sha256 = "1351caa4e26e29f7d7ec1d29b53d6013f0447630bbf382b4fb5d5bad0209f203";
    };
    certifi = fetchHex {
      pname = "certifi";
      version = "2.4.2";
      sha256 = "75424ff0f3baaccfd34b1214184b6ef616d89e420b258bb0a5ea7d7bc628f7f0";
    };
    ssl_verify_fun = fetchHex {
      pname = "ssl_verify_fun";
      version = "1.1.4";
      sha256 = "f0eafff810d2041e93f915ef59899c923f4568f4585904d010387ed74988e77b";
    };
    gen_smtp = fetchHex {
      pname = "gen_smtp";
      version = "0.13.0";
      sha256 = "11f08504c4bdd831dc520b8f84a1dce5ce624474a797394e7aafd3c29f5dcd25";
    };
    meck = fetchHex {
      pname = "meck";
      version = "0.8.9";
      sha256 = "64c5c0bd8bcca3a180b44196265c8ed7594e16bcc845d0698ec6b4e577f48188";
    };
    html_sanitize_ex = fetchHex {
      pname = "html_sanitize_ex";
      version = "1.3.0";
      sha256 = "f005ad692b717691203f940c686208aa3d8ffd9dd4bb3699240096a51fa9564e";
    };
    base64url = fetchHex {
      pname = "base64url";
      version = "0.0.1";
      sha256 = "36a90125f5948e3afd7be97662a1504b934dd5dac78451ca6e9abf85a10286be";
    };
    mock = fetchHex {
      pname = "mock";
      version = "0.3.1";
      sha256 = "994f00150f79a0ea50dc9d86134cd9ebd0d177ad60bd04d1e46336cdfdb98ff9";
    };
    tzdata = fetchHex {
      pname = "tzdata";
      version = "0.5.17";
      sha256 = "50793e3d85af49736701da1a040c415c97dc1caf6464112fd9bd18f425d3053b";
    };
    ex_syslogger = fetchGit {
      url = "https://github.com/slashmili/ex_syslogger.git";
      rev = "f3963399047af17e038897c69e20d552e6899e1d";
    };
    earmark = fetchHex {
      pname = "earmark";
      version = "1.3.0";
      sha256 = "17f0c38eaafb4800f746b457313af4b2442a8c2405b49c645768680f900be603";
    };
    mochiweb = fetchHex {
      pname = "mochiweb";
      version = "2.15.0";
      sha256 = "e1daac474df07651e5d17cc1e642c4069c7850dc4508d3db7263a0651330aacc";
    };
    phoenix_html = fetchHex {
      pname = "phoenix_html";
      version = "2.11.2";
      sha256 = "86ebd768258ba60a27f5578bec83095bdb93485d646fc4111db8844c316602d6";
    };
    connection = fetchHex {
      pname = "connection";
      version = "1.0.4";
      sha256 = "a1cae72211f0eef17705aaededacac3eb30e6625b04a6117c1b2db6ace7d5976";
    };
    poison = fetchHex {
      pname = "poison";
      version = "3.1.0";
      sha256 = "d9eb636610e096f86f25d9a46f35a9facac35609a7591b3be3326e99a0484665";
    };
    bunt = fetchHex {
      pname = "bunt";
      version = "0.2.0";
      sha256 = "951c6e801e8b1d2cbe58ebbd3e616a869061ddadcc4863d0a2182541acae9a38";
    };
    tesla = fetchHex {
      pname = "tesla";
      version = "1.2.1";
      sha256 = "864783cc27f71dd8c8969163704752476cec0f3a51eb3b06393b3971dc9733ff";
    };
    websocket_client = fetchGit {
      url = "https://github.com/jeremyong/websocket_client.git";
      rev = "9a6f65d05ebf2725d62fb19262b21f1805a59fbf";
    };
    db_connection = fetchHex {
      pname = "db_connection";
      version = "1.1.3";
      sha256 = "89b30ca1ef0a3b469b1c779579590688561d586694a3ce8792985d4d7e575a61";
    };
    makeup_elixir = fetchHex {
      pname = "makeup_elixir";
      version = "0.10.0";
      sha256 = "0f09c2ddf352887a956d84f8f7e702111122ca32fbbc84c2f0569b8b65cbf7fa";
    };
    floki = fetchHex {
      pname = "floki";
      version = "0.20.4";
      sha256 = "be42ac911fece24b4c72f3b5846774b6e61b83fe685c2fc9d62093277fb3bc86";
    };
    hackney = fetchHex {
      pname = "hackney";
      version = "1.14.3";
      sha256 = "b5f6f5dcc4f1fba340762738759209e21914516df6be440d85772542d4a5e412";
    };
    postgrex = fetchHex {
      pname = "postgrex";
      version = "0.13.5";
      sha256 = "3d931aba29363e1443da167a4b12f06dcd171103c424de15e5f3fc2ba3e6d9c5";
    };
    ranch = fetchHex {
      pname = "ranch";
      version = "1.3.2";
      sha256 = "e4965a144dc9fbe70e5c077c65e73c57165416a901bd02ea899cfd95aa890986";
    };
    calendar = fetchHex {
      pname = "calendar";
      version = "0.17.4";
      sha256 = "22c5e8d98a4db9494396e5727108dffb820ee0d18fed4b0aa8ab76e4f5bc32f1";
    };
    parse_trans = fetchHex {
      pname = "parse_trans";
      version = "3.3.0";
      sha256 = "09765507a3c7590a784615cfd421d101aec25098d50b89d7aa1d66646bc571c1";
    };
    jose = fetchHex {
      pname = "jose";
      version = "1.8.4";
      sha256 = "7946d1e5c03a76ac9ef42a6e6a20001d35987afd68c2107bcd8f01a84e75aa73";
    };
    metrics = fetchHex {
      pname = "metrics";
      version = "1.0.1";
      sha256 = "25f094dea2cda98213cecc3aeff09e940299d950904393b2a29d191c346a8486";
    };
    eternal = fetchHex {
      pname = "eternal";
      version = "1.2.0";
      sha256 = "e2a6b6ce3b8c248f7dc31451aefca57e3bdf0e48d73ae5043229380a67614c41";
    };
    cowlib = fetchHex {
      pname = "cowlib";
      version = "1.0.2";
      sha256 = "9d769a1d062c9c3ac753096f868ca121e2730b9a377de23dec0f7e08b1df84ee";
    };
    cors_plug = fetchHex {
      pname = "cors_plug";
      version = "1.5.2";
      sha256 = "72df63c87e4f94112f458ce9d25800900cc88608c1078f0e4faddf20933eda6e";
    };
    poolboy = fetchHex {
      pname = "poolboy";
      version = "1.5.1";
      sha256 = "6b46163901cfd0a1b43d692657ed9d7e599853b3b21b95ae5ae0a777cf9b6ca8";
    };
    ecto = fetchHex {
      pname = "ecto";
      version = "2.2.10";
      sha256 = "e7366dc82f48f8dd78fcbf3ab50985ceeb11cb3dc93435147c6e13f2cda0992e";
    };
    phoenix = fetchGit {
      url = "https://github.com/phoenixframework/phoenix.git";
      rev = "ea22dc50b574178a300ecd19253443960407df93";
    };
    phoenix_pubsub = fetchHex {
      pname = "phoenix_pubsub";
      version = "1.1.1";
      sha256 = "6668d787e602981f24f17a5fbb69cc98f8ab085114ebfac6cc36e10a90c8e93c";
    };
    credo = fetchHex {
      pname = "credo";
      version = "0.9.3";
      sha256 = "76fa3e9e497ab282e0cf64b98a624aa11da702854c52c82db1bf24e54ab7c97a";
    };
    jason = fetchHex {
      pname = "jason";
      version = "1.1.2";
      sha256 = "b03dedea67a99223a2eaf9f1264ce37154564de899fd3d8b9a21b1a6fd64afe7";
    };
    idna = fetchHex {
      pname = "idna";
      version = "6.0.0";
      sha256 = "689c46cbcdf3524c44d5f3dde8001f364cd7608a99556d8fbd8239a5798d4c10";
    };
    crypt = fetchGit {
      url = "https://github.com/msantos/crypt";
      rev = "1f2b58927ab57e72910191a7ebaeff984382a1d3";
    };
    plug_crypto = fetchHex {
      pname = "plug_crypto";
      version = "1.0.0";
      sha256 = "18e49317d3fa343f24620ed22795ec29d4a5e602d52d1513ccea0b07d8ea7d4d";
    };
    comeonin = fetchHex {
      pname = "comeonin";
      version = "4.1.1";
      sha256 = "c7304fc29b45b897b34142a91122bc72757bc0c295e9e824999d5179ffc08416";
    };
    unicode_util_compat = fetchHex {
      pname = "unicode_util_compat";
      version = "0.4.1";
      sha256 = "d869e4c68901dd9531385bb0c8c40444ebf624e60b6962d95952775cac5e90cd";
    };
    unsafe = fetchHex {
      pname = "unsafe";
      version = "1.0.0";
      sha256 = "7c21742cd05380c7875546b023481d3a26f52df8e5dfedcb9f958f322baae305";
    };
    web_push_encryption = fetchHex {
      pname = "web_push_encryption";
      version = "0.2.1";
      sha256 = "d42cecf73420d9dc0053ba3299cc8c8d6ff2be2487d67ca2a57265868e4d9a98";
    };
    phoenix_ecto = fetchHex {
      pname = "phoenix_ecto";
      version = "3.3.0";
      sha256 = "702f6e164512853d29f9d20763493f2b3bcfcb44f118af2bc37bb95d0801b480";
    };
    pbkdf2_elixir = fetchHex {
      pname = "pbkdf2_elixir";
      version = "0.12.3";
      sha256 = "6706a148809a29c306062862c803406e88f048277f6e85b68faf73291e820b84";
    };
    cowboy = fetchHex {
      pname = "cowboy";
      version = "1.1.2";
      sha256 = "61ac29ea970389a88eca5a65601460162d370a70018afe6f949a29dca91f3bb0";
    };
    mogrify = fetchHex {
      pname = "mogrify";
      version = "0.6.1";
      sha256 = "de1b527514f2d95a7bbe9642eb556061afb337e220cf97adbf3a4e6438ed70af";
    };
    httpoison = fetchHex {
      pname = "httpoison";
      version = "1.2.0";
      sha256 = "2702ed3da5fd7a8130fc34b11965c8cfa21ade2f232c00b42d96d4967c39a3a3";
    };
    ex_aws = fetchHex {
      pname = "ex_aws";
      version = "2.1.0";
      sha256 = "b92651527d6c09c479f9013caa9c7331f19cba38a650590d82ebf2c6c16a1d8a";
    };
    gettext = fetchHex {
      pname = "gettext";
      version = "0.15.0";
      sha256 = "40a2b8ce33a80ced7727e36768499fc9286881c43ebafccae6bab731e2b2b8ce";
    };
    mime = fetchHex {
      pname = "mime";
      version = "1.3.1";
      sha256 = "30ce04ab3175b6ad0bdce0035cba77bba68b813d523d1aac73d9781b4d193cf8";
    };
    mimerl = fetchHex {
      pname = "mimerl";
      version = "1.0.2";
      sha256 = "993f9b0e084083405ed8252b99460c4f0563e41729ab42d9074fd5e52439be88";
    };
    syslog = fetchGit {
      url = "https://github.com/Vagabond/erlang-syslog.git";
      rev = "4a6c6f2c996483e86c1320e9553f91d337bcb6aa";
    };
    ex_machina = fetchHex {
      pname = "ex_machina";
      version = "2.2.0";
      sha256 = "fec496331e04fc2db2a1a24fe317c12c0c4a50d2beb8ebb3531ed1f0d84be0ed";
    };
    trailing_format_plug = fetchHex {
      pname = "trailing_format_plug";
      version = "0.0.7";
      sha256 = "64b877f912cf7273bed03379936df39894149e35137ac9509117e59866e10e45";
    };
    swoosh = fetchHex {
      pname = "swoosh";
      version = "0.20.0";
      sha256 = "9a6c13822c9815993c03b6f8fccc370fcffb3c158d9754f67b1fdee6b3a5d928";
    };
    ex_doc = fetchHex {
      pname = "ex_doc";
      version = "0.19.1";
      sha256 = "519bb9c19526ca51d326c060cb1778d4a9056b190086a8c6c115828eaccea6cf";
    };
    makeup = fetchHex {
      pname = "makeup";
      version = "0.5.5";
      sha256 = "9e08dfc45280c5684d771ad58159f718a7b5788596099bdfb0284597d368a882";
    };

  };

  # Deep link deps so mix can write build files in the dep dirs, then fool mix
  # to think any git deps are checked out.
  linkDependency = name: src: ''
    cp -rs --no-preserve=mode ${src} deps/${name}
    mkdir deps/${name}/.git
    touch deps/${name}/.git/HEAD
  '';
in

stdenv.mkDerivation {
  name = "mix-project";
  src = root;

  buildInputs = [ elixir rebar rebar3 ];

  configurePhase = ''
    runHook preConfigure

    mkdir deps
    ${concatStringsSep "\n" (mapAttrsToList linkDependency closure)}

    runHook postConfigure
  '';

  HOME = ".";

  MIX_ENV = "prod";
  MIX_REBAR = "${rebar}/bin/rebar";
  MIX_REBAR3 = "${rebar3}/bin/rebar3";

  buildPhase = ''
    runHook preBuild

    mix archive.install --force ${hex}
    mix deps.compile --force
    mix compile --no-deps-check

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir $out
    mv * .mix $out

    runHook postInstall
  '';
}

