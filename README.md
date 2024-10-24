# dxflow

dxflow runner

## Usage

```bash
#!/bin/bash

# Set the following environment variables
export DXO_COMPUTE_UNIT_POINTER=
export DXO_COMPUTE_UNIT_EXTENSIONS=
export DXO_COMPUTE_UNIT_SECRET_KEY_RW=
export DXO_COMPUTE_UNIT_SECRET_KEY_RO=

# Run the command
curl -fsSL https://raw.githubusercontent.com/diphyx/dxflow/main/boot.sh | sh -s
```

# Environment Variables

## core/api

#### DXF_API_SECRET_KEY_RW

-   **Description:** Read-write secret key
-   **Default Value:** `dxf-rw`
-   **Available Values:** Any string

#### DXF_API_SECRET_KEY_RO

-   **Description:** Read-only secret key
-   **Default Value:** `dxf-ro`
-   **Available Values:** Any string

## ext/storage

#### DXF_STORAGE_SECRET_KEY_RW

-   **Description:** Read-write secret key
-   **Default Value:** `dxf-rw`
-   **Available Values:** Any string

#### DXF_STORAGE_SECRET_KEY_RO

-   **Description:** Read-only secret key
-   **Default Value:** `dxf-ro`
-   **Available Values:** Any string

## ext/sync

#### DXF_SYNC_SECRET_KEY_RW

-   **Description:** Read-write secret key
-   **Default Value:** `dxf-rw`
-   **Available Values:** Any string

#### DXF_SYNC_SECRET_KEY_RO

-   **Description:** Read-only secret key
-   **Default Value:** `dxf-ro`
-   **Available Values:** Any string

#### DXF_SYNC_MAX_OPS

-   **Description:** Maximum number of operations
-   **Default Value:** `2`
-   **Available Values:** Any integer between `1` and `8`

## ext/alarm

#### DXF_ALARM_SECRET_KEY_RW

-   **Description:** Read-write secret key
-   **Default Value:** `dxf-rw`
-   **Available Values:** Any string

#### DXF_ALARM_SECRET_KEY_RO

-   **Description:** Read-only secret key
-   **Default Value:** `dxf-ro`
-   **Available Values:** Any string

#### DXF_ALARM_COMPUTE_UNIT_POINTER

-   **Description:** Pointer to the compute unit
-   **Available Values:** Any string

#### DXF_ALARM_ENDPOINT

-   **Description:** Endpoint to send the alarm
-   **Default Value:** `https://diphyx.com/api/compute/units/{DXF_ALARM_COMPUTE_UNIT_POINTER}/alarm/`
-   **Available Values:** Any string

#### DXF_ALARM_IDLE_TIMEOUT

-   **Description:** Timeout for idle state
-   **Default Value:** `60`
-   **Available Values:** Any positive integer

## ext/proxy

#### DXF_PROXY_SECRET_KEY_RW

-   **Description:** Read-write secret key
-   **Default Value:** `dxf-rw`
-   **Available Values:** Any string

#### DXF_PROXY_SECRET_KEY_RO

-   **Description:** Read-only secret key
-   **Default Value:** `dxf-ro`
-   **Available Values:** Any string

#### DXF_PROXY_COMPUTE_UNIT_POINTER

-   **Description:** Pointer to the compute unit
-   **Available Values:** Any string

#### DXF_PROXY_EXTENSIONS

-   **Description:** Comma-separated list of enabled extensions
-   **Default Value:** `storage,sync,alarm,orchestrator`
-   **Available Values:** Comma-separated list of extensions (`storage`, `sync`, `alarm`, `orchestrator`)

#### DXF_PROXY_ASSETS_UPDATE

-   **Description:** Flag to enable or disable assets update on startup
-   **Default Value:** `true`
-   **Available Values:** `true`, `false`, `1`, `0`

#### DXF_PROXY_CERTIFICATE

-   **Description:** Mode of certificate handling
-   **Default Value:** `AUTO`
-   **Available Values:** `AUTO`, `MANUAL`

#### DXF_PROXY_CERTIFICATE_ENDPOINT

-   **Description:** Endpoint for retrieve certificates
-   **Default Value:** `https://diphyx.com/api/compute/units/{DXF_PROXY_COMPUTE_UNIT_POINTER}/certificates/`

#### DXF_PROXY_CERTIFICATE_RETRY

-   **Description:** Number of retries for certificate fetching
-   **Default Value:** `30`
-   **Available Values:** Any integer between `9` and `99`

#### DXF_PROXY_HTTPS

-   **Description:** Flag to enable or disable HTTPS
-   **Default Value:** `true`
-   **Available Values:** `true`, `false`, `1`, `0`
