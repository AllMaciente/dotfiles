-- ── Variables ─────────────────────────────
local mod = "SUPER"
local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "rofi -show drun"

-- ── App Launchers ─────────────────────────
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("wlogout"))

-- ── Window Management ─────────────────────
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. "+ SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pin())

-- ── Mouse Controls ────────────────────────
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Aumentar o volume (Mod + Shift + Scroll para cima)
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true })

-- Diminuir o volume (Mod + Shift + Scroll para baixo)
hl.bind(mod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true })

-- ── Focus Movement (Vim Style) ────────────
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

-- ── Rofi Custom Menus ─────────────────────
hl.bind(mod .. " + T", hl.dsp.exec_cmd("~/.config/rofi/bin/rofi-hue.sh"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("~/.config/rofi/bin/kanata-switcher.sh"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("clipvault list | rofi -dmenu -display-columns 2 | clipvault get | wl-copy"))
-- Loop para criar atalhos automáticos do Workspace 1 até o 9
for i = 1, 9 do
    local key = tostring(i)

    -- SUPER + [1-9]: Troca para o Workspace correspondente
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))

    -- SUPER + SHIFT + [1-9]: Move a janela ativa para o Workspace correspondente
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
