#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt-get -y install --no-install-recommends "$@"
    fi
}

apt_get_update

# Check install requirements
if ! command -v curl > /dev/null 2>&1; then
    apt -y install curl
fi

if ! command -v unzip > /dev/null 2>&1; then
    apt -y install unzip
fi

# Install shell utilities

"$RIPGREP" == "true" && check_packages ripgrep
"$BAT" == "true" && check_packages bat
"$FD" == "true" && check_packages fd-find
"$FZF" == "true" && check_packages fzf
"$HEXYL" == "true" && check_packages hexyl
if "$EXA" == "true"
then
  EXA_VERSION=$(curl --silent "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
  curl --location --output /tmp/exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
  unzip -q /tmp/exa.zip bin/exa -d /usr/local
  rm /tmp/exa.zip
fi
if "$DELTA" == "true"
then
  DELTA_VERSION=$(curl --silent "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
  curl --location --output /tmp/delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
  dpkg -i /tmp/delta.deb
  rm -f /tmp/delta.deb
fi

if "$DIFFTASTIC" == "true"
then
  DIFFT_VERSION=$(curl --silent "https://api.github.com/repos/Wilfred/difftastic/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
  curl --location --output /tmp/difft.tgz "https://github.com/Wilfred/difftastic/releases/download/${DIFFT_VERSION}/difft-x86_64-unknown-linux-gnu.tar.gz"
  tar xvzf /tmp/difft.tgz -C /usr/local/bin
  rm -f /tmp/difft.tgz
fi
