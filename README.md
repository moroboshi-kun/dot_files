# My Configuration Files

Welcome to my repository of personal configuration files! This collection includes dotfiles, scripts, and setups to customize and enhance my development and workstation environment. Feel free to explore, adapt, and use these files.

---

## 🚀 Features

- **Shell Configurations**: Bash and Zsh setups for different environments.
- **Git**: Multiple profiles for GitHub, GitLab, Bitbucket, and work-related configurations.
- **Editors and IDEs**: Configurations for LunarVim, Neovim, Vim, CLion, and VS Code.
- **Scripts**: Useful scripts for automating repetitive tasks.
- **Desktop Tools**: Terminal and window management configurations.
- **SSH**: Custom SSH profiles for different devices.
- **Tmux**: Flexible configurations for different use cases.

---

## 📂 Key Directories

- `bash/`: Shell configuration files for Bash.
- `git/`: Multiple Git profiles for different services and use cases.
- `ide/`: Settings for CLion and VS Code.
- `lunarvim/` and `nvim/`: Configurations for LunarVim and Neovim.
- `scripts/`: Helpful automation scripts.
- `ssh/`: SSH configuration profiles.
- `tmux/`: Tmux configuration files.
- `vim/` and `zsh/`: Vim and Zsh configurations.
- `terminal/`: Terminal emulator settings (e.g., Terminator).
- `screen/`: GNU Screen configuration files.

---

## 💻 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Set up symbolic links: Use the provided setup script or manually link configuration files:
    ```bash
    ln -s ~/dotfiles/bash/bashrc.ubuntu ~/.bashrc
    ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
    # Add additional links as needed
    ```

3. Reload your terminal or source the configuration files:
    ```bash
    source ~/.bashrc
    ```

## 🛠 Customization

Each configuration file is designed to be modular and flexible. Modify them to suit your personal preferences and workflows.

## 📖 Usage

Backup and Sync: This repository serves as a backup of my configurations and can be used to replicate my setup on different machines.
