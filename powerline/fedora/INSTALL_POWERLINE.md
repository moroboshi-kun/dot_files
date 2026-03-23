# INSTALL_POWERLINE.md

## Overview
This document outlines the steps required to install and configure Powerline with Git status support on Fedora (tested on Fedora 43). These steps are designed to be reproducible and compatible with storing configuration in a version-controlled repository.

---

## Prerequisites
Ensure your system is up to date:

```bash
sudo dnf update -y
```

---

## Step 1: Install Required Packages

Install Powerline and Powerline fonts using dnf:

```bash
sudo dnf install -y powerline powerline-fonts
```

Install the Powerline Git status extension using pip:

```bash
pip install --user powerline-gitstatus
```

---

## Step 2: Create Configuration Directories

Create user-level Powerline configuration directories:

```bash
mkdir -p ~/.config/powerline/themes/shell
mkdir -p ~/.config/powerline/colorschemes/shell
```

---

## Step 3: Copy Default Configuration Files

Copy the default theme and colorscheme files to your user configuration directory:

```bash
cp /etc/xdg/powerline/themes/shell/default.json ~/.config/powerline/themes/shell/
cp /etc/xdg/powerline/colorschemes/shell/default.json ~/.config/powerline/colorschemes/shell/
```

---

## Step 4: Apply Custom Configuration

### Theme Configuration
Replace or modify the file:

```
~/.config/powerline/themes/shell/default.json
```

Use your customized version from:

```
default.json.themes
```

---

### Colorscheme Configuration
Replace or modify the file:

```
~/.config/powerline/colorschemes/shell/default.json
```

Use your customized version from:

```
default.json.colorschemes
```

---

## Step 5: Configure Bash

Append the contents of the following file to your `~/.bashrc`:

```
bashrc.powerline.snippet
```

This snippet enables Powerline in your shell environment.

---

## Step 6: Validate Configuration

Run the Powerline linter to ensure there are no configuration errors:

```bash
powerline-lint
```

---

## Step 7: Restart Powerline

Restart the Powerline daemon and reload your shell:

```bash
powerline-daemon --replace
source ~/.bashrc
```

---

## Notes
- Ensure your terminal is using a Powerline-compatible font.
- If changes do not appear, restart your terminal session.
- Keeping all configuration files in a Git repository is recommended for portability and reproducibility.

---

## File Structure Example

```
~/.config/powerline/
├── colorschemes/
│   └── shell/
│       └── default.json
└── themes/
    └── shell/
        └── default.json
```

---

## Troubleshooting

- **Missing symbols:** Ensure `powerline-fonts` is installed and your terminal is configured to use them.
- **Git status not showing:** Verify that `powerline-gitstatus` is installed in the correct Python environment.
- **Configuration errors:** Re-run `powerline-lint` and fix any reported issues.

---

## Summary
This setup provides a fully functional Powerline prompt with Git status support on Fedora. By maintaining these configurations in a repository, you can quickly replicate the environment across systems.
