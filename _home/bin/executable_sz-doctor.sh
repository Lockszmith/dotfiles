#! /usr/bin/env bash

function check-exist() {
  _TEST_RESULT='Missing'
  _TEST_NAME=$1
  _TEST_PATH=${2:-$(type -fP $_TEST_NAME | head -1 2>/dev/null)}
  [[ -n "$_TEST_PATH" ]] && eval "[[ ${3:--x} ${_TEST_PATH// /\\ } ]]" && _TEST_RESULT='Found'
  printf "%-30s: %-8s %s \n" "$_TEST_NAME" "$_TEST_RESULT" "${4}"
}

echo "Shell: $SHELL"
echo ""

echo "vi editor(s) found:"
echo "$(type -fP nvim vim vi)"
echo ""

check-exist "Byobu" "/usr/bin/byobu-launch"
check-exist "oh-my-posh"
check-exist "~/.poshtheme.omp.json" "oh-my-posh config" "-r"
check-exist "tmux"
check-exist "git"
check-exist "emacs"
check-exist "terraform"
check-exist "setxkbmap"
check-exist "chezmoi"
check-exist "gcloud"
check-exist 'bash completion' '/usr/share/bash-completion/bash_completion' '-r'
check-exist 'CodeNewRoman Nerd Font' '~/.local/share/fonts/NF_CodeNewRoman' '-d'
check-exist 'FiraCode Nerd Font' '~/.local/share/fonts/NF_FiraCode' '-d'
check-exist '~/bin' "~/bin" '-d' '(Optional)'
check-exist '~/.local/bin' "~/.local/bin" '-d' '(Optional)'
echo ""
