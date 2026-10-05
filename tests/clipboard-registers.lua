local ok, err = pcall(function()
  local start = vim.loop.hrtime()
  assert(vim.fn.getreg('+') == '', 'clipboard starts empty')
  assert((vim.loop.hrtime() - start) / 1e9 < 1, 'clipboard read must not wait for OSC 52')

  vim.fn.setreg('+', { 'first', 'second' }, 'V')
  assert(vim.deep_equal(vim.fn.getreg('+', 1, true), { 'first', 'second' }))
  assert(vim.fn.getregtype('+') == 'V', 'linewise type survives clipboard reads')
  assert(vim.fn.getreg('*') == '', 'selection cache is separate')

  vim.fn.setreg('*', { 'block' }, '\0225')
  assert(vim.fn.getreg('*') == 'block')
  assert(vim.fn.getregtype('*') == '\0225', 'blockwise type survives clipboard reads')
  assert(vim.deep_equal(vim.fn.getreg('+', 1, true), { 'first', 'second' }))

  -- Register previews must not query the terminal, including before a yank.
  vim.cmd('registers + *')
  vim.fn.setreg('+', { 'replacement' }, 'v')
  vim.cmd('normal! "+p')
  assert(vim.api.nvim_get_current_line() == 'replacement')
  assert((vim.loop.hrtime() - start) / 1e9 < 1, 'register preview and paste must not block')
end)

if not ok then
  io.stderr:write('FAIL: ' .. tostring(err) .. '\n')
  vim.cmd('cquit')
else
  print('PASS: clipboard reads use separate caches and retain register types')
  vim.cmd('qall!')
end
