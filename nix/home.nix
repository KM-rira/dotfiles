{ pkgs, ... }:

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
    # General CLI tools (from normal_install.sh & sudo_install.sh)
    bat
    fzf
    jq
    ripgrep
    fd
    zoxide
    eza
    lsd
    dust # brew: dust
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
    # xsv # undefined variable
    ccze
    chrony

    # Development
    gh
    nodejs_20
    # npm is included in nodejs
    # aicommits はパッケージが存在しない可能性があるため一旦コメントアウト
    # aicommits
    cspell
    luarocks
    shfmt
    vim
    neovim
    cargo
    gcc # build-essential相当
  ];

  # Git設定の移行
  programs.git = {
    enable = true;
    settings = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      # wslでのエラー回避用 zdiff3
      # merge.conflictStyle = "zdiff3";
    };
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

  # Zsh設定の有効化 (sudo_install.sh で zsh を入れていたため)
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
