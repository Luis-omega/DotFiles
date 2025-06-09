return {
  cmd = { "rust-analyzer" },
  filetypes = { 'rust' },
  root_markers = { "cargo.toml", ".git" },
  capabilities = {
    experimental = {
      serverStatusNotification = true
    }
  }
}
