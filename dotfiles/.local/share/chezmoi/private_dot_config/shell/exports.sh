#!/usr/bin/env sh

### XDG
# Source: # https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR=
{{- if eq .host.distro.family "darwin" -}}
  "$TMPDIR"
{{- else if not .host.headless -}}
  "/run/user/$(id -u)"
{{- else -}}
  "/tmp"
{{- end }}
{{- if not .host.headless }}
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
{{- end }}

### Theme
export COLOR_SCHEME=dark
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

{{- if eq .host.distro.family "linux" -}}
### Homebrew
if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
  export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
  export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
  export WHALEBREW_INSTALL_PATH="/home/linuxbrew/.linuxbrew/whalebrew"
fi

{{- end }}
### Android Studio
{{- if eq .host.distro.family "darwin" -}}
if [ -d ~/Library/Android ]; then
  export PATH="$PATH:~/Library/Android/sdk/cmdline-tools/latest/bin"
  export PATH="$PATH:~/Library/Android/sdk/platform-tools"
  export PATH="$PATH:~/Library/Android/sdk/tools/bin"
  export PATH="$PATH:~/Library/Android/sdk/tools"
fi
{{- end }}
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android-sdk"

### ASDF
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DIR="$XDG_DATA_HOME/asdf"
export ASDF_DATA_DIR="$ASDF_DIR"
export ASDF_CRATE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-cargo-pkgs"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-ruby-pkgs"
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-golang-pkgs"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-python-pkgs"

### AWS CLI
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"

### Azure CLI
export AZURE_CONFIG_DIR="$XDG_CONFIG_HOME/azure"

### bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/batrc"

### Cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$PATH:$CARGO_HOME/bin"

### Bash
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

### BitWarden
# https://bitwarden.com/help/cli/#using-an-api-key
# BW_CLIENTID	client_id
# BW_CLIENTSECRET

### Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"

### Elastic Agent
# https://www.elastic.co/guide/en/fleet/current/agent-environment-variables.html#env-common-vars

### ffmpeg
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"

### fzf
if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

### Git
export GIT_MERGE_AUTOEDIT=no

### gitfuzzy
if command -v delta > /dev/null; then
  export GF_BAT_STYLE=changes
  export GF_BAT_THEME=zenbur
  export GF_SNAPSHOT_DIRECTORY="$XDG_DATA_HOME/git-fuzzy-snapshots"
  export GF_PREFERRED_PAGER="delta --theme=gruvbox --highlight-removed -w __WIDTH__"
fi

### Go
export GOPATH="$XDG_DATA_HOME/go"
export GO111MODULE=on
export PATH="$PATH:${GOPATH}/bin"
if command -v go > /dev/null && which go | grep -q 'asdf' > /dev/null && command -v asdf > /dev/null; then
  GOROOT="$(asdf where golang)/go"
  export GOROOT
  export PATH="$PATH:${GOROOT}/bin"
elif command -v go > /dev/null && command -v brew > /dev/null; then
  GOROOT="$(brew --prefix go)/libexec"
  export GOROOT
  export PATH="$PATH:${GOROOT}/bin"
fi

### Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

### Homebrew
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/Brewfile"
{{- if (and (eq .host.distro.family "darwin") (.host.restricted)) }}
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
{{- end }}

### HTTPie
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

### IPFS
export IPFS_PATH="$XDG_DATA_HOME/ipfs"

### Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

### k9s
export K9SCONFIG="$XDG_CONFIG_HOME/k9s"

### KDE
export KDEHOME="$XDG_CONFIG_HOME/kde"

### Kodi
export KODI_DATA="$XDG_DATA_HOME/kodi"

### McFly
export MCFLY_FUZZY=2
export MCFLY_RESULTS=14
export MCFLY_KEY_SCHEME=vim

### minikube
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"

### MySQL
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

### nnn
if command -v nnn > /dev/null; then
  alias n='nnn -de'
  alias N='sudo -E nnn -dH'
  alias nnn-install-plugins='curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh'
  export NNN_RCLONE='rclone mount --read-only --no-checksum'
  export NNN_SSHFS='sshfs -o reconnect,idmap=user,cache_timeout=3600'
fi

### Node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

### NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

### Parallels
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

### Pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

### Poetry
export POETRY_HOME="$XDG_DATA_HOME/poetry"
export PATH="$POETRY_HOME/bin:$PATH"

### Postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

### Readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

### Rear
# https://github.com/rear/rear/blob/master/doc/user-guide/03-configuration.adoc

### Redis
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history"
export REDISCLI_RCFILE="$XDG_CONFIG_HOME/redis/redisclirc"

### ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

### Ruby
export GEM_HOME="$XDG_DATA_HOME/gems"
export PATH="$PATH:$GEM_HOME/bin"

### Rustup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

### SDKMan
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"

### Vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant.d"

### Volta
export VOLTA_HOME="$XDG_DATA_HOME/volta"
export PATH="$VOLTA_HOME/bin:$PATH"

### wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

### Whalebrew
export WHALEBREW_CONFIG_DIR="$XDG_CONFIG_HOME/whalebrew"

### Man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-
export MANPAGER="less -X"

### Line Wrap
setterm -linewrap on 2>/dev/null

### History
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HIST_STAMPS=mm/dd/yyyy
export SAVEHIST=5000

### Editor
{{- if not .host.headless }}
if command -v code > /dev/null; then
  export EDITOR='code --wait'
else
  # Source: https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
  export EDITOR='vi -e'
fi
{{- else -}}
export EDITOR='vi -e'
{{- end -}}
export VISUAL="$EDITOR"

{{- if eq .host.type "wsl" }}
### WSL
export LIBGL_ALWAYS_INDIRECT="1"
export BROWSER='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'

{{- end }}
### PATH
export PATH="$PATH:$HOME/.local/bin"
