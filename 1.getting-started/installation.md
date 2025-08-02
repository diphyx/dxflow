---
title: Download & Installation
description: Install dxflow engine on Linux, macOS, and Windows with simple step-by-step instructions
weight: 2
---

# Download & Installation

dxflow is a cross-platform tool, which means it can run on any operating system, such as Linux, macOS, and Windows. It is designed to be easy to install and use, with a simple command-line interface (CLI) and a web-based user interface (UI).

## Download

The first step is to install the dxflow engine. You can do this by downloading the latest release from the [GitHub releases page](https://github.com/diphyx/dxflow-docs/releases).

Here are the links to the latest releases for each platform:

### x86

::card-group
  ::card{title="Linux" icon="i-devicon:linux" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_linux_amd64.tar.gz"}
  ::

  ::card{title="macOS" icon="i-devicon:apple" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_darwin_amd64.tar.gz"}
  ::

  ::card{title="Windows" icon="i-devicon:windows8" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_windows_amd64.tar.gz"}
  ::
::

### ARM64

::card-group
  ::card{title="Linux" icon="i-devicon:linux" color="teal" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_linux_arm64.tar.gz"}
  ::

  ::card{title="macOS" icon="i-devicon:apple" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_darwin_arm64.tar.gz"}
  ::

  ::card{title="Windows" icon="i-devicon:windows8" to="https://github.com/diphyx/dxflow-docs/releases/download/v1.0.1/dxflow_1.0.1_windows_arm64.tar.gz"}
  ::
::

## Installation Steps

::tabs
  ::tab-item{label="Linux" icon="i-devicon:linux"}
    ::steps
      ### Step 1
      Unzip the downloaded file to `/usr/local/bin` or any directory in your `PATH`. For example, on Linux, you can use the following command:

      ```bash
      tar -xvf dxflow_1.0.1_linux_amd64.tar.gz -C /usr/local/bin
      ```

      ### Step 2
      Grant execute permissions with:

      ```bash
      chmod +x /usr/local/bin/dxflow
      ```
    ::
  ::

  ::tab-item{label="MacOS" icon="i-devicon:apple"}
    ::steps
      ### Step 1
      Unzip the downloaded file to `/usr/local/bin` or any directory in your `PATH`. For example, on macOS, you can use the following command:

      ```bash
      tar -xvf dxflow_1.0.1_darwin_amd64.tar.gz -C /usr/local/bin
      ```

      ### Step 2
      Grant execute permissions with:

      ```bash
      chmod +x /usr/local/bin/dxflow
      ```

      ### Step 3
      Verify installation:
      - Open a new terminal and run:
        ```bash
        dxflow --version
        ```
      - Open `System Settings`, then `Privacy & Security`
      - In the `Security` section, click the `Open Anyway`
      - Click `Open` to allow the application to run
    ::
  ::

  ::tab-item{label="Windows" icon="i-devicon:windows8"}
    ::steps
      ### Step 1
      Unzip the downloaded file to `C:\Program Files\diphyx` directory

      ### Step 2
      Open environment variables:
      1. Press `Win + X`, select System, then Advanced system settings.
      2. Click `Environment Variables`.
      3. Edit `PATH`.
      4. Select `Path` in System variables, click Edit.
      5. Click New, add `C:\Program Files\diphyx`, and click OK.
    ::
  ::
::

## Easy Installation - Only for Linux and macOS

Copy and paste the following command in your terminal to install dxflow engine automatically. This script will download the latest release and install it for you.

```bash
wget -qO- https://raw.githubusercontent.com/diphyx/dxflow-docs/main/getting-started/installation/install.sh | sudo bash -s dxflow
```
