-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual
-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { trig = "hi" },
    { t("Hello, world!") }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  -- for some reason only snippets in this file work, oh man
  require("luasnip").snippet(
    { trig = "foo" },
    { t("THE BIG BAD snippet.") }
  ),
  require("luasnip").snippet(
    { trig = ";g" },
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
-- Examples of complete snippets using fmt and fmta

-- \texttt
s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
  fmta(
    "\\texttt{<>}",
    { i(1) }
  )
),
-- \frac
s({trig="ff", dscr="Expands 'ff' into '\frac{}{}'"},
  fmt(
    "\\frac{<>}{<>}",
    {
      i(1),
      i(2)
    },
    {delimiters = "<>"} -- manually specifying angle bracket delimiters
  )
),
-- Equation
s({trig="eq", dscr="Expands 'eq' into an equation environment"},
  fmta(
     [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
     { i(1) }
  )
),


s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta("\\textit{<>}",
    {
      d(1, get_visual),
    }
  )
),

s({trig = "eqq", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta(
     [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
     { d(1, get_visual) }
  )
),

s({trig = "la", dscr = "langle expansion"},
-- snip for opening \langle CURSOR |
  fmta(
     [[
           \langle<>|
     ]],
     { d(1, get_visual) }
  )
),

s({trig = "ra", dscr = "rangle expansion"},
-- snip for opening | CURSOR \rangle
  fmta(
     [[
           |<>\rangle
     ]],
     { d(1, get_visual) }
  )
),


s({trig = "ha", dscr = "hat expansion"},
-- snip for opening \hat{CURSOR_1}_CURSOR_2
  fmta(
     [[
           \hat{<>}_<>
     ]],
     { d(1, get_visual),
       d(2, get_visual) }
  )
),

s({trig = "imp", dscr = "implies expansion"},
--
  fmta(
     [[
           \implies<>
     ]],
     { d(1, get_visual),
       }
  )
),

s({trig = "lc", dscr = "left curly expansion"},
--
  fmta(
     [[
           \left(<>
     ]],
     { d(1, get_visual),
       }
  )
),

s({trig = "rc", dscr = "right curly expansion"},
--
  fmta(
     [[
           \right)<>
     ]],
     { d(1, get_visual),
       }
  )
),
s({trig = "pm", dscr = "no backslash for pm"},
--
  fmta(
     [[
           \pm<>
     ]],
     { d(1, get_visual),
       }
  )
),
--s({trig = "hbar", dscr = "no backslash for hbar"},
----
--  fmta(
--     [[
--           \hbar<>
--     ]],
--     { d(1, get_visual),
--       }
--  )
--),
-- s({trig="env", snippetType="autosnippet"},
s({trig="env", desr="environment snippet"},
-- Code for environment snippet in the above GIF
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1),  -- this node repeats insert node i(1)
    }
  )
),
s({trig = "sq", dscr = "squiqqly letter"},
--
  fmta(
     [[
           \mathbb{<>}
     ]],
     { d(1, get_visual),
       }
  )
),
s({trig = "act", dscr = "actuarial angle"},
--
  fmta(
     [[
           \actuarialangle{<>}
     ]],
     { d(1, get_visual),
       }
  )
),
-- %make copilot completion into somethin that isn't tab (maybe ctrl+space))

--* here is where my tentative snips will go
--
--*

}
