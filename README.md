# dxflow Engine

A powerful distributed computing engine that transforms any accessible machine into a first-class member of your computational fleet.

[![License](https://img.shields.io/badge/License-Free%20until%202030-green)](5.advanced/02.licensing.md)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-blue)]()
[![Architecture](https://img.shields.io/badge/Arch-x86__64%20%7C%20ARM64-blue)]()

## Overview

dxflow provides a unified interface for orchestrating workflows across different computing environments with enterprise-grade security and scalability. Originally developed at [DiPhyX](https://diphyx.com) for scientific computing, it has evolved into a production-grade engine for any distributed computing need.

### Key Features

- **Universal Deployment** - Deploy on any infrastructure: cloud VMs, GPU nodes, HPC clusters, or laptops
- **Unified Interface** - Consistent CLI, REST API, and web UI across all environments
- **Container Orchestration** - Native Docker Compose integration with real-time monitoring
- **Secure by Design** - RSA key-pair authentication with fine-grained access control
- **Real-time Monitoring** - Live logs, metrics, and workflow status tracking
- **Multi-Scheduler Support** - Works with Docker, Kubernetes, Slurm, and other schedulers
- **Secure Tunneling** - Expose services through authenticated WebSocket bridges

## Quick Start

### Installation

**🚀 Quick Install (Linux/macOS):**

```bash
wget -qO- https://raw.githubusercontent.com/diphyx/dxflow/main/assets/install.sh | sudo bash
```

**📦 Manual Installation:**

1. Download the latest release for your platform:

    ```bash
    # Visit https://github.com/diphyx/dxflow/releases
    # Or use curl for latest version:
    curl -L -o dxflow.tar.gz "https://github.com/diphyx/dxflow/releases/latest/download/dxflow-$(uname -s)-$(uname -m).tar.gz"
    ```

2. Extract and install:

    ```bash
    tar -xzf dxflow.tar.gz
    sudo mv dxflow /usr/local/bin/
    chmod +x /usr/local/bin/dxflow
    ```

3. Verify installation:
    ```bash
    dxflow --version
    dxflow --help
    ```

### Get Started in 30 Seconds

```bash
# Start the dxflow engine
dxflow boot up

# Access the web interface
open http://localhost

# Check engine status
dxflow engine ping

# Get system information
dxflow engine info
```

## Architecture

dxflow operates as a lightweight 4-layer architecture that integrates seamlessly with existing infrastructure:

```
┌─────────────────────────────┐
│    Your Applications        │  ← Run workloads unchanged
├─────────────────────────────┤
│    Native Schedulers        │  ← Docker, K8s, Slurm, PBS
├─────────────────────────────┤
│      dxflow Engine          │  ← Unified access layer
├─────────────────────────────┤
│   Your Infrastructure       │  ← Any compute resource
└─────────────────────────────┘
```

**Deployment Patterns:**

- **Single Node**: All-in-one development and testing
- **Hub-Node**: Centralized control with distributed execution
- **Federated**: Multiple interconnected dxflow instances
- **Bridge Mode**: Secure tunneling for remote access

## Use Cases

### 🔬 Scientific Research

- **Computational Chemistry**: GROMACS, Quantum ESPRESSO, custom solvers
- **Bioinformatics**: Genomics pipelines, protein folding simulations
- **Physics**: CFD simulations, materials science modeling
- **Machine Learning**: Multi-GPU training, distributed inference

### 💼 Enterprise & DevOps

- **Data Processing**: Large-scale ETL and analytics pipelines
- **CI/CD**: Distributed testing and deployment workflows
- **Edge Computing**: IoT data processing and edge-to-cloud workflows
- **Development**: Multi-environment testing and staging

### 🎓 Academic & Research Institutions

- **Course Labs**: Consistent computational environments for students
- **Research Groups**: Shared access to GPU clusters and HPC resources
- **Collaboration**: Multi-institutional research projects

## Documentation

Comprehensive documentation is available in the following sections:

### 📚 Core Documentation

- **[Getting Started](1.getting-started/00.index.md)** - Installation and first steps
- **[User Interface](2.interface/00.index.md)** - Web-based management console
- **[CLI Reference](3.cli/000.index.md)** - Command-line interface guide
- **[API Documentation](4.api/000.index.md)** - REST API integration

### 🎯 Advanced Topics

- **[Advanced Concepts](5.advanced/00.index.md)** - Architecture and deployment patterns
- **[Licensing](5.advanced/02.licensing.md)** - License management and permissions
- **[Boot Configuration](5.advanced/03.boot.md)** - Engine startup and daemon modes
- **[Authentication](5.advanced/04.auth.md)** - Security and access control
- **[Streaming](5.advanced/05.streaming.md)** - Real-time data and event handling
- **[Tunneling](5.advanced/06.tunneling.md)** - Secure proxy and bridge connections

### ❓ Help & Support

- **[FAQs](6.faqs/00.index.md)** - Common questions and solutions

## System Requirements

### Minimum Requirements

- **OS**: Linux (any distribution), macOS 10.14+, Windows 10+
- **Architecture**: x86_64 (AMD64) or ARM64
- **Memory**: 512MB RAM
- **Storage**: 100MB disk space
- **Network**: Internet connection for installation

### Recommended Requirements

- **Memory**: 2GB+ RAM for production workloads
- **Storage**: 1GB+ for logs and temporary files
- **Network**: Stable connection for distributed deployments

### Platform Support

| Platform    | Status          | Notes                              |
| ----------- | --------------- | ---------------------------------- |
| **Linux**   | ✅ Full Support | All distributions, containers, HPC |
| **macOS**   | ✅ Full Support | Intel and Apple Silicon            |
| **Windows** | ✅ Full Support | Native and WSL2                    |

## Licensing

dxflow includes a **General License** that provides:

- ✅ **Free until 2030** - No cost for core functionality
- ✅ **Full Feature Access** - All core modules included
- ✅ **No Registration Required** - Start using immediately
- ✅ **Production Ready** - No limitations for real workloads

For advanced features like bridge connections or custom licensing, see the [licensing documentation](5.advanced/02.licensing.md).

## Getting Help

### 🆘 Support Channels

- **Documentation**: Start with our comprehensive guides above
- **Issues**: [GitHub Issues](https://github.com/diphyx/dxflow/issues) for bugs and feature requests
- **Direct Support**: [info@diphyx.com](mailto:info@diphyx.com) for enterprise needs

### 📞 Enterprise Contact

- **Email**: [info@diphyx.com](mailto:info@diphyx.com)
- **Schedule Call**: [Book 30-minute consultation](https://calendly.com/diphyx/30min)
- **Phone**: +1 (619) 693-6161
- **Website**: [diphyx.com](https://diphyx.com)

## About DiPhyX

dxflow is developed by [DiPhyX](https://diphyx.com), a company founded by scientists with over 20 years of combined experience on national supercomputers and more than 50 published papers. We understand the challenges of computational research and build tools to accelerate scientific discovery.

### Our Mission

To accelerate scientific innovation by providing unified, scalable, and intuitive computing platforms for end-to-end computational pipelines.

### Our Approach

- **Scientific-First**: Built for real research needs, not just enterprise IT
- **No Vendor Lock-in**: Runs on your existing infrastructure
- **Researcher-Friendly**: Designed by scientists who understand computational workflows
