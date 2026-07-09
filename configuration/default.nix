{...}: {
  imports = [
    ./packages.nix
    ./defaults.nix
    ./homebrew.nix
    ./services.nix
    ./nix.nix
    ./programs.nix
    ./system.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      typescript = final.stdenvNoCC.mkDerivation (finalAttrs: {
        pname = "typescript";
        version = "7.0.2";

        src = final.fetchurl {
          url = "https://registry.npmjs.org/typescript/-/typescript-${finalAttrs.version}.tgz";
          hash = "sha512-8FYau96o3NKOhbjKi/qNvG/W5jhzxkbdm5sj9AbZ/5T5sWqn3hJgLfGx27sRKZWTvyzCP8dLRBTf5tBTSRVUNA==";
        };

        sourceRoot = "package";
        nativeBuildInputs = [final.makeWrapper];

        installPhase = ''
          runHook preInstall

          mkdir -p "$out/lib/node_modules/typescript" "$out/bin"
          cp -R . "$out/lib/node_modules/typescript"

          makeWrapper "${final.nodejs}/bin/node" "$out/bin/tsc" \
            --add-flags "$out/lib/node_modules/typescript/bin/tsc"
          makeWrapper "${final.nodejs}/bin/node" "$out/bin/tsserver" \
            --add-flags "$out/lib/node_modules/typescript/bin/tsserver"

          runHook postInstall
        '';

        meta = prev.typescript.meta // {
          changelog = "https://github.com/microsoft/TypeScript/releases/tag/v${finalAttrs.version}";
        };
      });

      typescript-language-server = prev.typescript-language-server.override {
        typescript = final.typescript;
      };
    })
  ];
}
