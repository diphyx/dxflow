# dxflow Engine

A powerful distributed computing engine that transforms any accessible machine into a first-class member of your computational fleet.

## Overview

dxflow provides a unified interface for orchestrating workflows across different computing environments with enterprise-grade security and scalability.

### Key Features

- **Universal Deployment** - Deploy on any infrastructure: cloud VMs, GPU nodes, on-premise clusters, or laptops
- **Unified Interface** - Consistent CLI, REST API, and web UI across all environments
- **Container Orchestration** - Native Docker Compose integration with real-time monitoring
- **Secure by Design** - RSA key-pair authentication with fine-grained access control
- **Real-time Monitoring** - Live logs, metrics, and workflow status tracking
- **Multi-Scheduler Support** - Works with Docker, Kubernetes, Slurm, and other schedulers

## Quick Start

### Installation

**Linux/macOS (Quick Install):**
```bash
wget -qO- https://raw.githubusercontent.com/diphyx/dxflow/main/assets/install.sh | sudo bash
```

**Manual Installation:**

1. Download the latest release for your platform from [GitHub releases](https://github.com/diphyx/dxflow/releases)
2. Extract to `/usr/local/bin` (or any directory in your PATH)
3. Make executable: `chmod +x /usr/local/bin/dxflow`

**Verify Installation:**
```bash
dxflow --version
dxflow --help
```

### Basic Usage

```bash
# Start the dxflow engine
dxflow boot up

# Check engine status
dxflow engine ping
```

## Architecture

dxflow operates as a lightweight 4-layer architecture:

```
┌─────────────────────┐
│  Your Applications  │  ← Run workloads unchanged
├─────────────────────┤
│  Native Schedulers  │  ← Docker, Kubernetes, Slurm
├─────────────────────┤
│   dxflow Engine     │  ← Unified access layer
├─────────────────────┤
│ Your Infrastructure │  ← Any compute resource
└─────────────────────┘
```

## Use Cases

- **Data Science** - Multi-GPU ML training and data processing pipelines
- **Research Computing** - HPC simulations and bioinformatics workflows
- **DevOps** - Distributed testing and container orchestration
- **Edge Computing** - IoT processing and edge-to-cloud workflows

## Documentation

- **[Getting Started](1.getting-started/00.index.md)** - Learn the basics and installation
- **[User Interface](2.interface/00.index.md)** - Explore the web-based interface
- **[CLI Reference](3.cli/000.index.md)** - Master the command-line interface
- **[API Documentation](4.api/000.index.md)** - Integrate via REST API
- **[FAQs](5.faqs/00.index.md)** - Common questions and solutions

## System Requirements

**Minimum Requirements:**
- **OS**: Linux, macOS, or Windows
- **Architecture**: x86_64 (AMD64) or ARM64
- **Memory**: 512MB RAM
- **Storage**: 100MB disk space
- **Network**: Internet connection for installation

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/diphyx/dxflow/issues)
- **Documentation**: [Full Documentation](index.md)
- **Discussions**: [GitHub Discussions](https://github.com/diphyx/dxflow/discussions)

## About DiPhyx

dxflow is developed by [DiPhyx](https://diphyx.com), providing enterprise-grade distributed computing solutions.

---

**Transform any machine into a computational powerhouse with dxflow**
