#!/bin/bash

set -e

echo "🚀 Starting post-create setup..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update

# Install additional system dependencies
echo "🔧 Installing system dependencies..."
sudo apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Install uv (Python package installer)
echo "🐍 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.cargo/bin:$PATH"

# Install Google Cloud CLI
echo "☁️ Installing Google Cloud CLI..."
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update
sudo apt-get install -y google-cloud-cli

# Install Google Cloud ADK (Application Default Credentials and additional tools)
echo "🔑 Installing Google Cloud ADK components..."
sudo apt-get install -y \
    google-cloud-cli-app-engine-python \
    google-cloud-cli-app-engine-python-extras \
    google-cloud-cli-bigtable-emulator \
    google-cloud-cli-datastore-emulator \
    google-cloud-cli-firestore-emulator \
    google-cloud-cli-pubsub-emulator

# Create virtual environment and install google-adk
echo "🐍 Creating virtual environment and installing google-adk..."
# Get the workspace directory dynamically
WORKSPACE_DIR=$(pwd | sed 's|/.devcontainer||')
cd "$WORKSPACE_DIR"

# Create virtual environment using uv
echo "Creating virtual environment..."
uv venv

# Activate the virtual environment and install google-adk
echo "Installing google-adk..."
uv pip install google-adk

echo "✅ Virtual environment created and google-adk installed successfully!"

# Verify installations
echo "✅ Verifying installations..."

# Check Python version
echo "Python version:"
python3 --version

# Check uv installation
echo "uv version:"
if command -v uv &> /dev/null; then
    uv --version
else
    echo "uv not found in PATH, but installed in ~/.cargo/bin/"
    ~/.cargo/bin/uv --version
fi

# Check gcloud installation
echo "Google Cloud CLI version:"
gcloud version

# Check google-adk installation
echo "google-adk installation:"
if uv pip show google-adk &> /dev/null; then
    echo "✅ google-adk is installed"
    uv pip show google-adk | grep Version
else
    echo "❌ google-adk is not installed"
fi

# Set up some useful aliases
echo "🔧 Setting up aliases..."
cat >> ~/.bashrc << 'EOF'

# Python aliases
alias python=python3
alias pip=pip3

# uv aliases
alias uv-init='uv init'
alias uv-add='uv add'
alias uv-run='uv run'
alias uv-sync='uv sync'

# Google Cloud aliases
alias gcauth='gcloud auth login'
alias gcconfig='gcloud config list'
alias gcprojects='gcloud projects list'
EOF

cat >> ~/.zshrc << 'EOF'

# Python aliases
alias python=python3
alias pip=pip3

# uv aliases
alias uv-init='uv init'
alias uv-add='uv add'
alias uv-run='uv run'
alias uv-sync='uv sync'

# Google Cloud aliases
alias gcauth='gcloud auth login'
alias gcconfig='gcloud config list'
alias gcprojects='gcloud projects list'
EOF

# Create a sample requirements file
echo "📝 Creating sample files..."
cat > "$WORKSPACE_DIR/requirements.txt" << 'EOF'
# Add your Python dependencies here
# Example:
# requests>=2.31.0
# fastapi>=0.104.0
# uvicorn>=0.24.0
EOF

# Create a sample pyproject.toml for uv
cat > "$WORKSPACE_DIR/pyproject.toml" << 'EOF'
[project]
name = "template"
version = "0.1.0"
description = "Template project"
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]
dependencies = []
requires-python = ">=3.13"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv]
dev-dependencies = [
    "pytest>=7.4.0",
    "black>=23.0.0",
    "flake8>=6.0.0",
    "isort>=5.12.0",
]
EOF

# Create a sample .gitignore
cat > "$WORKSPACE_DIR/.gitignore" << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
Pipfile.lock

# PEP 582
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# Google Cloud
.gcloud/
service-account-key.json
*-key.json

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db
EOF



echo "🎉 Post-create setup completed successfully!"
echo ""
echo "📚 Quick start guide:"
echo "  - Virtual environment is already created in .venv/"
echo "  - Use 'source .venv/bin/activate' to activate the virtual environment"
echo "  - Use 'uv pip install <package>' to add more dependencies"
echo "  - Use 'uv run <command>' to run commands in the virtual environment"
echo "  - Use 'gcloud auth login' to authenticate with Google Cloud"
echo "  - Use 'gcloud config set project <PROJECT_ID>' to set your default project"
echo ""
echo "🔧 Tools installed:"
echo "  - Python $(python3 --version)"
echo "  - uv (Python package manager)"
echo "  - Virtual environment (.venv/)"
echo "  - google-adk Python package"
echo "  - Google Cloud CLI with ADK components"
echo "  - Git and common development tools"
