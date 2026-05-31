{ pkgs, neovim-flake, ... }:

let
  currentUsername = builtins.getEnv "USER";
  currentHomeDirectory = builtins.getEnv "HOME";
  # Neovimのパッケージをflakeから取得
  neovim-pkg = neovim-flake.packages.${pkgs.system}.default;
in
{
  home.username = currentUsername;
  home.homeDirectory = currentHomeDirectory;
  home.stateVersion = "23.11";

  # 既存のインストーラースクリプトから移行したパッケージ一覧
  home.packages = with pkgs; [
    # General CLI tools (from normal_install.sh & sudo_install.sh)
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

  # Git設定の移行
  programs.git = {
    enable = true;
    settings = {};
  };

  # Delta設定 (git integration)
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
    };
  };

  # Zsh設定の有効化
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Starship設定
  programs.starship = {
    enable = true;
  };

  # Home Manager 自体の管理
  programs.home-manager.enable = true;
}
