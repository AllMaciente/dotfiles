#!/usr/bin/env bash
# post_apply.sh — runs after every `huectl apply`
# Arguments: $1 = theme name
set -e
THEME="$1"
CACHE="$HOME/.cache/huectl"

echo "huectl: applying theme '$THEME'..."

# ── Reload Wallpaper (swww) ───────────────────────────────────
WALLPAPER_PATH=$(huectl wallpaper get)

if [ -n "$WALLPAPER_PATH" ]; then
  awww img "$WALLPAPER_PATH" --transition-type any --transition-fps 60
fi

# ── Reload Waybar ─────────────────────────────────────────────
# Envia SIGUSR2 para recarregar config e css sem fechar o processo
if pgrep -x waybar >/dev/null; then
    killall -SIGUSR2 waybar
    echo "waybar: configuration reloaded."
else
    waybar &
    echo "waybar: started."
fi

# ── vscode  ──────────────────────────────────────────────────
TEMA="$HUECTL_custom_vscode"
CONFIG="$HOME/.config/VSCodium/User/settings.json"
mkdir -p "$(dirname "$CONFIG")"

# Garante que o arquivo existe e é um JSON válido
if [ ! -s "$CONFIG" ]; then
    echo "{}" > "$CONFIG"
fi

TMP="$(dirname "$CONFIG")/settings.tmp.json"
jq --arg tema "$TEMA" '.["workbench.colorTheme"] = $tema' "$CONFIG" > "$TMP" && mv "$TMP" "$CONFIG"

echo "Tema VSCodium aplicado: $TEMA"

echo "huectl: done."
