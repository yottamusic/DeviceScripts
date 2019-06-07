#!/bin/bash

function poke {
    while true
    do
        #printf '\n'
        sleep 1
        if [ -f /dev/shm/done ]; then
          return
        fi
    done
}

function watch {
    (poke) | wpa_cli | while read line
    do
        #echo $line
        case "$line" in
            *'4-Way Handshake failed'*)
                #echo "incorrect key"
                touch /dev/shm/done
                return 0
            ;;
            *'CTRL-EVENT-CONNECTED'*)
                #echo "connected"
                touch /dev/shm/done
                return 1
            ;;
        esac
    done
}

if [ -f /dev/shm/done ]; then
  rm /dev/shm/done
fi

watch

exit $?