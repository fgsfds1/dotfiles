host: {
  config,
  pkgs,
	nur,
  ...
}: {
  # Profile version
  home.stateVersion = "24.05";

  # Widely-used variable for a cli editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.shellAliases = {
    vim = "nvim";
    nrs = "sudo nixos-rebuild switch";
    nrsf = "sudo nixos-rebuild switch --fast --flake /home/lw/.dotfiles/";
    nrsfc = "sudo nixos-rebuild switch --fast --flake /home/lw/.dotfiles/ --option eval-cache false";
    #TODO: Remove or change these
    enc = "sudo $EDITOR /etc/nixos/configuration.nix";
    euc = "sudo $EDITOR /etc/nixos/lw-config.nix";
    ehc = "sudo $EDITOR /etc/nixos/hardware-configuration.nix";
    emc = "sudo $EDITOR /etc/nixos/aya.nix";
  };

  # Theming
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "gruvbox-dark-icons-gtk";
      #TODO: fix
      #package = pkgs.gruvbox-icons-gtk;
    };
  };
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  #TODO: cursors

  # Shell
  programs.zsh = {
    enable = true;
    history.size = 30000;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"]; # "thefuck"];
      theme = "rgm";
    };
  };

  # WM stuff:

  # Enable hyprland
  wayland.windowManager.hyprland.enable = true;
  # Hyprland setting are all the same for now (thankfully)
  wayland.windowManager.hyprland.settings = (import ./hyprland/default.nix) host;
  # Common script to launch on all machines using hyprland
  xdg.configFile."hypr/start.sh".source = ./hyprland/start.sh;
  xdg.configFile."hypr/start.sh".executable = true;
  # Per-machine scripts in ./hyprland folder, named after machine hostname
  xdg.configFile."hypr/host.sh".source = ./hyprland + ("/" + host + ".sh");
  xdg.configFile."hypr/host.sh".executable = true;
  # Screen locker TODO:lock screen on inactivity and lid close!
  programs.hyprlock.enable = true;
  #TODO: make this per-machine too
  programs.hyprlock.settings = import ./hyprlock/default.nix;
  # Bar with workspaces, tray etc.
  programs.waybar.enable = true;
  programs.waybar.settings = import ./waybar/default.nix;
  programs.waybar.style = import ./waybar/style.nix;
  # dmenu
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 10";
    location = "center";
    theme = "android_notification";
  };
  # wallpapers, just copy them all
  home.file."Pictures/wallpapers".enable = true;
  home.file."Pictures/wallpapers".source = ./wallpapers;
  # home.file."Pictures/wallpapers".recursive = true;

  # Git
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

  # Media player
  programs.mpv.enable = true;

  # Main editor TODO: configure this shit
  # programs.neovim.enable = true;
  programs.nixvim = import ./nixvim/default.nix;

  # Terminal TODO: configure keybinds
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
    };
  };

	programs.kitty = {
	  enable = true;
		font = {
		  name = "JetBrainsMono Nerd Font";
			size = 12;
		};
		theme = "Darkside";
	};
	
	programs.ranger = {
	  enable = true;
		settings = {
		  preview_images = true;
			preview_images_method = "kitty";
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
		feh
    # thefuck
    vesktop
    neovide
    glxinfo
    hyprshot
    libreoffice
    #TODO: figure out and fix fm
		xfce.thunar
		ranger
		keepassxc
		ollama

		pavucontrol

		nekoray

		# oterm
		#nur.repos.dustinblackman.oatmeal
		python312Packages.pynvim

		steam
		godot_4
		gimp
		krita
  ];
}
