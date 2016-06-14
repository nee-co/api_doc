# Nee-co APIドキュメント

---

## ホスト機にnodejsを入れる場合

### 事前準備
- nodejs(v0.12.14 動作確認済み)

### 必要パッケージインストール
`$ npm -g install aglio@latest api-mock@latest`

### ドキュメント生成
`$ aglio -i /tmp/neeco.apib -o /tmp/neeco.html`

### ダミーAPIサーバ
`$ api-mock neeco.apib`

---

## Dockerを使う場合

### 事前準備
- Docker動作環境

### aglioイメージ ビルド
`$ docker build -t neeco-api .`

### ドキュメント生成
`$ docker run -v $(pwd):/tmp -t neeco-api aglio -i /tmp/neeco.apib -o /tmp/neeco.html`

### ダミーAPIサーバ
`$ docker run -v $(pwd):/tmp -p 3000:3000 -t neeco-api api-mock /tmp/neeco.apib`

---

## TODO

- api-mockがmdファイル分割に対応していないため、どうにかする
