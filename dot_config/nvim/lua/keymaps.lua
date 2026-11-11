-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Terminal toggle ]]
--  <Space>tt: show/hide a bottom terminal. First press launches it, later presses only
--             show/hide the same shell (cwd, history and scrollback survive; a hidden
--             shell keeps running). The shell dies when nvim exits.
--  <Space>tc: wipe the terminal buffer, i.e. kill the shell.
--  <Space>tf / <C-t>f: focus the terminal window and start typing. Does nothing when the
--                       terminal is hidden/not on screen (it never swaps the buffer of the
--                       window you are in).
local term_buf

local function term_win()
  if not (term_buf and vim.api.nvim_buf_is_valid(term_buf)) then
    return nil
  end
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(w) == term_buf then
      return w
    end
  end
  return nil
end

local function term_hide(w)
  if vim.fn.winnr '$' == 1 then
    -- can't close the last window, so swap the terminal out of it
    if not pcall(vim.cmd, 'b #') then
      vim.cmd 'enew'
    end
  else
    vim.api.nvim_win_close(w, true) -- window only: buffer stays hidden, shell keeps running
  end
end

local function term_show()
  vim.cmd 'botright 12split'
  vim.api.nvim_set_current_buf(term_buf)
  -- window-local, so re-apply every time the terminal gets a new window
  vim.wo.number, vim.wo.relativenumber, vim.wo.signcolumn = false, false, 'no'
  vim.cmd 'startinsert'
end

-- Focus the window that is *currently showing* the terminal. If the terminal is hidden
-- (buffer exists, but no window displays it) or was never opened: do nothing.
local function term_focus()
  local w = term_win()
  if not w then
    return
  end
  vim.api.nvim_set_current_win(w) -- move focus to the terminal window, don't touch this window's buffer
  vim.wo.number, vim.wo.relativenumber, vim.wo.signcolumn = false, false, 'no'
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<Space>tt', function()
  local w = term_win()
  if w then
    term_hide(w)
    return
  end
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    term_show() -- re-show the existing shell
    return
  end
  vim.cmd 'botright 12split | terminal' -- launch
  term_buf = vim.api.nvim_get_current_buf()
  vim.bo.bufhidden = 'hide' -- closing the window must never kill the job
  vim.wo.number, vim.wo.relativenumber, vim.wo.signcolumn = false, false, 'no'
  vim.cmd 'startinsert'
end, { desc = 'Toggle [T]erminal' })

vim.keymap.set('n', '<Space>tc', function()
  local w = term_win()
  if w then
    term_hide(w)
  end
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_buf_delete(term_buf, { force = true }) -- kills the shell job
  end
  term_buf = nil
  vim.notify '[terminal] shell killed'
end, { desc = '[T]erminal [C]lose and kill shell' })

vim.keymap.set('n', '<Space>tf', term_focus, { desc = '[T]erminal [F]ocus' })
-- NOTE: <C-t> is also the builtin "pop the tag stack" (jump back from a definition). Binding
-- <C-t>f means a lone <C-t> now waits 'timeoutlen' ms (default 1s) before that builtin runs.
-- Do NOT add nowait here - with nowait Vim never waits for the 'f', so the mapping would never
-- fire and <C-t> would stay builtin.
-- desc = 'which_key_ignore' keeps which-key from turning a lone <C-t> into a popup, which would
-- swallow that builtin; <C-t>f itself is documented by <Space>tf above.
vim.keymap.set('n', '<C-t>f', term_focus, { desc = 'which_key_ignore' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
