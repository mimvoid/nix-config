export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export _Z_DATA="$XDG_DATA_HOME/z"

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1

export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python

export MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository
export MAVEN_ARGS="--settings $XDG_CONFIG_HOME/maven/settings.xml"
export RUFF_CACHE_DIR=$XDG_CACHE_HOME/ruff

export XCOMPOSEFILE="$XDG_CONFIG_HOME"/x11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/x11/xcompose
export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
