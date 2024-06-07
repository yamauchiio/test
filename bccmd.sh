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

# ビルドの準備
./bootstrap

# bccmd を含むすべてのツールをビルド
./configure
make

# bccmd をインストール
sudo make install

# パスを通す
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc

# 変更を反映
source ~/.bashrc

# 作業完了メッセージ
echo "BlueZ 5.55 の bccmd がビルドおよびインストールされ、パスが設定されました。"
