#! /usr/bin/env bash

function print-result() {
  printf "%-30s: %-8s %s \n" "$1" "$2" "$3"
}
function check-exist() {
  _TEST_RESULT='Missing'
  _TEST_NAME=$1
  _TEST_PATH=${2:-$(type -fP $_TEST_NAME | head -1 2>/dev/null)}
  [[ -n "$_TEST_PATH" ]] && eval "[[ ${3:--x} ${_TEST_PATH// /\\ } ]]" && _TEST_RESULT='Found'
  print-result "$_TEST_NAME" "$_TEST_RESULT" "${4}"
}

echo "Shell: $SHELL"
echo ""

#_ALT_EDITOR=$( update-alternatives --get-selections | grep '^editor' | sed 's:^editor\W\+\w\+\W\+/:/:' )
_ALT_EDITOR=$( update-alternatives --query editor | grep '^Value:' | cut -d: -f2 | sed 's: *\(.*\) *:\1:g' )
print-result "System prefered editor" "$_ALT_EDITOR"
( echo $_ALT_EDITOR | grep "nano$" >/dev/null ) && echo "Recommended to run: update-alternatives --set editor $(type -fP nvim vim.basic vim.tiny vi | head -1)"
echo "editors found:"
update-alternatives --query editor | grep Alternative: | cut -d: -f2
echo ""

check-exist "Byobu" "/usr/bin/byobu-launch"
check-exist "oh-my-posh"
check-exist "~/.poshtheme.omp.json" "~/.poshtheme.omp.json" "-r"
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
