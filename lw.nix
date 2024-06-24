{ config, pkgs, ... }: {
    # Profile version
    home.stateVersion = "24.05";

    home.sessionVariables = {
      EDITOR = "nvim";
    };
    home.shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      nrsf = "sudo nixos-rebuild switch --flake /home/lw/.dotfiles/";
      enc = "sudo $EDITOR /etc/nixos/configuration.nix";
      euc = "sudo $EDITOR /etc/nixos/lw-config.nix";
      ehc = "sudo $EDITOR /etc/nixos/hardware-configuration.nix";
      emc = "sudo $EDITOR /etc/nixos/aya.nix";
      vim = "nvim";
    };

    # Theming
    gtk = {
      enable = true;
      theme = {
      	name = "adw-gtk3-dark";
	package = pkgs.adw-gtk3;
      };
    };
    qt = {
    	enable = true;
    	style = {
		name = "adwaita-dark";
		package = pkgs.adwaita-qt;
	};
    };

    # Shell
    programs.zsh = {
      enable = true;
      history.size = 30000;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "rgm";
      };
    };

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = import ./hyprland/default.nix;
    xdg.configFile."hypr/start.sh".source = ./hyprland/start.sh;
    xdg.configFile."hypr/start.sh".executable = true;
    programs.hyprlock.enable = true; #TODO: load config here!
    programs.hyprlock.settings = import ./hyprlock/default.nix;
    programs.waybar.enable = true;
    programs.waybar.settings = import ./waybar/default.nix;
    programs.waybar.style = import ./waybar/style.nix;
    #TODO: and waybar too!
    programs.rofi = {
	enable = true;
	package = pkgs.rofi-wayland;
	font = "JetBrainsMono Nerd Font 10";
	location = "center";
	theme = "android_notification";
    };

    programs.git = {
    	enable = true;
	lfs.enable = true;
	userEmail = "lw@fmap.me";
	userName = "lw";
    };

    # Browser
    programs.firefox = import ./firefox/default.nix;
    programs.thunderbird = {
      enable = true;
      profiles = {};
    };

    programs.mpv.enable = true;

    programs.neovim.enable = true;

    programs.alacritty = {
      enable = true;
      settings = {
        font.normal = {
	  family = "JetBrainsMono Nerd Font";
	  style = "Regular";
        };
      };
    };

    # Packages
    home.packages = with pkgs; [
      emacs
      tldr
      telegram-desktop
      steam
      webcord-vencord
      tewisay
      shadowsocks-rust
      gzdoom
      audacious
      audacious-plugins
      mpv
      vlc
      kate
      thefuck
      vesktop
      neovide
      glxinfo
    ];
  
}
