# 🧩 How to Install the Dependency for Autotiling

This repository already includes the autotiling.py script and the necessary line in the i3 config to launch it automatically.

To make it work, you only need to install the i3ipc Python dependency.

You can do this using one of the methods below:

### ✅ Option 1: Using uv (recommended)

If you have uv installed, run:

```bash
cd ~/.config/i3/i3-autotiling
uv venv
uv pip install i3ipc
```

### ✅ Option 2: Using Python's built-in venv

```bash
cd ~/.config/i3/i3-autotiling
python3 -m venv .venv
source .venv/bin/activate
pip install i3ipc
```

# 🚀 All set!

After that, restart i3 using `Mod+Shift+R`, and autotiling will start working automatically when you open new windows.
