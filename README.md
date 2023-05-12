# LuaSnip

must also add the following directory and file for my all.lua to work for you

[https://www.ejmastnak.com/tutorials/vim-latex/luasnip/](https://www.ejmastnak.com/tutorials/vim-latex/luasnip/#:~:text=Create%20a%20file%20at%20e.g.%20~/.config/nvim/lua/luasnip%2Dhelper%2Dfuncs.lua%2C%20and%20inside%20it%20place)

```
-- ~/.config/nvim/lua/luasnip-helper-funcs.lua
local M = {}

-- Be sure to explicitly define these LuaSnip node abbreviations!
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

return M
```
