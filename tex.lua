return {
--idk why these don't actually do anythin in .tex file
--bc it is reading this file
s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
  fmta(
    "<>$<>$",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual),
    }
  )
),

s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
  fmta(
    "<>e^{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual)
    }
  )
),
s({trig = '([^%a])ff', regTrig = true, wordTrig = false},
  fmta(
    [[<>\frac{<>}{<>}]],
    {
      f( function(_, snip) return snip.captures[1] end ),
      i(1),
      i(2)
    }
  )
),
s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta(
    "<>_{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("0")
    }
  )
),
}
