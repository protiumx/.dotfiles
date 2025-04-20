-- https://github.com/redhat-developer/yaml-language-server
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      completion = true,
      format = {
        enable = true,
        proseWrap = 'never',
        printWidth = 200,
      },
      keyOrdering = false,
      validate = true,
    },
  },
}
