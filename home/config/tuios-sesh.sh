# Pick a tuios session like `sesh connect`: running sessions, sesh configs, then zoxide.
# TUIOS_SESH_CONFIG points at the sesh settings rendered to JSON by home/tuios.nix.

# fzf calls back with: preview <kind> <session name> <directory>
if [ "${1:-}" = preview ]; then
  if [ "$2" = tuios ]; then
    tuios capture-pane --session "$3" --ansi --trim
  else
    eza --all --icons=always --color=always --group-directories-first --oneline "$4"
  fi
  exit 0
fi

current="${TUIOS_SESSION:-}"
sessions_json="$(tuios ls --json 2>/dev/null || echo '[]')"

# Look sessions up in bash: one jq per zoxide row made the picker slow to open.
declare -A sessions=()
while IFS= read -r name; do
  [ -n "$name" ] && sessions["$name"]=1
done < <(jq -r '.[].name' <<<"$sessions_json")

has_session() {
  [ -n "${sessions[$1]:-}" ]
}

# Nerd Font icons, coloured per source so running sessions stand out.
running=$'\e[1;32m\uf489 \e[0;1m'
configured=$'\e[33m\uf013 \e[0m'
zoxide=$'\e[34m\uf07b \e[0m'
dim=$'\e[2m'
reset=$'\e[0m'

# Rows: label <TAB> kind <TAB> session name <TAB> directory
rows() {
  local name info path
  while IFS=$'\t' read -r name info; do
    printf '%s%s%s  %s%s%s\ttuios\t%s\t\n' "$running" "$name" "$reset" "$dim" "$info" "$reset" "$name"
  done < <(jq -r --arg current "$current" \
    '.[] | select(.name != $current) | [.name, "\(.window_count) win\(if .branch then " · \(.branch)" else "" end)"] | @tsv' \
    <<<"$sessions_json")

  while IFS=$'\t' read -r name path; do
    has_session "$name" && continue
    printf '%s%s  %s%s%s\tconfig\t%s\t%s\n' "$configured" "$name" "$dim" "$path" "$reset" "$name" "${path/#"~"/$HOME}"
  done < <(jq -r '.session[]? | "\(.name)\t\(.path)"' "$TUIOS_SESH_CONFIG")

  while IFS= read -r path; do
    # Same naming as sesh: the folder name, with characters tmux rejects replaced.
    name="${path%/}"
    name="${name##*/}"
    name="${name//[.: ]/_}"
    has_session "$name" && continue
    printf '%s%s\tzoxide\t%s\t%s\n' "$zoxide" "${path/#"$HOME"/"~"}" "$name" "$path"
  done < <(zoxide query --list 2>/dev/null)
}

# Config and zoxide rows can name the same session; keep the first.
selection="$(
  rows | awk -F '\t' '!seen[$3]++' |
    fzf --ansi --reverse --no-sort --delimiter '\t' --with-nth 1 \
      --prompt 'session> ' --header "${running}running${reset}   ${configured}sesh   ${zoxide}zoxide" \
      --preview "'$0' preview {2} {3} {4}" --preview-window 'right,55%,border-left'
)" || exit 0

IFS=$'\t' read -r _ kind name dir <<<"$selection"

switch_args=()
[ -n "$current" ] && switch_args+=(--session "$current")

if [ "$kind" = tuios ] || has_session "$name"; then
  exec tuios switch-session "${switch_args[@]}" "$name"
fi

tuios switch-session "${switch_args[@]}" --create --cwd "$dir" "$name" >/dev/null

[ "$kind" = config ] || exit 0

# Replay the sesh config: the startup command in the first pane, each window on its own workspace.
startup="$(jq -r --arg name "$name" '.session[] | select(.name == $name) | .startup_command // empty' "$TUIOS_SESH_CONFIG")"
[ -n "$startup" ] && tuios send-text --session "$name" "$startup"$'\n' >/dev/null

workspace=2
while IFS= read -r window; do
  script="$(jq -r --arg name "$window" '.window[]? | select(.name == $name) | .startup_script // empty' "$TUIOS_SESH_CONFIG")"
  tuios new-window --session "$name" --workspace "$workspace" --cwd "$dir" --no-focus "$window" >/dev/null
  [ -n "$script" ] && tuios send-text --session "$name" --window "$window" "$script"$'\n' >/dev/null
  workspace=$((workspace + 1))
done < <(jq -r --arg name "$name" '.session[] | select(.name == $name) | .windows[]?' "$TUIOS_SESH_CONFIG")
