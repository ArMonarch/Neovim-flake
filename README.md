# Neovim-flake

<div align="center">
    <img src="https://img.shields.io/badge/NIX-5277C3.svg?style=for-the-badge&logo=NixOS&logoColor=white" alt="NIX"/>
    <img src="https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
</div>

Neovim-flake is a modular, declarative Neovim distribution built specifically for NixOS, leveraging the power of Nix flakes for fast, efficient, and reproducible setups.

Rather than building a configuration from scratch or relying on bloated, opinionated setups, this project offers a clean and extensible starting point with sane defaults, essential LSP and plugin support, and tight integration with Nix.

Designed for developers who want a Neovim setup that just works with Nix’s declarative nature — no manual plugin management, no broken dependencies, just a reliable, reproducible, and high-performance editing experience.

## Features

- Modular & Declarative: Organize config using Nix and Lua, with nixcats to keep things clean and separated.
- Lazy Loading with lazy.nvim: Fast startup times and smarter plugin loading.
- Performance-First: Startup times under 40ms on modern machines.
- NixOS Native: Built from the ground up to work seamlessly with Nix and NixOS.
- Treesitter Support: Syntax-aware highlighting, folding, and selection for many common languages, with sane, intuitive keybindings.
- Autocomplete: Smooth, responsive, and minimal autocompletion powered by the modern blink.cmp engine.
- Code Formatting: Out-of-the-box support for popular formatters like prettier, stylua, shfmt, and more — declaratively managed.
- Markdown Support + Preview: Seamless Markdown editing experience, including live preview support for content creators and note-takers.
- Beautiful ColorSchemes: Built-in support for popular themes:
    - Catppuccin
    - Gruvbox
    - Rose Pine (Default)
    - Tokyo Night

### Languages Support

| Language        | Tree Sitter | Formatter | Formatter Name | LSP Server | LSP Server Name            |
|:----------------|:-----------:|:---------:|:---------------|------------|:---------------------------|
| Bash            | ✅          | ✅        | shfmt          | ❌         | None                       |
| C               | ✅          | ❌        | None           | ❌         | None                       |
| C#              | ✅          | ❌        | None           | ❌         | None                       |
| CPP             | ✅          | ❌        | None           | ❌         | None                       |
| CSS             | ✅          | ❌        | None           | ❌         | None                       |
| CSV             | ✅          | ❌        | None           | ❌         | None                       |
| HTML            | ✅          | ❌        | None           | ❌         | None                       |
| Java Script     | ✅          | ✅        | prettierd      | ✅         | typescript-language-server |
| JSX             | ✅          | ✅        | prettierd      | ✅         | typescript-language-server |
| Lua             | ✅          | ✅        | stylua         | ✅         | lua-language-server        |
| Markdown        | ✅          | ❌        | None           | ✅         | marksman                   |
| Nix             | ✅          | ✅        | alejandra      | ✅         | nixd                       |
| Python          | ✅          | ✅        | ruff           | ✅         | basedpyright               |
| Rust            | ✅          | ✅        | rust-fmt       | ✅         | rust-analyzer              |
| SQL             | ✅          | ❌        | None           | ❌         | None                       |
| TOML            | ✅          | ❌        | None           | ❌         | None                       |
| TSX             | ✅          | ✅        | prettierd      | ✅         | typescript-language-server |
| Type Script     | ✅          | ✅        | prettierd      | ✅         | typescript-language-server |
| XML             | ✅          | ❌        | None           | ❌         | None                       |
| YAML            | ✅          | ❌        | None           | ❌         | None                       |
| Zig             | ✅          | ✅        | zls            | ✅         | zls                        |

#### TLDR;
Formatter and LSP Servers listed above are provided with nix packaged with Neovim.
Note: To enable Extra tree-sitter grammer support add the language to `flake.nix` tree-sitter packages.

## Installation

### Requirements
Make sure you have Nix with the following enabled:
  - Either NixOS or the Nix package manager (on any OS)

  - **Enable** `nix-command` and `flakes` For Nix Package Manager
    - Add the following to your `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`:
    - ```experimental-features = nix-command flakes```

  - **Enable** `nix-command` and `flakes` For NixOS Config
    - Add the following to your `/etc/nixos/configuration.nix`:
    - ```nix
      nix = {
        settings = {
          experimental-features = ["nix-command" "flakes"];
        };
      };
      ```

### Installation Methods

#### 1. NixOS Configuration (Recommended for system-wide use)
  - Add the following to your `configuration.nix`
  ```nix
  TODO!();
  ```

#### 2. Directly via `nix profile (flake url)`
  - Install from GitHub using flake Url:
  ```nix
  nix profile install github:ArMonarch/Neovim-flake
  ```

#### 3. Run Temporary | Test Neovim before Installing
  - Install from GitHub using flake Url:
  ```nix
  nix flake run github:ArMonarch/Neovim-flake
  ```

## Visuals

<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_01.png" alt="01" />
<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_02.png" alt="02" />
<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_03.png" alt="03" />
<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_04.png" alt="04" />
<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_05.png" alt="05" />
<img src="https://github.com/ArMonarch/Neovim-flake/blob/master/images/Screenshot_06.png" alt="06" />

## Repository Structure

```
 Neovim-flake
├──  lua
│   ├──  frenzfries # Main Neovim Lua configuration namespace
│   │   ├──  lsp # LSP-related configs
│   │   │   ├──  config # Per-language LSP server configurations
│   │   │   └──  init.lua # LSP setup entry point
│   │   ├──  plugins # Plugin definitions and configurations
│   │   │   ├──  init.lua # Central plugin loader
│   │   │   └──  *plugin*.lua # Individual plugin configuration files
│   │   ├──  autocmds.lua # Autocommands setup
│   │   ├──  init.lua # Main entry point for Lua config
│   │   ├──  keymaps.lua # Keybindings
│   │   └──  options.lua # Neovim options/settings
│   └──  nixCatsUtils # Utility functions used for nixcats integration
├──  flake.lock # Nix flake lockfile (frozen dependency versions)
├──  flake.nix # Main Nix flake definition
├──  init.lua # Entry point for Neovim when launched (delegates to Lua/)
├──  LICENSE # MIT license file
└── 󰂺 README.md # Project documentation
```

## Similar Projects
This project draws inspiration from other great Neovim and Nix-based configurations:
- [nixcats](https://github.com/BirdeeHub/nixCats-nvim)
  - A key influence on the architecture of this project — particularly the clean separation of Nix (for managing plugins and packages) and Lua (for Neovim configuration).
- [LazyVim](https://github.com/LazyVim/LazyVim)
 - Inspiration for many keybindings, autocommands, and plugin choices, especially the use of `lazy.nvim` for fast and flexible plugin loading.

## Contributors

<div align="center">
    <a href="https://github.com/ArMonarch/Neovim-flake/graphs/contributors">
        <img src="https://contrib.rocks/image?repo=ArMonarch/Neovim-flake" alt="Contributors"/>
    </a>
</div>

## Licence
This project is licensed under the MIT License (Free as in Freedom).
See the [LICENSE](https://github.com/ArMonarch/Neovim-flake/blob/master/LICENSE) file for details.

<div align="center">
    <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8" alt="License MIT"/>
</div>
