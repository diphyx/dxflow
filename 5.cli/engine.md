---
title:
description:
draft: true
---

# `dxflow engine`

The `dxflow engine` command provides comprehensive tools for managing the engine, including boot control, health checks, authorized key management, pinging the engine, and generating tokens. Below is a detailed breakdown of each subcommand and its options.

---

## dxflow Engine Management

### Synopsis
Engine management commands for `dxflow`.

### Options
- **help** (`-h`): Displays help information for the engine command. Default: `false`.

### Inherited Options
- **config-profile** (`-C`): Specifies the configuration profile to use. Default: `default`.
- **log-level** (`-L`): Sets the log level. Options: `debug`, `error`, `disabled`. Default: `disabled`.
- **no-color** (`-N`): Disables color output. Default: `false`.

### See Also
- `dxflow engine boot`: Engine boot control.
- `dxflow engine healthcheck`: Check the engine health.
- `dxflow engine key`: Authorized key control.
- `dxflow engine ping`: Send ping to the engine.
- `dxflow engine token`: Generate authorized token.

---

## `dxflow engine Boot`

### Synopsis
Controls the boot state of the engine.

### Options
- **help** (`-h`): Displays help information for the boot command. Default: `false`.

## `dxflow engine healthcheck`

### Synopsis
Checks the health of the engine.

### Usage
`dxflow engine healthcheck [flags]`

### Options
- **help** (`-h`): Displays help information for the healthcheck command. Default: `false`.

## `dxflow engine key`

### Synopsis
Manages authorized keys for the engine.

### Options
- **help** (`-h`): Displays help information for the key command. Default: `false`.

---

## `dxflow engine ping`

### Synopsis
Sends a ping to the engine.

### Usage
`dxflow engine ping [flags]`

### Options
- **count** (`-c`): Specifies the number of pings to send. Default: `3`.
- **help** (`-h`): Displays help information for the ping command. Default: `false`.

---

## `dxflow engine token`

### Synopsis
Generates an authorized token for the engine.

### Usage
`dxflow engine token [flags]`

### Options
- **help** (`-h`): Displays help information for the token command. Default: `false`.

---
