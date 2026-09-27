-- ── Variables ─────────────────────────────
local mod = "SUPER"
local terminal = "alacritty"
local fileManager = "pcmanfm"
local menu = "rofi -show drun"

-- ── App Launchers ─────────────────────────
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("quickshell ipc call center toggle 3"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- ── Window Management ─────────────────────
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pin())

hl.bind(mod .. " + W", function()
    local current = hl.get_config("general.layout")
    local new_layout = (current == "scrolling") and "dwindle" or "scrolling"

    hl.config({ general = { layout = new_layout } })

    local icon = (new_layout == "scrolling") and "view-paged-symbolic" or "view-grid-symbolic"
    hl.exec_cmd(string.format(
        "notify-send -a Hyprland -i %s -t 1500 'Layout' '%s'",
        icon, new_layout
    ))
end)

-- ── Foco (dwindle) / Navegação entre colunas (scrolling) ──
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

-- ── Redimensionar coluna (modo scrolling) — estilo nvim ──
hl.bind(mod .. " + SHIFT + H", hl.dsp.layout("colresize -conf"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.layout("colresize +conf"))

-- ── Mouse Controls ────────────────────────
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume (teclas de mídia)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true })

-- ── Rofi Custom Menus ─────────────────────
hl.bind(mod .. " + T", hl.dsp.exec_cmd("~/.config/rofi/bin/rofi-hue.sh"))
hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd("quickshell ipc call center toggle 4"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd("~/.config/rofi/bin/kanata-switcher.sh"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("clipvault list | rofi -dmenu -display-columns 2 | clipvault get | wl-copy"))

-- Workspaces 1–9 e 0 (mapeado pro 10)
for i = 1, 10 do
    local key = tostring(i % 10) -- 10 vira "0"
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
