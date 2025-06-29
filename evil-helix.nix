# ./evil-helix.nix
# This file manages all shell-related tools and configurations.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    evil-helix
  ];


  xdg.configFile."helix/config.toml".text = ''
    # This is a Nix multi-line string
    theme = "rasmus"

    [editor]
    line-number = "relative"
    cursorline = true

    [editor.cursor-shape]
    insert = "bar"
    normal = "block"
    select = "underline"
  '';

  xdg.configFile."helix/languages.toml".text = ''
    [[language]]
    name = "typescript"
    roots = ["deno.json", "deno.jsonc", "package.json"]
    file-types = ["ts", "tsx"]
    auto-format = true
    language-servers = ["deno-lsp"]

    [[language]]
    name = "javascript"
    roots = ["deno.json", "deno.jsonc", "package.json"]
    file-types = ["js", "jsx"]
    auto-format = true
    language-servers = ["deno-lsp"]

    [language-server.deno-lsp]
    command = "deno"
    args = ["lsp"]
    config.deno.enable = true
  '';


}
