#!/usr/bin/env bash

set -euo pipefail # strict mode, crash when error

# keep origional state (optional)
# original_state=$(ifconfig awdl0 | grep -q "<UP" && echo "up" || echo "down")

# recover awdl0 when exit
trap 'cleanup' EXIT

cleanup() {
    # keep origional state
    # if [[ "$original_state" == "up" ]]; then
    #     ifconfig awdl0 up
    # else
    #     ifconfig awdl0 down
    # fi
    
    # always up awdl0
    # if ifconfig awdl0 | grep -q "<DOWN"; then
    #     (set -x; ifconfig awdl0 up)
    # fi
    set -x; ifconfig awdl0 up
}

get_frontmost_app() {
    osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true'
}

while true; do
    # if pgrep -x Moonlight >/dev/null; then
    #     # awdl0 down when mooonlight on
    #     if ifconfig awdl0 | grep -q "<UP"; then
    #         (set -x; ifconfig awdl0 down)
    #     fi
    # else
    #     # else case
    #     if ifconfig awdl0 | grep -q "<DOWN"; then
    #         (set -x; ifconfig awdl0 up)
    #     fi
    # fi

    current_app=$(get_frontmost_app) || current_app="null" # in case error
    
    {
        if [[ "$current_app" == "Moonlight" ]]; then
            # moonlight at frontstage: awdl0 off

            # if ifconfig awdl0 | grep -q "<UP"; then
            if ifconfig awdl0 | grep -q "status: active"; then
                (set -x; ifconfig awdl0 down)
            fi
            sleep 2  # could be modified
        else
            # if ifconfig awdl0 | grep -q "<DOWN"; then
            if ifconfig awdl0 | grep -q "status: inactive"; then
                (set -x; ifconfig awdl0 up)
            fi
            sleep 10  # could be modified
        fi
    } || sleep 10 # capture error, in case when launched before network init.
    # note: the status of awdl0 is checked by the return of ifconfig.

done