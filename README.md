# elixir-phoenix-sample-with-docker

  Elixir のフレームワーク [Phoenix](https://phoenixframework.org/)の動作確認を行った簡単なサンプルです。
  Phoenix (というかElixir) は [ASDF](https://github.com/asdf-vm/asdf) によりローカルで起動。docker コンテナの MySQL にアクセスするようになっています。

## 前提条件

  動作確認は、Mac でのみ行っています。
  動作させるにあたり、以下のアプリがインストールされている必要があります。

  1. [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
  1. [ASDF](https://github.com/asdf-vm/asdf)
      ```bash
      $ git clone https://github.com/asdf-vm/asdf.git ~/.asdf
      $ echo -e '\nsource $HOME/.asdf/asdf.sh' >> ~/.bash_profile
      $ echo -e '\nsource $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
      $ source ~/.bash_profile
      ```

## 動作確認方法

  環境構築・サーバ起動コマンドは `Makefile` でまとめています。詳細は `Makefile` を参照してください。

  1. 環境構築。
      ```bash
      $ make init
      ```
  2. phoenix サーバ起動。
      ```bash
      $ make server
      ```
  3. ローカルのブラウザで [`http://localhost:4000`](http://localhost:4000) にアクセス。  
    「Welcome to Phoenix!」ページが表示されればOK。

## 対話式でのiex接続方法

  `make server` 実行後（MySQLコンテナ起動後）に
  
  ```bash
  $ cd my_app
  $ iex -S mix
  ```

  [参考 - Elixir School](https://github.com/west-hiroaki/elixir-phoenix-sample-with-docker)

## メモ：ASDF について

  Elixir のバージョン管理として、[ASDF](https://github.com/asdf-vm/asdf) を使用しています。  

  * 使い方メモ
    ```bash
    # Elixir を追加する
    $ asdf plugin-add elixir

    # Elixir の対象verをインストールする
    $ asdf install elixir 1.6.6-otp-21

    # Elixir の対象verへの切り替える
    $ asdf local elixir 1.6.6-otp-21
    
    # verが切り替わっていることを確認する
    $ asdf current
    elixir         1.6.6-otp-21
    ```
  * このプロジェクトでは、個別コマンドではなく以下の方法で使用しています。
    * `.tool-versions` ファイルを用意。この中で言語＆verを指定。  
    * `asdf install` コマンド実行でインストール＆切り替え。  

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
