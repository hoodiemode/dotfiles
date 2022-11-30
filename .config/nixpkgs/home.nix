{ config, pkgs, ... }:

with pkgs;

let
  py-packages = python-packages: with python-packages; [
    pillow
    colorz
    colorthief
  ];
  python3-with-packages = python3.withPackages py-packages;
  my-ncmpcpp = ncmpcpp.override { visualizerSupport = true; clockSupport = true; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "charlotte";
  home.homeDirectory = "/Users/charlotte";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with nodePackages; [
    rustup
    imagemagick
    ripgrep
    cmark
    python3-with-packages
    python2
    neofetch
    stow
    direnv
    my-ncmpcpp
    mpc-cli
    bashInteractive
    gnupg
    btop
    exa
    tree-sitter
    ranger
    # language servers
    vscode-langservers-extracted
    bash-language-server
    rnix-lsp
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "-m" ];
    tmux.enableShellIntegration = true;
  };

  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      setw -g mouse on
      
      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=black'
      set -g status-left \'\'
      set -g status-right \'\'
      set -g status-right-length 50
      set -g status-left-length 20
        
      setw -g window-status-current-style 'fg=black'
      setw -g window-status-current-format ' #[bg=red, fg=black] #I #[bg=brightwhite, fg=black] #W #F #[bg=default]'
      
      setw -g window-status-style 'fg=black, bg=gray'
      setw -g window-status-format ' #I #F '
      
      setw -g window-status-bell-style 'fg=white'
    '';
  };

  programs.bash = {
    enable = true;
    sessionVariables = { 
      PATH = "$PATH:/opt/homebrew/bin:/opt/homebrew/opt/llvm@12/bin:$HOME/.cargo/bin:$HOME/.ghcup/bin:$HOME/Library/Python/3.8/bin"; 
      EDITOR = "nvim";
      DOTFILES = "$HOME/.files";
      NVIM_INIT_LUA = "$DOTFILES/.config/nvim/lua/init.lua";
      HOME_NIX = "$DOTFILES/.config/nixpkgs/home.nix";
    };
    shellAliases = {
      ls = "ls -FG";
      htop = "btop";
      firefox = "/Applications/Firefox.app/Contents/MacOS/firefox";
      code = "'/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'";
    };
    # profileExtra = "wal -Rn > /dev/null";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = "luafile $HOME/.config/nvim/lua/init.lua";
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [ 
      goyo-vim
      limelight-vim
      nightfox-nvim
      nvim-treesitter
      vim-nix
      indentLine
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-vsnip
      vim-vsnip
      nvim-web-devicons
      nvim-tree-lua
      lualine-nvim
      lualine-lsp-progress
    ];
  };

  programs.urxvt = {
    enable = true;
    iso14755 = true;
    scroll = {
      bar = {
        enable = false;
      };
    };
  };

  programs.feh = {
    enable = true;
  };
}
