return {
  cmd = { "npx", "typescript-language-server", "--stdio" },

  filetypes = { 'typescript', "javascript" },
  root_markers = { "tsconfig.json", "jsconfig.json", ".git" },
}
