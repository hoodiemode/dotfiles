{ config, pkgs, ... }:

with pkgs;

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
    imagemagick
    ripgrep
    cmark
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
  };
  
  programs.emacs = {
    enable = true;

    extraConfig = ''
      (require 'tree-sitter)
      (require 'tree-sitter-langs)

      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (setq ns-use-proxy-icon nil)
      (setq frame-title-format nil)

      (fringe-mode -1)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)

      (setq display-line-numbers-width nil)
      (global-display-line-numbers-mode)
      (global-hl-line-mode t)

      (custom-set-faces
        '(default ((t (:family "Iosevka SS07")))))

      (load-theme 'doom-old-hope)
      (global-tree-sitter-mode t)
      (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
      (when window-system
        (setq minimap-hide-fringes t)
        (setq minimap-window-location 1)
        (setq minimap-minimum-width 10)
        (setq minimap-highlight-line nil)
        (minimap-mode))
      (setq feebleline-msg-functions
        '((feebleline-file-modified-star  :face font-lock-warning-face :align right)
          (feebleline-line-number         :fmt "%4s" :pre "")
          (feebleline-column-number       :fmt "")
          (feebleline-file-or-buffer-name :face font-lock-keyword-face)
          (feebleline-file-directory      :face feebleline-dir-face :pre "in ")
          (feebleline-git-branch          :face feebleline-git-face)
          (feebleline-project-name        :align right)))
      (feebleline-mode)
    '';
    
    extraPackages = epkgs: [
      epkgs.focus
      epkgs.vterm
      epkgs.nix-mode
      epkgs.doom-themes
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.rust-mode
      epkgs.minimap
      epkgs.moody
      epkgs.feebleline
      epkgs.rg
      epkgs.magit
      epkgs."git-gutter+"
      epkgs.markdown-mode
    ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      "emacs" = "emacs --no-splash -g 130x44";
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "philips";
  };
}
