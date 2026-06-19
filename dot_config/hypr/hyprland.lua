require("autostart")
require("keybinds")

-- ── Monitors ──────────────────────────────
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- ── General Config ────────────────────────
hl.config({
  general = {
    border_size = 1,
    gaps_out = 10,
    gaps_in = 3,
  },
  decoration = {
    rounding = 6,
    blur = {
      enabled = true,
      size = 1,
      passes = 3,
      new_optimizations = true,
    },
    inactive_opacity = 0.8,
  },
  ecosystem = {
    no_donation_nag = 1,
    no_update_news = 1,
  },
  input = {
    kb_layout = "br", 
  },
})
