---
title:
description:
draft: true
---

# dxflow key

The `dxflow key` command provides a suite of subcommands to manage authentication keys. A key is a 2048-bit RSA key-pair used for authenticating with the dxflow engine. Each key is bound to an identity (similar to a username) and can be assigned one or more permissions (`read`, `write`, `execute`, `admin`).

---

## dxflow Key Management

### Synopsis
Authentication key management commands for `dxflow key`.

### Usage
dxflow key <COMMAND> [flags]

### Inherited Options
- **config-profile** (`-C`): Specifies the config profile. Default: `default`.
- **log-level** (`-L`): Sets the log level. Options: `debug`, `error`, `disabled`. Default: `disabled`.
- **no-color** (`-N`): Disables color output. Default: `false`.

---

## `dxflow key list`

### Synopsis
List authorized keys.

### Usage
dxflow key list [flags]

### Options
- **all** (`-a`): Include disabled keys. Default: `false`.
- **help** (`-h`): Displays help information for the list command. Default: `false`.

---

## `dxflow key register`

### Synopsis
Register an authorized key.

### Usage
dxflow key register <KEY> [flags]

### Key Details
- `<KEY>`: A 2048-bit RSA key-pair used for authentication.
- **key identity** (`-i`): Arbitrary value that uniquely identifies the key (similar to a username).
- **permissions** (`-p`): Assign one or more permissions. Valid values: `read`, `write`, `execute`, `admin`. Default: `[]`.

### Options
- **help** (`-h`): Displays help information for the register command. Default: `false`.

---

## `dxflow key unregister`

### Synopsis
Unregister an authorized key.

### Usage
dxflow key unregister <IDENTITY> [flags]

### Options
- **help** (`-h`): Displays help information for the unregister command. Default: `false`.
