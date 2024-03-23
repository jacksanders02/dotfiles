local _M = {
    terminal = os.getenv('TERMINAL')   or 'xterm',
    editor = os.getenv('EDITOR')     or 'vim',
    browser = 'firefox-developer-edition',
    screenshot= 'flameshot gui',
    emoji= 'rofimoji'
}

_M.editor_cmd = _M.terminal .. '-1 --class editor -e ' .. _M.editor
_M.file_manager_cmd = _M.terminal .. '-1 --class files -e ranger'

return _M
