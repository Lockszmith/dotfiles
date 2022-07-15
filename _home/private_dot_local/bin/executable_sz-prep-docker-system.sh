#! /usr/bin/env bash
. ~/.sz.shrc.d/01_util.functions

require_root

if [[ ! -r "/etc/apt/sources.list.d/download.docker.com.list" ]]; then
    error "Docker sources are not installed yet, please run 'sz-add-my-apt-repos' script first"
    exit 1
fi

[[ -z "$(getent group szdocker)" ]] \
    && groupadd --gid 2001 szdocker
[[ -z "$(getent passwd szdocker)" ]] \
    && useradd --gid szdocker --uid 2001 szdocker
[[ -z "$(type -fP docker)" ]] \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes docker-ce docker-ce-cli containerd.io docker-compose-plugin \
    && printf "\n\ndocker installed\n\n"
CUR_USER=$USER
[[ -n "$SUDO_USER" ]] \
    && CUR_USER=$SUDO_USER
echo $CUR_USER
sudo usermod --groups docker,szdocker --append $CUR_USER
sudo usermod --groups docker          --append szdocker

if [[ ! -x /usr/local/bin/compose-switch ]]; then
    curl -fL https://raw.githubusercontent.com/docker/compose-switch/master/install_on_linux.sh | sh
    update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/compose-switch 99
fi

CTSZ_ROOT=/srv/containeriszed
[[ -n "${SZ_DEBUG}" ]] \
    && echo "Creating $CTSZ_ROOT/docker-compose/0.template.off..."
mkdir -p $CTSZ_ROOT/docker-compose/0.template.off
[[ -n "${SZ_DEBUG}" ]] \
    && echo "Creating $CTSZ_ROOT/0.local/0.shared..."
mkdir -p $CTSZ_ROOT/0.local/0.shared

setacl -R szdocker:szdocker 775 $CTSZ_ROOT

[[ -n "${SZ_DEBUG}" ]] \
    && echo "Creating $CTSZ_ROOT/docker-compose/.env..."
touch $CTSZ_ROOT/docker-compose/.env
pushd $CTSZ_ROOT/docker-compose/0.template.off > /dev/null
[[ -r ".env" ]] || ln -s ../.env . 
chown szdocker:szdocker $CTSZ_ROOT/docker-compose/0.template.off/.env
setacl '' szdocker:szdocker 660 $CTSZ_ROOT/docker-compose/.env
popd > /dev/null
[[ -n "${SZ_DEBUG}" ]] \
    && echo "Template created with .env as a symbloiv link"

[[ -n "type tree" ]] \
    && echo "Containerized Directory Tree initialized:" \
    && tree -Fapug --dirsfirst --noreport $CTSZ_ROOT
