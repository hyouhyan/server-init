# サーバ保守関係

## unattended-upgradesをインストール
sudo apt install -y unattended-upgrades

## unattended-upgradesを有効化
sudo cp /usr/share/unattended-upgrades/20auto-upgrades /etc/apt/apt.conf.d/
