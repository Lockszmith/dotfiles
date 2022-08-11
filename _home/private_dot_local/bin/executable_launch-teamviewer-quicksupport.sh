#! /usr/bin/env bash

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
LocalFile=~/Downloads/TeamViewerQS.tgz
if [ "${TVQS}" == "gal" ]; then
  RemoteFile='https://customdesignservice.teamviewer.com/download/linux/v15/6fnv7gb/TeamViewerQS.tar.gz' # ?sv=2020-04-08&se=2022-08-11T19%3A34%3A09Z&sr=b&sp=r&sig=b2cQfGcmepA5re6sfBZTg3UODGCFVP3Duvdg9IBw9Wg%3D'
  LocalFile=~/Downloads/TeamViewerQS-gal.tgz
fi
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
echo "Launching TeamViewer Quick Support in the background from $PWD, it should startup in a few seconds..."
./teamviewer &
sleep 8
popd
printf "TeamViewer launched, you might want to hit <ENTER> if you don't see the prompt\n\n"
