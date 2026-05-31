# Nix/Home Manager セットアップ手順 (macOS & Linux)

このドキュメントは、新しい macOS または Linux 環境に Nix と Home Manager を導入し、dotfiles リポジトリの設定を適用するための手順を説明します。

## 1. Nix のインストール

まず、Nix Package Manager をシステムにインストールします。Determinate Nix Installer を使用することを推奨します。

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール完了後、指示に従ってシェルを再起動するか、設定をソースし直してください。

```bash
# 例: zsh の場合
source ~/.zprofile
# または、端末を再起動
```

Nix が正しくインストールされたか確認します。

```bash
nix --version
```

## 2. Home Manager の設定適用

次に、この dotfiles リポジトリの `flake.nix` と `nix/home.nix` を使用して Home Manager の設定を適用します。これにより、Home Manager が管理するパッケージや設定があなたのユーザー環境に導入されます。

1.  dotfiles リポジトリをクローンします。

    ```bash
    git clone https://github.com/KM-rira/dotfiles.git ~/.dotfiles # リポジトリのパスを適宜変更してください
    cd ~/.dotfiles
    ```

2.  Home Manager の設定を適用します。
    あなたのOS環境に合わせて適切な `homeConfigurations` を指定してください。

    ```bash
    # macOS (Apple Silicon) の場合
    nix run home-manager -- switch --flake ".#koji-mac" --impure

    # Linux (WSL/Ubuntu等) の場合
    nix run home-manager -- switch --flake ".#koji-linux" --impure
    ```

    このコマンドは、`flake.nix` で定義された設定（`nix/home.nix` に記述されているパッケージや `git` 設定など）をビルドし、現在のユーザー環境にアクティベートします。

    初回実行時は多くのパッケージがビルド・ダウンロードされるため、時間がかかる場合があります。

## 3. 確認

設定が適用されたことを確認します。例えば、`bat` コマンドが利用できるか試してみてください。

```bash
bat --version
```

また、`git` の設定も確認できます。

```bash
git config --global core.pager
```

## 注意事項

*   **既存のパッケージマネージャーとの共存**: Homebrew や APT など、他のパッケージマネージャーと Nix は異なる方法でパッケージを管理します。衝突を避けるため、Nix で管理するパッケージは他のパッケージマネージャーではインストールしないようにしてください。
*   **Nixpkgs の更新**: `nixpkgs` のバージョンを更新したい場合は、dotfiles リポジトリのルートディレクトリで以下のコマンドを実行します。

    ```bash
    nix flake update
    ```

    これにより `flake.lock` ファイルが更新され、最新の `nixpkgs` が使用されるようになります。更新後は `nix run home-manager -- switch --flake .#<あなたの設定名>` を再度実行して設定を反映してください。
