# Technical Context

## Technology Stack

### Core ML/AI Technologies
<!-- Deep learning and ML frameworks -->
- **PyTorch**: 2.0+ for model development and training
- **Transformers**: Hugging Face library for NLP models
- **Datasets**: Hugging Face library for dataset loading and processing
- **dspy**: Prompt engineering and LLM orchestration

### Data Processing
<!-- Libraries for data manipulation -->
- **Polars**: Primary choice for high-performance data processing
- **Pandas**: Legacy support and ecosystem compatibility
- **NumPy**: Numerical computing
- **SciPy**: Scientific computing
- **scikit-learn**: Traditional ML algorithms and utilities

### Visualization
<!-- Tools for plotting and analysis -->
- **Plotnine**: ggplot-style declarative plotting
- **Seaborn**: Statistical visualization
- **Matplotlib**: Base plotting library

### Cloud & Infrastructure
<!-- Cloud services and APIs -->
- **AWS Bedrock**: Via boto3 for managed LLM access
- **Environment Management**: python-dotenv for configuration

### Optional Technologies
<!-- Conditionally used based on requirements -->
- **vLLM**: GPU-accelerated local inference (Linux + NVIDIA GPU only)
- **Jupyter**: Interactive development and notebooks
- **pytest**: Testing framework

## Development Environment

### Python Version
- **Minimum**: Python 3.12+
- **Recommended**: Latest stable Python 3.12.x

### Package Management
- **Tool**: uv (fast Rust-based Python package installer)
- **Lock File**: uv.lock (committed for reproducibility)
- **Virtual Environment**: Managed automatically by uv

### Dependency Installation
```bash
# Base dependencies
uv sync

# With development tools
uv sync --extra dev

# With GPU inference (Linux only)
uv sync --extra gpu

# All extras
uv sync --all-extras
```

### Running Scripts
```bash
# Always use uv run to ensure correct environment
uv run python script_name.py
```

## Development Tools

### Code Quality
- **Formatter**: ruff format (black-compatible)
- **Linter**: ruff check (includes import sorting)
- **Type Checking**: Type hints recommended, checker optional

### Testing
- **Framework**: pytest
- **Test Location**: `test/` directory
- **Command**: `uv run pytest`

### Notebooks
- **Tool**: Jupyter Lab/Notebook
- **Kernel**: ipykernel
- **Location**: `notebook/` directory with symlink to `src/`

## Project Structure Standards

### Directory Conventions
```
src/              # Reusable package logic
data/             # Datasets (gitignored)
log/              # Logs and TensorBoard files
checkpoint/       # Model weights and artifacts
notebook/         # Jupyter notebooks (has src symlink)
config/           # YAML configuration files
bash_script/      # Shell scripts
python_script/    # Standalone scripts (has src symlink)
test/             # Unit and integration tests
memory_bank/      # Project documentation
```

### Import Strategy
- **Symlinks**: `notebook/src` and `python_script/src` point to `../src`
- **Import Style**: Absolute imports from root (e.g., `from src.models import Model`)
- **Why**: Enables consistent imports across notebooks and scripts

## Technical Constraints

### Hardware Requirements
<!-- Minimum and recommended specs -->
- **CPU**: Multi-core recommended for data processing
- **RAM**: 16GB minimum, 32GB+ recommended for large models
- **GPU**: Optional but recommended for training
  - NVIDIA GPU with CUDA support for PyTorch
  - Sufficient VRAM (8GB+ for small models, 16GB+ for larger)

### Software Constraints
<!-- OS and environment limitations -->
- **OS**: Cross-platform (macOS, Linux, Windows)
- **GPU Inference**: vLLM requires Linux + NVIDIA GPU
- **Shell**: Bash-compatible shell for scripts

### Performance Considerations
<!-- Performance-related requirements -->
- **Memory Management**: Use `del` for large objects, monitor with `psutil`
- **GPU Memory**: Set `gpu_memory_utilization=0.8` or lower in vLLM
- **Batch Processing**: Process data in chunks for large datasets
- **Progress Tracking**: Use `tqdm.auto` for all loops

## Configuration Management

### Configuration Files
- **Format**: YAML only (stored in `config/`)
- **Main Config**: `config/main.yaml` for project-wide settings
- **Local Overrides**: `config/local_*.yaml` (gitignored)

### Environment Variables
- **Sensitive Data**: Store in `.env` (never commit)
- **Loading**: Use `python-dotenv` or `os.getenv()`
- **Examples**: API keys, AWS credentials, database URLs

### Secrets Management
```bash
# .env file structure (example)
AWS_ACCESS_KEY_ID=your_key
AWS_SECRET_ACCESS_KEY=your_secret
AWS_DEFAULT_REGION=your_region
OPENAI_API_KEY=your_api_key
```

## Tool Usage Patterns

### Data Processing
- **Prefer Polars** for performance-critical operations
- **Use Pandas** only for legacy compatibility or when libraries require it
- **NumPy/SciPy** for numerical computations

### Deep Learning
- **Set Seeds**: `torch.manual_seed()`, `torch.cuda.manual_seed_all()`
- **Device Management**: Explicit `.to(device)` calls
- **Memory**: `torch.cuda.empty_cache()` when needed

### Logging
- **Library**: Python's standard `logging`
- **Levels**: INFO for progress, DEBUG for tracing, ERROR for failures
- **Storage**: Save to `log/` directory

### Progress Tracking
- **Library**: `tqdm.auto` (works in notebooks and terminals)
- **Usage**: Wrap all loops processing large datasets

## External Dependencies

### API Integrations
<!-- External services the project connects to -->
- Service 1: [name, purpose, authentication method]
- Service 2: [name, purpose, authentication method]

### Model Registries
<!-- Where models are stored/loaded from -->
- Registry 1: [e.g., Hugging Face Hub, local, S3]
- Registry 2: [e.g., MLflow, custom storage]

### Data Sources
<!-- Where data comes from -->
- Source 1: [location, format, access method]
- Source 2: [location, format, access method]

## Reproducibility

### Random Seeding
```python
# Set in all entry-point scripts
import random
import numpy as np
import torch

seed = 42
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed_all(seed)
```

### Deterministic Operations
- Enable deterministic PyTorch operations when possible
- Document any sources of non-determinism

### Version Control
- Lock file committed for exact reproducibility
- Document Python version and key dependency versions
