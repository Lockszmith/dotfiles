#! /usr/bin/env bash

_SIZE=${1:-128}
_PATTERN=${2:-*.svg}
_ONERROR=${3:-break}

[[ -z "$(env inkscape 2> /dev/null)" && -n "$(flatpak info org.inkscape.Inkscape 2> /dev/null)" ]] && function inkscape() {
  flatpak run org.inkscape.Inkscape "${@}"
}

type inkscape > /dev/null 2>&1 || exit 1

mkdir -p ../png$_SIZE > /dev/null

echo "Creating ${_SIZE}px icons from ${_PATTERN}..."
for i in $_PATTERN; do
  n=${i/\.svg/}
  echo "Processing $n..."
  INKOUT=$(inkscape -w $_SIZE -h $_SIZE $i -o ../png$_SIZE/$n.png 2>&1) || {
    echo $INKOUT
    eval $_ONERROR
  }
done
echo "done."
