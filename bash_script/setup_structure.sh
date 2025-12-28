#!/bin/bash

# Exit on error
set -e

echo "�� Initializing ML project structure..."

# 1. Define singular directory names
directories=(
    "src"
    "data"
    "log"
    "checkpoint"
    "notebook"
    "config"
    "bash_script"
    "python_script"
)

# 2. Create directories and add .gitkeep to ensure they are tracked by git
for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        touch "$dir/.gitkeep"
        echo "  [+] Created $dir/"
    else
        echo "  [!] $dir/ already exists, skipping..."
    fi
done

# 3. Create Symbolic Links for internal imports
# Link src into notebook/ and python_script/
echo "🔗 Creating symbolic links for 'src'..."

# Function to create symlink safely
create_link() {
    local target="../src"
    local link_name="$1/src"
    
    if [ ! -L "$link_name" ]; then
        ln -s "$target" "$link_name"
        echo "  [+] Linked $link_name -> $target"
    else
        echo "  [!] Symlink $link_name already exists, skipping..."
    fi
}

create_link "notebook"
create_link "python_script"

# 4. Create an initial dummy config if it doesn't exist
if [ ! -f "config/main.yaml" ]; then
    cat <<EOT >> config/main.yaml
# Project Configuration
project_name: "ml_project"
random_seed: 42
paths:
  data: "data/"
  logs: "log/"
  checkpoints: "checkpoint/"
EOT
    echo "  [+] Created default config/main.yaml"
fi

echo "✅ Setup complete!"
echo "Note: Run 'uv init' if you haven't already to initialize the pyproject.toml."
