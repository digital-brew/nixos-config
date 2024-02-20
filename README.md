# My NixOS configuration

## To do after installation:
###
### Create a Screenshots folder:
```
mkdir /home/moonlander/Screenshots
```
### Create symlinks to dotfiles:
```
ln -s /home/moonlander/nixos-config/modules/desktop/hyprland/dotfiles /home/moonlander/.config/hypr
```

```
ln -s /home/moonlander/nixos-config/scripts /home/moonlander/.config/scripts
```

```
ln -s /home/moonlander/nixos-config/modules/desktop/wayland/dotfiles/swappy /home/moonlander/.config/swappyv
```

```
ln -s /home/moonlander/nixos-config/modules/desktop/waybar/dotfiles /home/moonlander/.config/waybar
```

```
ln -s /home/moonlander/nixos-config/modules/devenv/dotfiles/node/npmrc /home/moonlander/.npmrc
```

### Install devenv
#### First run below command:
```
cachix use devenv
```
#### Then install devenv
```
nix profile install --accept-flake-config tarball+https://install.devenv.sh/latest
```

### Update theme to ```ayu mirage``` in slack
```
#1F2430,#191E2A,#191E2A,#707A8C,#191E2A,#707A8C,#A6CC70,#FFCC66
```

###
###
## To do periodicaly:
- Check ***Shopify CLI*** version
- Check ***PHPStorm*** version
- Check ***nixos-hardware*** version