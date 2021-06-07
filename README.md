# authorized_keysでpermitlistenを2つ以上指定すると接続できなくなる問題の調査

## 概要

Debian 10 Buster ではopenssh 7.9p1がインストールされるが、このバージョンは`permitlisten`の動作に問題がある。
具体的には、`authorized_keys`ファイルに複数の公開鍵を登録し、それぞれに`permitlisten`オプションを指定すると、2つめ以降の公開鍵で接続できなくなる。
Debian Backportsからインストールできるopenssh 8.4p1を同様の設定で動かしてみたところ、この問題は再現しなかった。
そのため、Debian 10 Buster環境で`permitlisten`を使用したい場合は、Backportsからインストールできるバージョンを使用するのがよいと考えられる。

## 検証環境の構成

3つのDockerコンテナ（rpfw_server, rpfw_client_1, rpfw_client_2）をそれぞれホストにみたて、rpfw_client_1及びrpfw_client_2からrpfw_serverに対してリバースポートフォワードのセッションを張るようにsystemdを設定した。

## 検証環境の起動と停止

```sh
docker compose build
docker compose up -d
docker compose down
```

## 接続状況の確認

```sh
docker exec -it rpfw_server ss -ltp4
```

## それぞれのコンテナにシェルログイン

```sh
docker exec -it rpfw_server bash
docker exec -it rpfw_client_1 bash
docker exec -it rpfw_client_2 bash
```
