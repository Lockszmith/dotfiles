#! /usr/bin/env bash

### based on the code shared at https://community.teamviewer.com/English/discussion/comment/116988/#Comment_116988

clear
cat <<EOF
===================================================="
Latest TeamViewer QuickSupport Downloader & Launcher"
====================================================

Refreshing local versino fo TeamViewer QS

EOF
#RemoteFile=https://dl.teamviewer.com/download/linux/teamviewer_amd64.deb
#RemoteFile=https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#RemoteFile=https://download.teamviewer.com/download/version_11x/teamviewer_qs.tar.gz
# Prefer dl.teamviewer.com as it provides the `content-length` header
RemoteFile=https://dl.teamviewer.com/download/version_11x/teamviewer_qs.tar.gz
LocalFile=~/Downloads/TeamViewerQS.tgz

LocalSize=$(wc -c "$LocalFile" 2>/dev/null | awk '{ print $1 }')
RemoteSize=$(curl -sI "$RemoteFile" | awk -v IGNORECASE=1 '/^Content-Length/ {sub("\r",""); print $2}')
if [ "$LocalSize" != "$RemoteSize" ]; then
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
echo "Launching TeamViewer Quick Support from $PWD, it should startup in a few seconds..."
./teamviewer &
popd

