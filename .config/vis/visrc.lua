require('vis')

-- plugins 

local autoclose = require('plugins/vis-autoclose')

local colorizer = require('plugins/vis-colorizer')
colorizer.three = false
colorizer.six   = true

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

 -- enter newline my belowed
	vis:map(vis.modes.NORMAL, "<Enter>", function()
		vis:feedkeys("o<Escape>")
	end, "")

	vis:map(vis.modes.NORMAL, "<S-Enter>", function()
		vis:feedkeys("O<Escape>")
	end, "")

 --copypaste 

	vis:map(vis.modes.NORMAL,      'y', '<vis-register>+<vis-operator-yank>')
    vis:map(vis.modes.VISUAL,      'y', '<vis-register>+<vis-operator-yank>')
    vis:map(vis.modes.VISUAL_LINE, 'y', '<vis-register>+<vis-operator-yank>')
    vis:map(vis.modes.NORMAL,      'p', '<vis-register>+<vis-put-after>')
    vis:map(vis.modes.VISUAL,      'p', '<vis-register>+<vis-put-after>')
    vis:map(vis.modes.VISUAL_LINE, 'p', '<vis-register>+<vis-put-after>')
    vis:map(vis.modes.NORMAL,      'P', '<vis-register>+<vis-put-before>')
    vis:map(vis.modes.VISUAL,      'P', '<vis-register>+<vis-put-before>')
    vis:map(vis.modes.VISUAL_LINE, 'P', '<vis-register>+<vis-put-before>')

 -- fm
	vis:map(vis.modes.NORMAL, "fm", function()
		vis:command("open .")
		vis:feedkeys("<C-w>k")
		vis:command("wq!")
	end, "")
end)


-- :set command options
--
--  layout nn                      Vertical or horizontal window layout
--  syntax                         Syntax highlighting lexer to use
--  theme                          Color theme to use, filename without extension

--  shell                          Shell to use for external commands (default: $SHELL, /etc/passwd, /bin/sh)
--  colorcolumn|cc nn              Highlight a fixed column 120 
