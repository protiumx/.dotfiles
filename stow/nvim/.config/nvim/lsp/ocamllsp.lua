local util = require('config.lsp.util')

local language_id_of = {
  menhir = 'ocaml.menhir',
  ocaml = 'ocaml',
  ocamlinterface = 'ocaml.interface',
  ocamllex = 'ocaml.ocamllex',
  reason = 'reason',
  dune = 'dune',
}

local get_language_id = function(_, ftype)
  return language_id_of[ftype]
end

-- https://github.com/ocaml/ocaml-lsp
return {
  cmd = { 'ocamllsp' },
  filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      util.root_pattern(
        '*.opam',
        'esy.json',
        'package.json',
        '.git',
        'dune-project',
        'dune-workspace'
      )(fname)
    )
  end,
  get_language_id = get_language_id,
  settings = {
    codelens = { enable = true },
  },
}
