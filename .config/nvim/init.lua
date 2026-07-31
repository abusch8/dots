local env = require("env")
env.load_dotenv()

DEFAULT_THEME = "kanagawa"
DEFAULT_ENABLE_ICONS = false

_G.THEME = env.get("NVIM_THEME") or DEFAULT_THEME
_G.ENABLE_ICONS = env.get("NVIM_ENABLE_ICONS") == "1" or DEFAULT_ENABLE_ICONS

local vimrc = vim.fn.expand("~/.vimrc")

if vim.fn.has("win32") == 1 then
    vimrc = vim.fn.expand("~/_vimrc")
end

if vim.fn.filereadable(vimrc) == 1 then
    vim.cmd("source " .. vimrc)
end

require("config.lazy")
require("config.options")
require("config.keymaps")
