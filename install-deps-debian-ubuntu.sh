#!/bin/bash
set -euo pipefail

PACKAGES=(
  git build-essential make gcc g++ curl wget unzip fontconfig
  ripgrep fd-find nodejs npm golang-go openjdk-21-jdk
  xclip wl-clipboard python3
)

INSTALL_MODE=1

usage() {
  cat <<'EOF'
Usage: ./install-deps-debian-ubuntu.sh [--check|--help]
EOF
}

for arg in "$@"; do
  case "$arg" in
    --check) INSTALL_MODE=0 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Error: unknown option: $arg" >&2; exit 2 ;;
  esac
done

[[ -r /etc/os-release ]] || { echo "Error: cannot read /etc/os-release." >&2; exit 1; }
. /etc/os-release
DISTRO_ID="${ID:-unknown}"; DISTRO_LIKE="${ID_LIKE:-}"

case " $DISTRO_ID $DISTRO_LIKE " in
  *" debian "*|*" ubuntu "*) ;;
  *) echo "Error: unsupported distribution: $DISTRO_ID. This script supports Debian/Ubuntu only." >&2; exit 1 ;;
esac

check_neovim() {
  if ! command -v nvim >/dev/null 2>&1; then
    echo "Error: neovim not found. Config requires Neovim >= 0.12." >&2
    return 1
  fi
  local version major minor
  version="$(nvim --version | awk 'NR==1 {print $2}')"
  version="${version#v}"
  if [[ ! "$version" =~ ^([0-9]+)\.([0-9]+) ]]; then
    echo "Error: could not detect neovim version: $version." >&2
    return 1
  fi
  major="${BASH_REMATCH[1]}"; minor="${BASH_REMATCH[2]}"
  if (( major == 0 && minor < 12 )); then
    echo "Error: found Neovim $version, but config requires >= 0.12." >&2
    return 1
  fi
  return 0
}

missing=()
for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done
ts_missing=0; dpkg -s tree-sitter-cli >/dev/null 2>&1 || ts_missing=1

if (( ! INSTALL_MODE )); then
  failed=0
  if ((${#missing[@]})); then
    echo "Error: missing packages: ${missing[*]}" >&2
    failed=1
  fi
  if (( ts_missing )); then
    echo "Error: missing package: tree-sitter-cli (fallback: npm install -g tree-sitter-cli)." >&2
    failed=1
  fi
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    echo "Error: missing command: fd (found fdfind, symlink required: ~/.local/bin/fd)." >&2
    failed=1
  fi
  check_neovim || failed=1
  if (( failed == 0 )); then
    echo "Success: all dependencies installed."
  fi
  exit "$failed"
fi

command -v sudo >/dev/null 2>&1 || { echo "Error: sudo not found." >&2; exit 1; }
sudo -v || { echo "Error: sudo authentication failed." >&2; exit 1; }

sudo apt-get update || { echo "Error: apt-get update failed." >&2; exit 1; }

if ((${#missing[@]})); then
  sudo apt-get install -y "${missing[@]}" || { echo "Error: apt-get install failed for: ${missing[*]}" >&2; exit 1; }
fi

if ! command -v tree-sitter >/dev/null 2>&1; then
  if ! sudo apt-get install -y tree-sitter-cli; then
    if command -v npm >/dev/null 2>&1; then
      npm install -g tree-sitter-cli || { echo "Error: failed to install tree-sitter-cli via npm." >&2; exit 1; }
    else
      echo "Error: tree-sitter-cli not available via apt and npm not found." >&2
      exit 1
    fi
  fi
fi

if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/bin" || { echo "Error: failed to create directory: $HOME/.local/bin." >&2; exit 1; }
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd" || { echo "Error: failed to create symlink: $HOME/.local/bin/fd." >&2; exit 1; }
fi

check_neovim || exit 1

echo "Success: dependencies installed."
