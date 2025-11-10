---
title: dxflow Hub
description: Curated catalog of production-ready workflows for scientific computing, data science, and engineering applications
---

The dxflow Hub is a curated catalog of production-ready workflows and applications. Each workflow is provided as a Docker Compose configuration optimized for deployment on dxflow infrastructure.

::callout{color="green"}
**Deploy in Seconds**: All workflows are ready to deploy with a single command through the dxflow CLI or web interface.
::

## Workflow Categories

Browse workflows organized by scientific and engineering domains:

::card-group
  ::card{title="Genomics" to="/hub/genomics" icon="i-hugeicons:dna-01"}
  **DNA & RNA Analysis**

  Tools for sequencing data analysis, quality control, genome assembly, and variant calling.

  **Example workflows**: FastQC, GATK, STAR, Salmon
  ::

  ::card{title="Molecular" to="/hub/molecular" icon="i-hugeicons:atom-01"}
  **Molecular Simulations**

  Simulation engines for studying molecular behavior, protein dynamics, and material properties.

  **Example workflows**: GROMACS, Amber, LAMMPS, NAMD
  ::

  ::card{title="Structural" to="/hub/structural" icon="i-hugeicons:cube"}
  **3D Structure Analysis**

  Cryo-EM processing, structure prediction, and molecular modeling tools.

  **Example workflows**: Scipion, RELION, AlphaFold, PyMOL
  ::

  ::card{title="Data Science" to="/hub/data-science" icon="i-hugeicons:analytics-01"}
  **Analysis & Development**

  Interactive computing environments for data analysis, visualization, and machine learning.

  **Example workflows**: Jupyter Lab, RStudio, VS Code Server
  ::

  ::card{title="Fluid Flow" to="/hub/fluid-flow" icon="i-hugeicons:chart-column"}
  **Computational Fluid Dynamics**

  CFD solvers for aerodynamics, heat transfer, and multiphase flow analysis.

  **Example workflows**: OpenFOAM, SU2, ParaView
  ::
::

## How Workflows Work

Each workflow in the hub includes:

::card-group
  ::card{title="Docker Compose File" icon="i-hugeicons:package"}
  Complete containerized application stack with all dependencies configured and ready to deploy.
  ::

  ::card{title="Configuration Guide" icon="i-hugeicons:settings-01"}
  Documentation covering setup, environment variables, volume mounts, and resource requirements.
  ::

  ::card{title="Usage Examples" icon="i-hugeicons:book-01"}
  Practical examples showing how to run the workflow, process data, and retrieve results.
  ::

  ::card{title="Best Practices" icon="i-hugeicons:checkmark-square-02"}
  Optimization tips, troubleshooting guides, and performance tuning recommendations.
  ::
::

## Quick Start

### Deploy from Web Interface

1. Navigate to **Apps & Pipelines** in the dxflow interface
2. Click **Browse Hub** or **Templates**
3. Select a workflow from the category
4. Configure parameters and resource limits
5. Click **Deploy**

### Deploy from CLI

```bash
# List available workflows in a category
ls hub/<category-name>/

# Deploy a workflow
dxflow compose create --identity my-workflow hub/<category>/<workflow>.yml

# Start the workflow
dxflow compose start my-workflow

# Monitor progress
dxflow compose logs my-workflow

# Check status
dxflow compose list
```

## Workflow Structure

Each workflow file follows this structure:

```yaml
# Standard Docker Compose format
version: '3.8'

services:
  app:
    image: <workflow-image>
    container_name: <workflow-name>

    # Environment configuration
    environment:
      - PARAM1=value1
      - PARAM2=value2

    # Volume mounts for data
    volumes:
      - ./data:/data
      - ./results:/results

    # Port mappings
    ports:
      - "8080:8080"

    # Resource limits
    deploy:
      resources:
        limits:
          cpus: '4'
          memory: 8G
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## System Requirements

Requirements vary by workflow. General guidelines:

::tabs
  ::tab-item{label="Light Workloads"}
  **Interactive Tools & Development**
  - CPU: 2-4 cores
  - RAM: 4-8GB
  - Storage: 20-50GB
  - Examples: Jupyter, VS Code, small datasets
  ::

  ::tab-item{label="Standard Workloads"}
  **Data Analysis & Simulations**
  - CPU: 8-16 cores
  - RAM: 16-64GB
  - Storage: 100-500GB SSD
  - Examples: RNA-Seq, MD simulations, CFD
  ::

  ::tab-item{label="Heavy Workloads"}
  **Large-Scale Computing**
  - CPU: 16+ cores or HPC cluster
  - RAM: 64GB+ per node
  - GPU: NVIDIA Tesla/RTX for GPU workflows
  - Storage: 1TB+ NVMe or parallel filesystem
  - Examples: Cryo-EM, large MD, LES simulations
  ::
::

## Contributing Workflows

Want to share your workflow with the community?

::steps
### Step 1: Prepare Your Workflow

Create a Docker Compose configuration that:
- Uses published container images
- Includes clear documentation
- Follows Docker best practices
- Has been tested on multiple systems

### Step 2: Write Documentation

Document your workflow including:
- Overview and use cases
- System requirements
- Setup and configuration instructions
- Usage examples
- Troubleshooting tips

### Step 3: Submit

Submit your workflow via GitHub pull request:
1. Fork the dxflow repository
2. Add your workflow file to the appropriate category
3. Include documentation in markdown format
4. Submit pull request with clear description

### Step 4: Review

The dxflow team will:
- Review your workflow configuration
- Test on reference systems
- Provide feedback and suggestions
- Merge after approval
::

## Quality Standards

All hub workflows meet these standards:

- ✅ **Production-Ready**: Tested and validated on multiple platforms
- ✅ **Well-Documented**: Complete setup and usage instructions
- ✅ **Best Practices**: Follows Docker and security best practices
- ✅ **Reproducible**: Consistent results across deployments
- ✅ **Maintained**: Regularly updated with new versions

## Popular Workflows

::tabs
  ::tab-item{label="Most Used"}
  **Top workflows by deployment count:**
  - Jupyter Lab - Interactive data science environment
  - GROMACS - Molecular dynamics simulation
  - FastQC - Sequencing quality control
  - OpenFOAM - Computational fluid dynamics
  - RStudio - Statistical computing platform
  ::

  ::tab-item{label="Recently Added"}
  **Latest additions to the hub:**
  - Check the hub categories for new workflows
  - Star the repository to get notifications
  - Follow release announcements
  ::

  ::tab-item{label="Coming Soon"}
  **Workflows in development:**
  - Machine learning frameworks (TensorFlow, PyTorch)
  - Quantum chemistry tools
  - Advanced visualization platforms
  - Specialized bioinformatics pipelines
  ::
::

## Support

::callout
Need help deploying a workflow or want to suggest improvements? We're here to help!
::

**Get Support:**
- Browse workflow documentation in each category
- Check troubleshooting sections in workflow guides
- Report issues via [GitHub Issues](https://github.com/diphyx/dxflow/issues)
- Community forum for discussions and best practices

**For Workflow Authors:**
- Contribution guidelines in repository
- Template workflow for reference
- Testing and validation checklist
- Community review process

---

Browse the categories above to discover workflows for your research and engineering projects!
