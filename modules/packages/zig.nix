{ ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      zigVersion = "0.17.0-dev.704+b8cb78023";

      zigHashes = {
        aarch64-darwin = "sha256-wHVtTAsRZCX3qiVNP+G1kngTsk/ktEMFxb3sI1rJjOQ=";
        x86_64-linux = "sha256-F+rOqhtxh+0026hqlHFR0K0MXl2gECk0c9UZ2iU1toI=";
      };

      host = pkgs.stdenv.hostPlatform;
      arch = host.parsed.cpu.name;
      os =
        if host.isDarwin then
          "macos"
        else if host.isLinux then
          "linux"
        else
          throw "Unsupported Zig binary OS: ${host.system}";

      dirname = "zig-${arch}-${os}-${zigVersion}";
      filename = "${dirname}.tar.xz";
    in
    {
      packages.zig = pkgs.stdenvNoCC.mkDerivation {
        pname = "zig";
        version = zigVersion;

        src = pkgs.fetchurl {
          url = "https://ziglang.org/builds/${filename}";
          hash = zigHashes.${system} or (throw "Missing zig hash for platform ${system}");
        };

        nativeBuildInputs = [ pkgs.xz ];

        sourceRoot = dirname;

        unpackPhase = ''
          runHook preUnpack
          tar -xJf "$src"
          runHook postUnpack
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          cp -R . $out/
          chmod +x $out/zig
          ln -s $out/zig $out/bin/zig
          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Zig compiler binary distribution";
          homepage = "https://ziglang.org/";
          license = licenses.mit;
          platforms = builtins.attrNames zigHashes;
          mainProgram = "zig";
        };
      };
    };
}
