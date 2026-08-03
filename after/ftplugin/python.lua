vim.opt_local.copyindent = true

vim.opt_local.formatprg =
  "python3 -m black --quiet --skip-string-normalization -"

-- Choose a logging pattern
if vim.fn.search("import logging", "nw", 100) ~= 0 then
  vim.b.printf_pattern = [[logging.info('%{}'.format(%s))]]
else
  vim.b.printf_pattern = [[print('%{}'.format(%s))]]
end
