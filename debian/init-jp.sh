# 日本語化

## 日本語フォントとロケールのインストール
sudo apt install -y fonts-noto-cjk locales

## ロケールの生成
sudo sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

## デフォルトの言語変更
sudo update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
