return {
  cmd = { "purescript-language-server", "--stdio" },
  filetypes = { "purescript" },
  root_markers = { "bower.json", "flake.nix", "psc-package.json", "shell.nix", "spago.dhall", "spago.yaml" },
  settings = {
    purescript = {
      addSpagoSources = true -- e.g. any purescript language-server config here
      ,
      formatter = "purs-tidy"
    }
  },
  flags = {
    debounce_text_changes = 150,
  }

}
