# `dxflow fs`

The `dxflow fs` command provides a suite of subcommands to manage filesystem objects. You can create, delete, download, list, rename, share, unzip, upload, and zip filesystem objects.

---

## dxflow File System Management

### Synopsis
Filesystem management commands for `dxflow fs`.

### Usage
dxflow fs <COMMAND> [flags]

### Inherited Options
- **config-profile** (`-C`): Specifies the config profile. Default: `default`.
- **log-level** (`-L`): Sets the log level. Options: `debug`, `error`, `disabled`. Default: `disabled`.
- **no-color** (`-N`): Disables color output. Default: `false`.

---

## `dxflow fs create`

### Synopsis
Create a filesystem object.

### Usage
dxflow fs create <IDENTITY> [flags]

### Options
- **directory** (`-d`): Make a directory. Default: `false`.
- **force** (`-f`): Force creation if the object already exists. Default: `false`.
- **help** (`-h`): Displays help information for the create command. Default: `false`.

---

## `dxflow fs delete`

### Synopsis
Delete a filesystem object.

### Usage
dxflow fs delete <IDENTITY> [flags]

### Options
- **help** (`-h`): Displays help information for the delete command. Default: `false`.

---

## `dxflow fs download`

### Synopsis
Download a filesystem object.

### Usage
dxflow fs download <IDENTITY> [DESTINATION] [flags]

### Options
- **force** (`-f`): Force creation if the object already exists. Default: `false`.
- **help** (`-h`): Displays help information for the download command. Default: `false`.

---

## `dxflow fs list`

### Synopsis
List filesystem objects.

### Usage
dxflow fs list [DIRECTORY] [flags]

### Options
- **all** (`-a`): Include hidden objects. Default: `false`.
- **depth** (`-d`): Depth of subdirectories to include. Default: `0`.
- **pattern** (`-p`): Pattern to filter objects.
- **help** (`-h`): Displays help information for the list command. Default: `false`.

---

## `dxflow fs rename`

### Synopsis
Rename a filesystem object.

### Usage
dxflow fs rename <IDENTITY> <NEW_IDENTITY> [flags]

### Options
- **help** (`-h`): Displays help information for the rename command. Default: `false`.

---

## `dxflow fs share`

### Synopsis
Share a filesystem object.

### Usage
dxflow fs share <IDENTITY> [flags]

### Options
- **lifetime** (`-l`): Lifetime of the share. Default: `5m`.
- **writable** (`-w`): Mark as writable object. Default: `false`.
- **help** (`-h`): Displays help information for the share command. Default: `false`.

---

## `dxflow fs unzip`

### Synopsis
Unzip a filesystem object.

### Usage
dxflow fs unzip <IDENTITY> [flags]

### Options
- **quiet** (`-q`): Suppress progress output. Default: `false`.
- **help** (`-h`): Displays help information for the unzip command. Default: `false`.

---

## `dxflow fs upload`

### Synopsis
Upload a filesystem object.

### Usage
dxflow fs upload <SOURCE> [IDENTITY] [flags]

### Options
- **force** (`-f`): Force creation if the object already exists. Default: `false`.
- **help** (`-h`): Displays help information for the upload command. Default: `false`.

---

## `dxflow fs zip`

### Synopsis
Zip a filesystem object.

### Usage
dxflow fs zip <IDENTITY> [flags]

### Options
- **quiet** (`-q`): Suppress progress output. Default: `false`.
- **help** (`-h`): Displays help information for the zip command. Default: `false`.
