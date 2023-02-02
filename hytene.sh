#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "=============================================================="
    echo "ERROR: You need to supply a function when calling this script:"
    echo "Run './hytene.sh show_help' to get help."
    echo "=============================================================="
    exit 1
fi



create_daemon () {
    echo "Creating daemon..."


    echo "Daemon created and ready."
}

start_daemon () {
    echo "Starting daemon..."

 
    echo "Daemon stopped."
}

delete_everything () {
    echo "Deleting everything..."


    # Check if running as root.
    if (( $EUID != 0 )); then
        echo "ERROR: you must run this function as root."
        exit
    fi

    rm -rf ~/.lotus
    rm -rf ~/.lotusminer
    rm -rf ~/.genesis-sectors
    rm -rf ./lotus
    rm -rf /usr/local/bin/lotus
    rm -rf /usr/local/bin/lotus-miner
    rm -rf /usr/local/bin/lotus-worker

    echo "All instances of Lotus have been deleted."
}

show_help () {
    echo "Hytene: spin up a lite-node connected to Hyperspace."
    echo "A collection of functions to create and maintain a local Filecoin lite-node that is connected to the Filecoin Hyperspace testnet."
    echo " "
    echo "USAGE:"
    echo "./hytene.sh <FUNCTION>"
    echo " "
    echo "FUNCTIONS:"
    echo "create_daemon - creates the Filecoin daemon."
    echo "start_daemon - starts the daemon. createDaemon must be ran before this."
    echo "delete_everything: deletes everything Lotus related. Requires root."
    echo " "
    echo "EXAMPLE:"
    echo "./hytene.sh create_daemon"
    echo " "
}

"$@"
