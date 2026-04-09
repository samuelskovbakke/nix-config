# ❄️ nix-config

A highly modular NixOS configuration, managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes) and [Home Manager](https://github.com/nix-community/home-manager).

---

## 📁 Structure

```
nix-config/
├── flake.nix          # Flake entrypoint — inputs, outputs, and host definitions
├── flake.lock         # Pinned dependency versions
├── hosts/             # Per-host NixOS configurations
├── nixos/
│   └── modules/       # Reusable NixOS modules
└── home/              # Home Manager configuration (user environment, dotfiles, etc.)
```

## 🖥️ Hosts

Hosts are defined in the `hosts/` directory. Each host has its own configuration that imports shared NixOS modules and hardware-specific settings.

## 🏠 Home Manager

User-level configuration lives in `home/`, including shell setup, editor config, and any other dotfiles managed declaratively through Home Manager.

## 🧩 NixOS Modules

Reusable, composable NixOS modules are stored under `nixos/modules/`. These can be shared across multiple hosts to keep configuration DRY.

---

## 🚀 Usage

### Prerequisites

- [NixOS](https://nixos.org/) with flakes enabled, **or** any Linux distro with Nix installed
- Flakes and the new nix CLI enabled in your Nix config:

```nix
# /etc/nix/nix.conf  (or nix.settings in your NixOS config)
experimental-features = nix-command flakes
```

### Rebuild a NixOS system

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Apply Home Manager configuration

```bash
home-manager switch --flake .#<username>@<hostname>
```

### Update flake inputs

```bash
nix flake update
```

---

## 🛠️ Installation (fresh NixOS)

1. Boot a [NixOS installer](https://nixos.org/download) and partition/format your disks.
2. Mount the target filesystem at `/mnt`.
3. Generate hardware config:
   ```bash
   nixos-generate-config --root /mnt
   ```
4. Clone this repo:
   ```bash
   nix-shell -p git
   git clone https://github.com/samuelskovbakke/nix-config /mnt/etc/nixos
   ```
5. Copy or symlink the generated hardware config into the appropriate host directory.
6. Install:
   ```bash
   nixos-install --flake /mnt/etc/nixos#<hostname>
   ```
7. Reboot, then apply Home Manager:
   ```bash
   home-manager switch --flake ~/.config/nixos#<username>@<hostname>
   ```

---

## 📦 Key Technologies

| Tool | Purpose |
|---|---|
| [NixOS](https://nixos.org/) | Declarative OS configuration |
| [Nix Flakes](https://nixos.wiki/wiki/Flakes) | Reproducible, pinned dependency management |
| [Home Manager](https://github.com/nix-community/home-manager) | User environment and dotfiles |

---

## 📄 License
This project is licensed under the [GNU General Public License v3.0](LICENSE). You are free to use, modify, and distribute this configuration, but any derivative work must also be distributed under the same GPL v3.0 license.
