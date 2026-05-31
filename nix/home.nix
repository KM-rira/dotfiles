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
  };

  # Starship設定 (シェル連携用)
  programs.starship = {
    enable = true;
  };

  # Home Manager 自体の管理
  programs.home-manager.enable = true;
}
