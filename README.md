# Fidenma

**Fi**lecoin **de**velopment **n**etwork **ma**nager

A collection of scripts and tools to create, start, and manage connections to Filecoin networks, specifically designed for developers.

## WARNING

**THIS REPO IS A WORK IN PROGRESS. DO NOT USE IF YOU VALUE YOUR TIME AND/OR SANITY.**

---

## What is this?

Filecoin has several networks, including, but not limited to:

- Mainnet
- Calibration testnet
- Hyperspace testnet
- Wallaby testnet
- Local testnet

Lotus is the most popular node implementation for the Filecoin network. Due to how Lotus manages it's connections, each binary must be built for a specific network. Because of that, it can be a bit tedious to build and rebuild binaries every time you need to change networks. This repository aims to help developers switch between testnets and spin up local networks as needed, without having to manually build and install specific Lotus binaries.

## Features

- [ ] Quickly run a local testnet.
- [ ] Run a lite-node connected to the Hyperspace testnet.
- [ ] Run a lite-node connected to Mainnet.

See the [Todo list](#todo) for upcoming features.

## Limitations

As per the warning at the top of this readme, this repository is still in the very early stages of development. Do not trust it -- it will break stuff.

Currently, the scripts in this repository have only been tested against Ubuntu 22.04. Other Debian-like systems are also likely supported, however we can't guarentee anything. MacOS is not yet supported.

## Prerequisites

- [Go 1.18.0 or higher](https://go.dev/).
- [Rust 1.67.0 or higher](https://www.rust-lang.org/).
- [Git](https://git-scm.com/)

## Install

1. Clone this repo:

    ```shell
    git clone https://github.com/johnnymatthews/fidenma
    ```

1. Move into the `fidenma` directory:

    ```shell
    cd fidenma
    ```

1. Make the scripts executable:

    ```shell
    chmod +x lofite.sh
    ```

1. You're good to go!

## Usage

Call the name of the script you want to run, followed by a function within that script.

```shell
./lofite.sh <FUNCTION>
```

You can run `<script> show_help` to see which functions are available. For example:

```shell
./lofite.sh show_help
```

## Functions

| Name | Description | Permissions |
| ---- | ----------- | ----------- |
| `create_daemon` | Creates the Filecoin `lotus` daemon binary. Does not start the daemon. | None. |
| `create_miner` | Craetes the Filecoin `lotus-miner` binary. Does not start the miner. | None. |
| `start_daemon` | Starts the `lotus` daemon. `create_daemon` must be run before this function can be called. | None. |
| `start_miner` | Starts the `lotus-miner` process. `create_miner` must be run before this function can be called. | None. |
| `delete_everything` | Deletes everything Lotus related from your system. Use with caution. | Requires root. |

## Example

```shell
./lofite.sh create_daemon
```

## Todo

- [ ] MacOS support.
- [ ] Windows subsystem for Linux support.
