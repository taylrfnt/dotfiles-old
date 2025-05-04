{pkgs, ...}: {
  enableLSP = true;
  enableFormat = true;
  enableTreesitter = true;
  enableExtraDiagnostics = true;

  nix = {
    enable = true;
    extraDiagnostics = {
      enable = true;
      types = [
        "statix"
        "deadnix"
      ];
    };
    format = {
      enable = true;
      type = "alejandra";
    };
    lsp.server = "nil";
  };
  markdown = {
    enable = true;
    extensions.render-markdown-nvim.enable = true;
  };
  bash.enable = true;
  clang.enable = true;
  css.enable = true;
  html.enable = true;
  sql.enable = true;
  java.enable = true;
  kotlin.enable = true;
  ts.enable = true;
  go = {
    enable = true;
    format = {
      enable = true;
      package = pkgs.gofumpt;
      type = "gofumpt";
    };
  };
  helm.enable = true;
  lua.enable = true;
  zig.enable = true;
  python.enable = true;
  typst.enable = true;
  # this requires null-ls, which is not ideal.
  rust = {
    enable = true;
    crates.enable = true;
  };
  # Nim LSP is broken on Darwin
  nim.enable = false;
}
