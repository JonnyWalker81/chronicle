{
  mkShell,
  zls,
  lib,
  stdenv,
  bashInteractive,
  gdb,
  #, glxinfo # unused
  ncurses,
  nodejs,
  nodePackages,
  oniguruma,
  parallel,
  pkg-config,
  python3,
  qemu,
  scdoc,
  valgrind,
  #, vulkan-loader # unused
  vttest,
  wabt,
  wasmtime,
  zig,
  zip,
  llvmPackages_latest,
  bzip2,
  expat,
  fontconfig,
  freetype,
  glib,
  glslang,
  gtk4,
  libadwaita,
  adwaita-icon-theme,
  hicolor-icon-theme,
  harfbuzz,
  libpng,
  libGL,
  libX11,
  libXcursor,
  libXext,
  libXi,
  libXinerama,
  libXrandr,
  libxml2,
  spirv-cross,
  simdutf,
  zlib,
  alejandra,
  minisign,
  pandoc,
  hyperfine,
  typos,
}:
let
  # See package.nix. Keep in sync.
  rpathLibs =
    [ libGL ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      bzip2
      expat
      fontconfig
      freetype
      harfbuzz
      libpng
      libxml2
      oniguruma
      simdutf
      zlib

      glslang
      spirv-cross

      libX11
      libXcursor
      libXi
      libXrandr

      libadwaita
      gtk4
      glib
    ];
in
mkShell {
  name = "chronicle";

  packages =
    [
      # For builds
      llvmPackages_latest.llvm
      minisign
      ncurses
      pandoc
      pkg-config
      scdoc
      zig
      zip
      zls

      # For web and wasm stuff
      nodejs

      # Linting
      nodePackages.prettier
      alejandra
      typos

      # Testing
      parallel
      python3
      vttest
      hyperfine

      # wasm
      wabt
      wasmtime
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      # My nix shell environment installs the non-interactive version
      # by default so we have to include this.
      bashInteractive

      # Used for testing SIMD codegen. This is Linux only because the macOS
      # build only has the qemu-system files.

      gdb
      valgrind
      bzip2
      expat
      fontconfig
      freetype
      harfbuzz
      libpng
      libxml2
      oniguruma
      simdutf
      zlib

      glslang
      spirv-cross

      libX11
      libXcursor
      libXext
      libXi
      libXinerama
      libXrandr
    ];

  # This should be set onto the rpath of the ghostty binary if you want
  # it to be "portable" across the system.
  LD_LIBRARY_PATH = lib.makeLibraryPath rpathLibs;

  shellHook = (
    lib.optionalString stdenv.hostPlatform.isLinux ''
      # On Linux we need to setup the environment so that all GTK data
      # is available (namely icons).

      # Minimal subset of env set by wrapGAppsHook4 for icons and global settings
      # export XDG_DATA_DIRS=$XDG_DATA_DIRS:${hicolor-icon-theme}/share:${adwaita-icon-theme}/share
      # export XDG_DATA_DIRS=$XDG_DATA_DIRS:$GSETTINGS_SCHEMAS_PATH # from glib setup hook
    ''
  );
}
