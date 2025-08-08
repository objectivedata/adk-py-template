# Python 3.13 Development Container

This repository contains a VS Code development container configuration for Python 3.13 with essential tools and extensions.

## Features

### Base Environment

- **Python 3.13** (latest version)
- **Git** for version control
- **Zsh** with Oh My Zsh configuration
- Common development utilities

### Python Tools & Extensions

- **Python Extension Pack** - Complete Python development support
- **Pylance** - Advanced Python language server
- **Black** - Code formatter
- **Flake8** - Linting
- **isort** - Import sorting
- **Ruff** - Fast Python linter
- **Jupyter** - Notebook support

### Additional Tools Installed via setup.sh

- **uv** - Modern Python package installer and project manager
- **Google Cloud CLI** - Command-line interface for Google Cloud Platform
- **Google Cloud ADK** - Application Development Kit with emulators and additional components

### VS Code Extensions Included

- Python development tools (Python, Pylance, formatters, linters)
- Jupyter notebook support
- Git integration (GitLens, GitHub PR extension)
- JSON and YAML support
- Makefile tools
- Remote container support

## Quick Start

1. **Open in VS Code**: Make sure you have the "Remote - Containers" extension installed
2. **Reopen in Container**: VS Code will prompt you to reopen the folder in a container
3. **Wait for Setup**: The `setup.sh` script will run automatically after container creation
4. **Start Developing**: All tools will be ready to use!

## Using the Tools

### uv (Python Package Manager)

```bash
# Initialize a new project
uv init

# Add dependencies
uv add requests fastapi

# Add development dependencies
uv add --dev pytest black

# Run commands in the virtual environment
uv run python main.py
uv run pytest

# Sync dependencies
uv sync
```

### Google Cloud CLI

```bash
# Authenticate
gcloud auth login

# Set default project
gcloud config set project YOUR_PROJECT_ID

# List projects
gcloud projects list

# Check configuration
gcloud config list
```

### Python Development

The container comes with Python 3.13 and common development tools pre-configured:

- Automatic code formatting with Black
- Linting with Flake8 and Ruff
- Import sorting with isort
- Type checking with Pylance

## Port Forwarding

The following ports are automatically forwarded:

- `8000` - Common for FastAPI/Django development servers
- `8080` - Alternative web server port
- `5000` - Common for Flask applications

## File Structure

```bash
.devcontainer/
├── devcontainer.json    # Main container configuration
└── setup.sh           # Post-creation setup script
```

## Customization

### Adding More Extensions

Edit `.devcontainer/devcontainer.json` and add extension IDs to the `extensions` array.

### Installing Additional Tools

Modify `.devcontainer/setup.sh` to include additional package installations.

### Changing Python Version

Update the `image` field in `devcontainer.json` to use a different Python version tag.

## Troubleshooting

### Setup Script Issues

If the setup script fails, you can run it manually:

```bash
bash .devcontainer/setup.sh
```

### Missing Tools

If tools like `uv` are not in PATH, restart your terminal or run:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

### Google Cloud Authentication

For Google Cloud services, you may need to authenticate:

```bash
gcloud auth login
gcloud auth application-default login
```

## Development Workflow

1. **Initialize Project**: Use `uv init` to create a new Python project
2. **Add Dependencies**: Use `uv add` to manage packages
3. **Code**: Write your Python code with full IDE support
4. **Test**: Run tests with `uv run pytest`
5. **Deploy**: Use Google Cloud CLI for deployment to GCP

## Notes

- The container mounts your local `.gitconfig` and `.ssh` directories for seamless Git operations
- All Python packages are managed through `uv` for better dependency resolution
- Google Cloud emulators are available for local development and testing
