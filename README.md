# Manage a local Filecoin testnet

## WARNING

**THIS REPO IS A WORK IN PROGRESS. DO NOT USE IF YOU VALUE YOUR TIME AND/OR SANITY.**

---

A collection of scripts to create, start, and manage a local Filecoin testnet.

## Usage

```shell
./setup-local-filecoin-testnet.sh <FUNCTION>
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
./setup-local-filecoin-testnet.sh create_daemon
```
