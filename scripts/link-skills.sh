#!/usr/bin/env bash
set -eu

DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_TARGET="${1:-$HOME/.agents/skills}"
mkdir -p "$SKILLS_TARGET"

for skill in "$DOTFILES_PATH"/skills/*; do
  [ -f "$skill/SKILL.md" ] || continue
  destination="$SKILLS_TARGET/$(basename "$skill")"
  if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$skill" ]; then
    echo "Already linked: $destination"
  elif [ -e "$destination" ] || [ -L "$destination" ]; then
    echo "Skill link conflict; preserved: $destination" >&2
    exit 1
  else
    ln -s "$skill" "$destination"
    echo "Linked: $destination"
  fi
done
