#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH="${PATH}:${HOME}/.i3"
PATH="${PATH}:${HOME}/.local/bin"

LC_COLLATE="zh_CN.UTF-8"

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

export XDG_CACHE_HOME=/tmp/.cache-${USER}
if [ ! -d "${XDG_CACHE_HOME}" ]; then
    mkdir "${XDG_CACHE_HOME}"
    chmod 0700 "${XDG_CACHE_HOME}"
fi

    # Atuostart X
    # systemd
    #if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
        #exec startx
    #fi

    # openrc start i3 on tty7
    # [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx -- vt7

    # startkde on tty2
    # if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]]; then exec startx /usr/bin/startkde vt8; fi

#    startx
