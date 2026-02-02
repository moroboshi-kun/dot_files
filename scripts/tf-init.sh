#!/usr/bin/env bash

set -euo pipefail

TEMPLATE_DIR="/home/mike/Templates/terraform-bootstrap"

FILES=(
  main.tf
  outputs.tf
  providers.tf
  variables.tf
  versions.tf
)

for file in "${FILES[@]}"; do
  if [[ -e "$file" ]]; then
    echo "⚠️  Skipping $file (already exists)"
  else
    cp "$TEMPLATE_DIR/$file" .
    echo "✅ Created $file"
  fi
done

