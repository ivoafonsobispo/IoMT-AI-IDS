#!/bin/bash

# Color codes
RED="\e[0;31m"
BLUE="\e[0;94m"
BLUE_BG="\033[0;37;44m"
RED_BG="\033[0;37;41m"
GREEN_BG="\e[0;102m"
GREEN="\e[0;32m"
BROWN="\e[0;33m"
WHITE="\e[0;97m"
BOLD="\e[1m"
ULINE="\e[4m"
RESET="\e[0m"

VERSION="0.1.0"

help() {
    cat << "EOF"
   __  __      __  _ __  __         _________ ___
  / / / /___  / /_(_) /_/ /__  ____/ <  / __ \__ \
 / / / / __ \/ __/ / __/ / _ \/ __  // / /_/ /_/ /
/ /_/ / / / / /_/ / /_/ /  __/ /_/ // /\__, / __/
\____/_/ /_/\__/_/\__/_/\___/\__,_//_//____/____/

EOF

    echo -e "${GREEN}Untitled192${RESET} version ${BROWN}$VERSION${RESET} $(date +'%Y-%m-%d %H:%m:%S')"
    echo -e "\n${BROWN}Usage:${RESET}\n  untitled192 [options] [arguments]"
    echo -e "\n${BROWN}Options:${RESET}"
    echo -e "  ${GREEN}-h, --help${RESET}\t\t\t Display help for the given command. When no command is given display help for the ${GREEN}list${RESET} command"
    echo -e "  ${GREEN}-s, --start-servers${RESET}\t\t Start the CoAP and MQTT servers in background and writes for log files"
    echo -e "  ${GREEN}-x, --stop-servers${RESET}\t\t Stop the CoAP and MQTT servers killing their PID"
    echo -e "  ${GREEN}-p, --get-pids${RESET}\t\t Get PIDS from the services running in backgroud"
    echo -e "  ${GREEN}-c, --capture${RESET}\t\t\t Start a packet capture with tcpdump and prints the elapsed time"
    echo -e "\n${BROWN}Available commands:${RESET}"
    echo -e "  ${GREEN}about${RESET}\t\t\t\t Shows a short information about Untitled192"
    echo -e "  ${GREEN}list${RESET}\t\t\t\t List all the commands and usefull information"
}

about() {
    echo -e "${GREEN}Untitled192 - CoAP & MQTT Assistant - version $VERSION${RESET}"
    echo -e "${BROWN}Untitled192 is a tool designed to assist users to manage their CoAP and MQTT servers.${RESET}"
    echo -e "${BROWN}See https://github.com/ivoafonsobispo/IoMT-AI-IDS for more information."
}

if [[ ! -n "$1" ]]; then
    help
fi

# Default values
start_servers=false
stop_servers=false
start_capture=false
pids=false

# Log Files
mqtt_log="logs/mqtt.log"
coap_log="logs/coap.log"

# Process options
while [[ $# -gt 0 ]]; do
    case $1 in
        'about')
            about
            ;;
        'list')
            help
            ;;
        --help | -h)
            help
            ;;
        --start-servers | -s)
            start_servers=true
            ;;
        --stop-servers | -x)
            stop_servers=true
            ;;
        --get-pids | -p)
            pids=true
            ;;
        --capture | -c)
            start_capture=true
            ;;
        *)
            echo -e "\n  ${RED_BG} ERROR ${RESET} The option \"$1\" does not exist. \n" >&2 && exit 1
            ;;
    esac
    shift
done

if $start_capture; then
    if [ ! "$UID" -eq 0 ]; then
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
    fi

    tcpdump -i any -G 3600 -w /var/tmp/capture-%d%m%Y-%H%M%S.pcap > /dev/null 2>&1 &
    # tcpdump -w captures/capture_$(date +'%Y-%m-%d_%H:%M:%S').pcap > /dev/null 2>&1 &
    error_code=$?
    PID_TCPDUMP=$!

    if [ $error_code -ne 0  ]; then
        echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the capture. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
    else
        SECONDS=0
        echo -ne "\n"
        while kill -0 $PID_TCPDUMP 2>/dev/null; do
            TIMELAPSE=$(date -u -d @$SECONDS +%H:%M:%S)
            echo -ne "\r  ${BLUE_BG} INFO ${RESET} The capture was initialized with PID: $PID_TCPDUMP -- Time elapsed: $TIMELAPSE" >&2
            sleep 1
        done
	echo -ne "\n"
    fi
fi

if $start_servers; then
    # MQTT Server
    nohup mosquitto_sub -t '#' >> "$mqtt_log" 2>&1 &
    PID_MQTT=$!
    export PID_MQTT

    # CoAP Server
    nohup python3 -u coap-server/server.py >> "$coap_log" 2>&1 &
    PID_COAP=$!
    export PID_COAP

    echo -ne "\n  ${BLUE_BG} INFO ${RESET} CoAP & MQTT servers are running. Check the log files for more information." >&2 ; echo -ne '\n\n'
fi

if $stop_servers; then
    if [[ ! -z "${PID_MQTT}" && ! -z "${PID_COAP}" ]]; then
        kill -9 ${PID_MQTT} ; kill -9 ${PID_COAP}
        echo -ne "\n  ${BLUE_BG} INFO ${RESET} CoAP & MQTT servers were stopped with success." >&2 ; echo -ne '\n\n'
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} CoAP & MQTT servers are not running. Couldn't stop.\n" >&2 ; exit 1
    fi
fi

if $pids; then
    if [[ ! -z "${PID_MQTT}" && ! -z "${PID_COAP}" ]]; then
        echo -ne "\n  ${BLUE_BG} INFO ${RESET} CoAP Server PID: $PID_COAP / MQTT Server PID: $PID_MQTT" >&2 ; echo -ne '\n\n'
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} CoAP & MQTT servers are not running. Couldn't get PIDS.\n" >&2 ; exit 1
    fi
fi
