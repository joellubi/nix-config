{ lib, ... }:
{
        perSystem =
                { pkgs, ... }:
                let
                        host = pkgs.stdenv.hostPlatform;
                        package = if host.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

                        wrapped = pkgs.writeShellScriptBin "ghostty" ''
                                if (( $# == 0 )); then
                                    export GHOSTTY_MAC_LAUNCH_SOURCE=app
                                    exec ${lib.getExe package} --config-file=${./config.ghostty}
                                else
                                    exec ${lib.getExe package} "$@"
                                fi
                        '';

                        # macOS refuses to launch a bundle that sets LSEnvironment unless its
                        # executable is validly signed, which a script can't be. Drop the key
                        # from Info.plist and export env vars in wrapper.
                        postBuild = lib.optionalString host.isDarwin ''
                                contents=$out/Applications/Ghostty.app/Contents
                                rm $contents/MacOS/ghostty $contents/Info.plist
                                ln -s ${lib.getExe wrapped} $contents/MacOS/ghostty
                                cp ${package}/Applications/Ghostty.app/Contents/Info.plist $contents/Info.plist
                                chmod u+w $contents/Info.plist
                                ${pkgs.xcbuild}/bin/PlistBuddy -c "Delete :LSEnvironment" $contents/Info.plist
                        '';
                in
                {
                        packages.ghostty = pkgs.symlinkJoin {
                                name = "ghostty";
                                paths = [
                                        wrapped
                                        package
                                ];
                                inherit postBuild;
                        };
                };
}
