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
    rustup
    imagemagick
    ripgrep
    cmark
    python2
    neofetch
    stow
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

    extraConfig = '';el
      (require 'tree-sitter)
      (require 'tree-sitter-langs)
      (require 'polymode)

			(setq inhibit-startup-message t)
			(setq inhibit-splash-screen t)
			(setq inhibit-startup-screen t)
			
			; tty specific
      (when (not window-system)
        (xterm-mouse-mode)
				(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
				(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
        (menu-bar-mode -1))

      ; gui specific (minimap)
			(when window-system
				(menu-bar-mode t)
				(setq frame-resize-pixelwise t)
        (custom-set-faces
         '(demap-minimap-font-face ((t (:height 30 :family "Minimap")))))
        (demap-toggle))

      ; poly-nix-mode
      (define-hostmode poly-nix-hostmode
        :mode 'nix-mode)

      (define-innermode poly-nix-elisp-comment-innermode
        :mode 'emacs-lisp-mode
        :head-matcher "\'\';el"
        :tail-matcher "\'\'"
        :head-mode 'host
        :tail-mode 'host)

      (define-polymode poly-nix-mode
        :hostmode 'poly-nix-hostmode
        :innermodes '(poly-nix-elisp-comment-innermode))

      (add-to-list 'auto-mode-alist '("\\.nix" . poly-nix-mode))

      ; mac-specific
      (when (eq system-type 'darwin)
        (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
        (setq ns-use-proxy-icon nil)
        (setq frame-title-format "\n")) ; suppress resize information

      (fringe-mode -1)
      (scroll-bar-mode -1)
			(tool-bar-mode -1)

      ; indentation
      (setq indent-tabs-mode nil)

      ; line numbers
      (global-display-line-numbers-mode)

      ; show current line
      (global-hl-line-mode t)

      ; default buffer font
      (custom-set-faces
        '(default ((t (:family "Iosevka SS07")))))

      ; markdown rendering provider
      (setq markdown-command "cmark")

      ; replace with your default theme of choice
      (load-theme 'doom-old-hope)

      ; tree sitter should manage syntax highlighting
      (global-tree-sitter-mode t)
      (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

      ; feebleline
      (setq feebleline-msg-functions
        '((feebleline-line-number         :fmt "%4s" :pre "")
					(feebleline-file-modified-star  :face font-lock-keyword-face :fmt "＊")
          (feebleline-file-or-buffer-name :face font-lock-keyword-face)
          (feebleline-file-directory      :face feebleline-dir-face :pre "in ")
          (feebleline-git-branch          :pre " " :align right :post "  ")))

			(feebleline-mode)

		  ; git gutter
			(setq git-gutter+-added-sign "▌")
			(setq git-gutter+-deleted-sign "▌")
			(setq git-gutter+-modified-sign "▌")

      (global-git-gutter+-mode)
    '';

    extraPackages = epkgs: [
      epkgs.focus
      epkgs.vterm
      epkgs.nix-mode
      epkgs.doom-themes
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.rust-mode
      epkgs.demap
      epkgs.moody
      epkgs.feebleline
      epkgs.rg
      epkgs.magit
      epkgs."git-gutter+"
      epkgs.markdown-mode
      epkgs.polymode
      epkgs."all-the-icons"
    ];
  };
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      "emacs" = "emacs --no-splash -g 130x44";
    };
    envExtra = ''PATH="$PATH:/opt/homebrew/bin"'';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "philips";
  };
}
