# GitHub Actions Step Log Copy Button

GitHub ActionsのCI画面の各ステップにコピーボタンを追加するChrome/Vivaldi拡張機能です。

## 機能

- GitHub Actionsの各ステップ（Set up job、gofmt -s checkなど）の右上にコピーボタンを配置
- ボタンをクリックすると、そのステップのログをクリップボードにコピー
- タイムスタンプや行番号などを自動的に除外してクリーンなログをコピー

## 開発

### 前提条件

- Node.js (v18以上推奨)
- npm

### セットアップ

```bash
# 依存関係のインストール
npm install

# TypeScriptのコンパイル
npm run build

# 開発時の自動コンパイル
npm run watch
```

### ビルド

```bash
npm run build
```

コンパイルされたファイルは`dist/`ディレクトリに出力されます。

## インストール方法

### Vivaldiの場合

1. Vivaldiで `vivaldi://extensions/` を開く
2. 右上の「開発者モード」を有効にする
3. 「パッケージ化されていない拡張機能を読み込む」をクリック
4. このプロジェクトのルートディレクトリを選択

### Chromeの場合

1. Chromeで `chrome://extensions/` を開く
2. 右上の「デベロッパーモード」を有効にする
3. 「パッケージ化されていない拡張機能を読み込む」をクリック
4. このプロジェクトのルートディレクトリを選択

## プロジェクト構造

```
.
├── src/
│   └── content.ts        # TypeScriptソースファイル
├── dist/
│   └── content.js        # コンパイル済みJavaScript
├── manifest.json         # Chrome拡張のマニフェストファイル
├── package.json          # npm設定ファイル
├── tsconfig.json         # TypeScript設定ファイル
└── README.md             # このファイル
```

## ライセンス

MIT
