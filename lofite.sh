#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "=============================================================="
    echo "ERROR: You need to supply a function when calling this script:"
    echo "Run './lofite show_help' to get help."
    echo "=============================================================="
    exit 1
fi



create_daemon () {
    echo "Creating daemon..."

    # Set environment variables for this terminal window.
    export LOTUS_PATH=~/.lotus export LOTUS_MINER_PATH=~/.lotusminer
    export LOTUS_SKIP_GENESIS_CHECK=_yes_
    export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
    export CGO_CFLAGS="-D__BLST_PORTABLE__"

    # Remove all Lotus stuff from your system.
    rm -rf ~/.lotus && rm -rf ~/.lotusminer && rm -rf ~/.genesis-sectors && rm -rf ~/lotus

    # Clone Lotus
    git clone https://github.com/filecoin-project/lotus
    cd lotus
    git checkout ntwk/hyperspace

    # Make devnet
    make debug && sudo make install

    # Setup genesis and start the Lotus daemon.
    ./lotus-seed pre-seal --sector-size 2KiB --num-sectors 2 && ./lotus-seed genesis new localnet.json && ./lotus-seed genesis add-miner localnet.json ~/.genesis-sectors/pre-seal-t01000.json

    echo "Daemon created and ready."
}

create_miner () {
    echo "Creating miner..."

    # Move into the Lotus folder that was created in create_daemon.
    cd ./lotus

    # Set environment variables for this terminal window.
    export LOTUS_PATH=~/.lotus
    export LOTUS_MINER_PATH=~/.lotusminer
    export LOTUS_SKIP_GENESIS_CHECK=_yes_
    export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
    export CGO_CFLAGS="-D__BLST_PORTABLE__"

    # Move into the cloned Lotus git repo.
    cd ~/lotus

    # Initalize a devnet with wallets, presealed sectors, and a miner.
    ./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key && ./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync

    echo "Miner created and ready."
}

start_daemon () {
    echo "Starting daemon..."

    # Move into the Lotus folder that was created in create_daemon.
    cd ./lotus

    # Restart the daemon.
    ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false
 
    echo "Daemon stopped."
}

start_miner () {
    echo "Starting miner..."

    # Move into the Lotus folder that was created in create_daemon.
    cd ./lotus

    # Start the miner.
    ./lotus-miner run --nosync

    echo "Miner stopped."
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
    echo "Lofite: setup a local Filecoin testnet."
    echo "A collection of functions to create and maintain a local Filecoin testnet."
    echo " "
    echo "USAGE:"
    echo "./lofite.sh <FUNCTION>"
    echo " "
    echo "FUNCTIONS:"
    echo "create_daemon - creates the Filecoin daemon."
    echo "create_miner - creates the Filecoin miner."
    echo "start_daemon - starts the daemon. createDaemon must be ran before this."
    echo "start_miner - starts the miner. createMiner must be ran before this."
    echo "delete_everything: deletes everything Lotus related. Requires root."
    echo " "
    echo "EXAMPLE:"
    echo "./lofite.sh create_daemon"
    echo " "
}

"$@"
