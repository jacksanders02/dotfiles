local _M = {
    terminal   = os.getenv('TERMINAL')   or 'xterm',
    editor     = os.getenv('EDITOR')     or 'vim',
    browser    = os.getenv('BROWSER')    or 'firefox',
    screenshot = os.getenv('SCREENSHOT') or 'flameshot gui'
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

return _M
