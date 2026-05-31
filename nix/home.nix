{ pkgs, ... }:

{
  home.username = "koji";
  home.homeDirectory = "/home/koji";
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
    du-dust # brew: dust
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
    xsv
    ccze
    chrony
    
    # Development
    gh
    delta # brew: git-delta
    nodejs_20
    nodePackages.npm
    # aicommits はパッケージが存在しない可能性があるため一旦コメントアウト
    # nodePackages.aicommits
    nodePackages.cspell
    luarocks
    shfmt
    vim
    cargo
    gcc # build-essential相当
  ];

  # Git設定の移行
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };
    extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      # wslでのエラー回避用 zdiff3
      # merge.conflictStyle = "zdiff3";
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
