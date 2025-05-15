#!/bin/bash

set -e

# Check for an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <project-directory-name>"
  exit 1
fi

PROJECT_NAME="$1"
BASE_DIR="$(pwd)/$PROJECT_NAME"

# Create base structure
mkdir -p "$BASE_DIR"/{inventories/dev/group_vars,host_vars,playbooks,roles,files,templates}

# Create ansible.cfg
cat > "$BASE_DIR/ansible.cfg" <<EOF
[defaults]
inventory = inventories/dev/hosts
roles_path = roles
host_key_checking = False
retry_files_enabled = False
EOF

# Root README
cat > "$BASE_DIR/README.md" <<EOF
# $PROJECT_NAME

Basic Ansible project scaffold.
EOF

# Sample inventory file
cat > "$BASE_DIR/inventories/dev/hosts" <<EOF
[web]
web1.example.com
web2.example.com

[db]
db1.example.com
EOF

# Sample group_vars
cat > "$BASE_DIR/inventories/dev/group_vars/all.yml" <<EOF
---
ansible_user: ubuntu
timezone: UTC
EOF

cat > "$BASE_DIR/inventories/dev/group_vars/web.yml" <<EOF
---
nginx_port: 80
web_app_root: /var/www/html
EOF

cat > "$BASE_DIR/inventories/dev/group_vars/db.yml" <<EOF
---
db_port: 5432
db_engine: postgresql
EOF

# Sample host_vars
cat > "$BASE_DIR/host_vars/web1.example.com.yml" <<EOF
---
nginx_port: 8080
hostname_override: "special-web1"
EOF

cat > "$BASE_DIR/host_vars/db1.example.com.yml" <<EOF
---
db_engine: mysql
EOF

# Sample playbook
mkdir -p "$BASE_DIR/playbooks"
cat > "$BASE_DIR/playbooks/site.yml" <<EOF
---
- name: Apply common configuration
  hosts: all
  become: true
  roles:
    - common
EOF

# .gitkeep in empty subdirs
touch "$BASE_DIR"/roles/.gitkeep
touch "$BASE_DIR"/files/.gitkeep
touch "$BASE_DIR"/templates/.gitkeep

# Create 'common' role
COMMON_ROLE="$BASE_DIR/roles/common"
mkdir -p "$COMMON_ROLE"/{tasks,handlers,templates,files,vars,defaults,meta}

# tasks/main.yml
cat > "$COMMON_ROLE/tasks/main.yml" <<EOF
---
# tasks file for common
- name: Ensure timezone is set
  ansible.builtin.command: timedatectl set-timezone {{ timezone }}
  when: timezone is defined
EOF

# Placeholders to keep structure in Git
touch "$COMMON_ROLE"/handlers/.gitkeep
touch "$COMMON_ROLE"/templates/.gitkeep
touch "$COMMON_ROLE"/files/.gitkeep
touch "$COMMON_ROLE"/vars/.gitkeep
touch "$COMMON_ROLE"/defaults/.gitkeep
touch "$COMMON_ROLE"/meta/.gitkeep

echo "✅ Ansible project with default 'common' role created at: $BASE_DIR"

