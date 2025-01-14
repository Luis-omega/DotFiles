local M = {}

M.home = os.getenv('HOME')
-- Defined by me in zshenv
M.data = os.getenv('XDG_DATA_HOME')

return M
