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

# ── Reload Quickshell ──────────────────────────────────────────
if pgrep -x quickshell >/dev/null; then
    pkill -x quickshell
    # pequena pausa pra garantir que o processo antigo morreu
    sleep 0.2
    quickshell >/dev/null 2>&1 &
    disown
    echo "quickshell: restarted."
else
    quickshell >/dev/null 2>&1 &
    disown
    echo "quickshell: started."
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
