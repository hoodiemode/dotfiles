{ config, pkgs, ... }:

with pkgs;

let
  py-packages = python-packages: with python-packages; [
    pillow
    colorz
    colorthief
    pywal
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

  home.packages = [
    rustup
    imagemagick
    ripgrep
    cmark
    python3-with-packages
    python2
    neofetch
    stow
    htop
    jq
    direnv
    my-ncmpcpp
    mpc-cli
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "wal";
      editor = {
        auto-format = false;
        rulers = [80];
        auto-pairs = false;
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            newline = "none";
          };
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "block";
        };
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "-m" ];
    tmux.enableShellIntegration = true;
  };

  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
  };
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    envExtra = ''PATH="$PATH:/opt/homebrew/bin"'';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "philips";
  };
}
