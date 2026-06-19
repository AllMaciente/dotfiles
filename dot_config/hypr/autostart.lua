hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("awww-daemon")
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("huectl reload")
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("kdeconnect-indicator")
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start kanata@main")
end)

hl.on("hyprland.start", function ()
  hl.exec_cmd("wl-paste --watch clipvault store")
end)
