# Install Postgres and pgvector on Mac

1. Install & Start PostgreSQL

Use Homebrew to install a specific version (like 16).

```
# Install
brew install postgresql@16

# Start the service
brew services start postgresql@16

# Add to PATH (so 'psql' works)
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

2. Install pgvector (From Source)

This method ensures the extension is installed into the exact directory your active Postgres version is using.

```
cd /tmp
git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git
cd pgvector

# Ensure it uses the correct pg_config
export PG_CONFIG=$(which pg_config)

# Compile and Install
make
make install
```

3. Enable Extension 

```
-- Enable pgvector
CREATE EXTENSION IF NOT EXISTS vector;
```