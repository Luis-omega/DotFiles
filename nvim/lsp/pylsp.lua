return {
  cmd = { "pylsp" },
  filetypes = { 'python' },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true
          ,
          line_length = 80,
        },
        rope_autoimport = {
          enabled = true
        },
        rope_completion = {
          enabled = true
        }
      }
    }
  }
}
