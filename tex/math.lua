-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
-- indentation matters fix that in autocmd for .lua files
return {
  require("luasnip").snippet(
    { trig = ";g", snippetType="autosnippet" },
    { t("\\gamma") }
  ),

  s({trig=';b', snippetType="autosnippet"},
    {
      t("\\beta"),
    }
   ),

  s({trig=';a', snippetType="autosnippet"},
    {
      t("\\alpha"),
    }
   ),
}
