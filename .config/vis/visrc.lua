require('vis')

-- plugins 

local autoclose = require('plugins/vis-autoclose')

vis.events.subscribe(vis.events.INIT, function()
	vis:command('set change256colors on')
	vis:command('set theme matugen')

end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)

	vis:command('set autoindent on') 
	vis:command('set numbers on') 
	vis:command('set expandtab off') 
	vis:command('set tabwidth 4') 
	vis:command('set autoindent on') 
	vis:command('set savemethod atomic') 
	vis:command('set ignorecase off') 

end)

-- copypaste

vis:operator_new('y', function(file, range, pos)
  local text = file:content(range)
  local proc = io.popen('wl-copy', 'w')
  if proc then
    proc:write(text)
    proc:close()
  end
  return range.start
end)


vis:map(vis.modes.NORMAL, 'p', function()
  local win = vis.win
  local pos = win.selection.pos
  local proc = io.popen('wl-paste', 'r')
  local text = proc and proc:read('*a') or ''
  if proc then proc:close() end
  win.file:insert(pos, text)
  win.selection.pos = pos + #text
end)

-- newlines on enter

local function line_end(file, pos)
  local text = file:content(pos, math.min(file.size - pos, 4096))
  local nl = text:find('\n', 1, true)
  return nl and (pos + nl - 1) or file.size
end

local function line_start(file, pos)
  if pos == 0 then return 0 end
  local before = math.min(pos, 4096)
  local text = file:content(pos - before, before)
  local nl = text:find('\n[^\n]*$')
  return nl and (pos - before + nl) or 0
end

vis:map(vis.modes.NORMAL, '<Enter>', function()
  local win = vis.win
  local file = win.file
  local pos = win.selection.pos
  local eol = line_end(file, pos)
  file:insert(eol, '\n')
  win.selection.pos = eol + 1
end)

vis:map(vis.modes.NORMAL, '<S-Enter>', function()
  local win = vis.win
  local file = win.file
  local pos = win.selection.pos
  local sol = line_start(file, pos)
  file:insert(sol, '\n')
  win.selection.pos = sol
end)


-- :set command options
--
--  layout nn                      Vertical or horizontal window layout
--  syntax                         Syntax highlighting lexer to use
--  theme                          Color theme to use, filename without extension

--  shell                          Shell to use for external commands (default: $SHELL, /etc/passwd, /bin/sh)
--  colorcolumn|cc nn              Highlight a fixed column 120 
