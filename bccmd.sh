#!/bin/bash

# 必要な依存関係をインストール
sudo apt-get update
sudo apt-get install -y git build-essential autoconf libtool libglib2.0-dev libdbus-1-dev libudev-dev libical-dev libreadline-dev

# 作業ディレクトリに移動
cd /tmp

# BlueZ 5.55 をクローン
git clone -b 5.55 https://git.kernel.org/pub/scm/bluetooth/bluez.git

# クローンしたディレクトリに移動
cd bluez

# g_memdup を g_memdup2 に置き換える
sed -i 's/g_memdup(/g_memdup2(/g' plugins/policy.c

# pause関数の名前を変更する
sed -i 's/static bool pause/static bool bluetoothd_pause/g' profiles/audio/media.c
sed -i 's/pause(/bluetoothd_pause(/g' profiles/audio/media.c

# ビルドの準備
./bootstrap

# bccmd および hid2hci を含むすべてのツールをビルド
./configure
make

# bccmd および hid2hci をインストール
sudo make install

# インストール先を確認
if [ -f /usr/local/bin/hid2hci ]; then
  echo "hid2hci is successfully installed in /usr/local/bin"
else
  echo "Error: hid2hci is not found in /usr/local/bin"
  exit 1
fi

# パスを通す
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc

# 変更を反映
source ~/.bashrc

# 作業完了メッセージ
echo "BlueZ 5.55 の bccmd および hid2hci がビルドおよびインストールされ、パスが設定されました。"
