cd $(dirname "$1")
urxvt -name urxvt_scratchpad -hold -e aunpack "$@" -X "${@%.*}"
