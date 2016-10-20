# Nee-co APIドキュメント

---

## ホスト機にnodejsを入れる場合

### 事前準備
- nodejs(v0.12.14 動作確認済み)

### 必要パッケージインストール
`$ npm -g install aglio@latest`

### ドキュメント生成
`$ aglio -i neeco.apib -o neeco.html`

---

## Dockerを使う場合

### 事前準備
- Docker動作環境

### aglioイメージ ビルド
`$ docker build -t neeco-api .`

### ドキュメント生成
`$ docker run --rm -v $(pwd):/tmp -t neeco-api aglio -i /tmp/neeco.apib -o /tmp/neeco.html`
