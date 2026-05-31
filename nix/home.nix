{ pkgs, neovim-pkg, ... }:

let
  currentUsername = builtins.getEnv "USER";
  currentHomeDirectory = builtins.getEnv "HOME";
in
{
  home.username = currentUsername;
  home.homeDirectory = currentHomeDirectory;
  home.stateVersion = "23.11";

  # 既存のインストーラースクリプトから移行したパッケージ一覧
  home.packages = with pkgs; [
    # General CLI tools
    bat
    fzf
    jq
    ripgrep
    fd
    zoxide
    eza
    lsd
    dust
    duf
    sd
    glances
    gtop
    lazygit
    lazydocker
    yazi
    tlrc
    cheat
    glow
    usql
    starship

    # Development
    gh
    nodejs_22
    cspell
    luarocks
    shfmt
    vim
    neovim-pkg
    cargo
    gcc
  ];

  # Git設定
  programs.git = {
    enable = true;
    settings = {};
  };

  # Delta設定
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
    };
  };

  # Zsh設定
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "akarzim/zsh-docker-aliases"; }
      ];
    };

    initExtra = ''
      # ------------------------------------------------------------------------
      # NOTE: zstyle
      # ------------------------------------------------------------------------
      zstyle ':completion:*' menu select
      zstyle ':completion:*' auto-list true
      zstyle ':completion:*' file-sort time
      autoload -Uz colors; colors
      zstyle ':completion:*:default' list-colors \
        'di=34:fi=0:ln=36:pi=33:so=35:do=32:bd=33;40:cd=33;40:or=31;47:mi=00;41'
      zstyle ':completion:*:*files' ignored-patterns '*?.o'

      # ------------------------------------------------------------------------
      # NOTE: setopt list
      # ------------------------------------------------------------------------
      setopt autocd
      setopt no_beep
      setopt nobeep
      setopt nolistbeep
      setopt share_history
      setopt correct
      setopt extended_glob
      setopt noautoremoveslash
      setopt EXTENDED_GLOB
      setopt auto_param_slash
      setopt auto_param_keys
      setopt magic_equal_subst
      setopt list_packed
      setopt numeric_glob_sort
      setopt HIST_IGNORE_SPACE
      setopt HIST_IGNORE_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_REDUCE_BLANKS

      # ------------------------------------------------------------------------
      # NOTE: bindkey
      # ------------------------------------------------------------------------
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward
    '';
  };

  # Starship設定 (シェル連携用)
  programs.starship = {
    enable = true;
  };

  # Home Manager 自体の管理
  programs.home-manager.enable = true;
}
