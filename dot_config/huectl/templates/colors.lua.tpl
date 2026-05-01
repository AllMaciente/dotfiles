-- AUTO-GENERATED FILE WIT huectl (não editar)
local M = {}

function M.apply()
  local set = vim.api.nvim_set_hl

  local c = {
    bg = "{{background}}",
    fg = "{{foreground}}",
    cursor = "{{cursor}}",

    c0  = "{{color0}}",
    c1  = "{{color1}}",
    c2  = "{{color2}}",
    c3  = "{{color3}}",
    c4  = "{{color4}}",
    c5  = "{{color5}}",
    c6  = "{{color6}}",
    c7  = "{{color7}}",
    c8  = "{{color8}}",
    c9  = "{{color9}}",
    c10 = "{{color10}}",
    c11 = "{{color11}}",
    c12 = "{{color12}}",
    c13 = "{{color13}}",
    c14 = "{{color14}}",
    c15 = "{{color15}}",
  }

  -- BASE
  set(0, "Normal", { fg = c.fg, bg = c.bg })
  set(0, "Cursor", { fg = c.bg, bg = c.cursor })

  -- SINTAXE
  set(0, "Comment",  { fg = c.c8, italic = true })
  set(0, "Keyword",  { fg = c.c1 })
  set(0, "String",   { fg = c.c2 })
  set(0, "Function", { fg = c.c4 })
  set(0, "Type",     { fg = c.c3 })
  set(0, "Constant", { fg = c.c5 })
  set(0, "Number",   { fg = c.c6 })

  -- UI
  set(0, "LineNr",       { fg = c.c8 })
  set(0, "CursorLineNr", { fg = c.c3, bold = true })
  set(0, "Visual",       { bg = c.c8 })
  set(0, "StatusLine",   { fg = c.fg, bg = c.c0 })
  set(0, "VertSplit",    { fg = c.c8 })

  -- TREESITTER
  set(0, "@keyword", { fg = c.c1 })
  set(0, "@string",  { fg = c.c2 })
  set(0, "@function",{ fg = c.c4 })
  set(0, "@type",    { fg = c.c3 })
  set(0, "@number",  { fg = c.c6 })
end

return M