#!/usr/bin/env bash
# bash-completion.sh — Tab completion for chart-* helpers and chart names

_owf_chart_names() {
  # Use portable find + basename pattern (works on GNU and BSD find)
  find charts -maxdepth 1 -mindepth 1 -type d 2> /dev/null | while read -r dir; do
    basename "$dir"
  done
}

_complete_chart_cmd() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  case "${prev}" in
    chart-release-pr | chart-docs | chart-changelog | chart-ct-install)
      local chart_list
      chart_list=$(_owf_chart_names)
      mapfile -t COMPREPLY < <(compgen -W "${chart_list}" -- "${cur}")
      return 0
      ;;
    --base)
      mapfile -t COMPREPLY < <(compgen -W "main" -- "${cur}")
      return 0
      ;;
    *) ;;
  esac
  # First arg
  if [[ ${COMP_CWORD} -eq 1 ]]; then
    local chart_list
    chart_list=$(_owf_chart_names)
    mapfile -t COMPREPLY < <(compgen -W "${chart_list}" -- "${cur}")
  fi
}

complete -F _complete_chart_cmd chart-release-pr
complete -F _complete_chart_cmd chart-docs
complete -F _complete_chart_cmd chart-changelog
complete -F _complete_chart_cmd chart-ct-install
complete -F _complete_chart_cmd chart-local-test
