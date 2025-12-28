# ML Project Blueprint

A standardized template for machine learning projects with pre-configured dependencies and best practices.

## Quick Start

### 1. Initialize the project structure
```bash
bash bash_script/setup_structure.sh
```

This will create all necessary directories and symlinks.

### 2. Install dependencies
```bash
uv sync
```

This will install all dependencies defined in `pyproject.toml`.

### 3. Install optional dependencies

**Development tools (cross-platform):**
```bash
uv sync --extra dev
```
This includes ruff, pytest, jupyter, and ipykernel.

**GPU inference (Linux with NVIDIA GPU only):**
```bash
uv sync --extra gpu
```
This includes vLLM for high-performance local inference.

**All optional dependencies:**
```bash
uv sync --all-extras
```

## Project Structure

```
.
├── src/              # Reusable package logic, models, utilities
├── data/             # Datasets (gitignored)
├── log/              # Text logs and TensorBoard files
├── checkpoint/       # Model weights and artifacts
├── notebook/         # Jupyter notebooks (has symlink to src/)
├── config/           # YAML configuration files
├── bash_script/      # Shell scripts for automation
├── python_script/    # Standalone execution scripts (has symlink to src/)
├── memory_bank/      # Project documentation for AI-assisted development
└── pyproject.toml    # Dependencies and tool configuration
```

## Key Dependencies

### Deep Learning
- PyTorch 2.0+
- Hugging Face Transformers & Datasets
- dspy for prompt engineering

### Optional: GPU Inference
- vLLM (Linux with NVIDIA GPU only - install with `--extra gpu`)

### Data Processing
- Polars (preferred)
- Pandas (legacy support)
- NumPy, SciPy, scikit-learn

### Visualization
- Plotnine (ggplot style)
- Seaborn

### Cloud & Environment
- Boto3 (AWS Bedrock)
- python-dotenv

## Running Scripts

Always use `uv run` to execute Python scripts:

```bash
uv run python python_script/train.py
uv run python src/models/model.py
```

## Configuration

- Store sensitive data (API keys) in `.env` files
- Store non-sensitive settings in `config/*.yaml`
- Never commit `.env` to git

## Code Quality

Format and lint your code:
```bash
uv run ruff format .
uv run ruff check .
```

Run tests:
```bash
uv run pytest
```

## Memory Bank

The `memory_bank/` directory maintains structured project documentation for AI-assisted development. This helps AI assistants (like Cline) understand project context across sessions.

### Core Documentation Files

When using AI assistance, maintain these files in `memory_bank/`:

- **`projectbrief.md`** - Foundation document defining core requirements and project scope
- **`productContext.md`** - Why the project exists, problems it solves, user experience goals
- **`activeContext.md`** - Current work focus, recent changes, next steps, and active decisions
- **`systemPatterns.md`** - System architecture, design patterns, component relationships
- **`techContext.md`** - Technologies used, development setup, technical constraints
- **`progress.md`** - What works, what's left to build, current status, known issues

### When to Update

Update Memory Bank files when:
- Starting a new feature or significant change
- Discovering important project patterns
- Making architectural decisions
- Before/after major milestones
- When context needs clarification for future work

See `memory_bank/custom_instruction.md` for detailed guidelines.

## Best Practices

See `.clinerules` for detailed coding standards including:
- Directory structure conventions
- Import patterns
- Docstring style (Google format)
- Performance monitoring
- Reproducibility guidelines
