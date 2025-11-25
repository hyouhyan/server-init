# 日本語化

## 日本語パッケージにインストール
sudo apt-get -q -y install language-pack-ja-base language-pack-ja

## デフォルトの言語変更
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
