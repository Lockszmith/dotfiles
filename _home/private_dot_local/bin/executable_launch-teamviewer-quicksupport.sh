#! /usr/bin/env bash

set -e

### based on the code shared at https://community.teamviewer.com/English/discussion/comment/116988/#Comment_116988

clear
cat <<EOF
===================================================="
Latest TeamViewer QuickSupport Downloader & Launcher"
====================================================

Refreshing local versino fo TeamViewer QS

EOF
TVQS=${TVQS:-$1}
#RemoteFile=https://dl.teamviewer.com/download/linux/teamviewer_amd64.deb
#RemoteFile=https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#RemoteFile=https://download.teamviewer.com/download/version_11x/teamviewer_qs.tar.gz
# Prefer dl.teamviewer.com as it provides the `content-length` header
RemoteFile=https://dl.teamviewer.com/download/version_11x/teamviewer_qs.tar.gz
RemoteSize="$(curl -sI "$RemoteFile" | grep -i '^Content-Length:.*$' | awk '{sub("\r",""); print $2} ')"

LocalFile=~/Downloads/TeamViewerQS.tgz
if [ "${TVQS}" == "gal" ]; then
  RemoteFileCustom='https://customdesignservice.teamviewer.com/download/linux/v15/6fnv7gb/TeamViewerQS.tar.gz'
  RemoteSizeCustom="$(curl -sI "$RemoteFileCustom" | grep -i '^Content-Length:.*$' | awk '{sub("\r",""); print $2} ')"

  if [[ "$RemoteSize" -gt "0" ]]; then
    LocalFile=~/Downloads/TeamViewerQS-gal.tgz
    RemoteFile=$RemoteFileCustom
    RemoteSize=$RemoteSizeCustom
  fi
fi
LocalSize="$(wc -c "$LocalFile" 2>/dev/null | awk '{ print $1 }')"

if [[ ! -r "${LocalFile}" ]] || [ "$LocalSize" != "$RemoteSize" ]; then
  echo "Downloading file into $LocalFile..."
  curl -Lo "$LocalFile" "$RemoteFile"
else
  echo "$LocalFile exists and is same size as on server, using existing file..."
fi

rm -fR /tmp/tvqs 2>&1 > /dev/null
mkdir -p /tmp/tvqs
pushd /tmp/tvqs > /dev/null
tar xzf "$LocalFile"
cd teamviewerqs
echo "Launching TeamViewer Quick Support in the background from $PWD, it should startup in a few seconds..."
./teamviewer &
sleep 8
popd
printf "TeamViewer launched, you might want to hit <ENTER> if you don't see the prompt\n\n"
