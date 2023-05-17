# アプリケーション名

shared-pic

# アプリケーション概要

写真を共有し、ユーザー同士で閲覧を可能とすること。また写真の詳細を確認し、コメントができる。

# URL

https://shared-pic.onrender.com/

# テスト用アカウント

･ Basic認証ID : Admin  
･ Basic認証パスワード : 2222  
･ メールアドレス : aaa@gmail.com  
･ パスワード : a12345  

# 利用方法

## 写真投稿

1. トップページ(一覧ページ)のヘッダーの新規登録ボタンからユーザーの新規登録を行う
2. 写真投稿ボタンから内容(説明、画像)を入力し投稿する

## コメント機能

1. 一覧表示にて掲載されている写真をクリックし、詳細ページに移動する
2. コメントを投稿するフォームから入力し投稿を行う

# アプリケーションを作成した背景

友人との間で写真を共有できるアプリを使用しているが、「共通している写真を一覧から探すのが大変」という課題を抱えている。課題を分析した結果、「共通の写真をタグづけすることで見やすくなるのではないか」という仮説を立てた。原因を解決するためにタグ付け機能を搭載し、より見やすいアプリケーションを開発することにした。

# 洗い出した要件

https://docs.google.com/spreadsheets/d/1xbRBZ_CcJjX00gieJqCV25Ni6uvoPJ_HNabwLiw3NbQ/edit#gid=1785908763

# 実装した機能についての画像やGIFおよびその説明
ユーザーの新規登録  

[![Image from Gyazo](https://i.gyazo.com/8a7004101f5fa66288bf33c54238af68.gif)](https://gyazo.com/8a7004101f5fa66288bf33c54238af68)  
  
ユーザーのログイン  

[![Image from Gyazo](https://i.gyazo.com/7377bda6cbca672321f1e5f8aa90461f.gif)](https://gyazo.com/7377bda6cbca672321f1e5f8aa90461f)  
  
写真の投稿  

[![Image from Gyazo](https://i.gyazo.com/63ecef5971adde8e76c00ea8c1d2c85c.gif)](https://gyazo.com/63ecef5971adde8e76c00ea8c1d2c85c)  
  
写真の編集  

[![Image from Gyazo](https://i.gyazo.com/c62a84211a1564c2a1aed7199a1e3eb8.gif)](https://gyazo.com/c62a84211a1564c2a1aed7199a1e3eb8)  
  
写真の削除  

[![Image from Gyazo](https://i.gyazo.com/87b63617c7fab7801fac6cd7b309df0c.gif)](https://gyazo.com/87b63617c7fab7801fac6cd7b309df0c)  
  
コメント投稿  

[![Image from Gyazo](https://i.gyazo.com/2d2f8bd9b736083d8fdbeb25f8950624.gif)](https://gyazo.com/2d2f8bd9b736083d8fdbeb25f8950624)  

# 実装予定の機能

ログインする際に他のSNS認証の機能を実装したい。

# データベース設計

[![Image from Gyazo](https://i.gyazo.com/d7ff9d8e4a36f4c9f1ef4c82b3ee49ba.png)](https://gyazo.com/d7ff9d8e4a36f4c9f1ef4c82b3ee49ba)

# 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/db8a20ba771dc40d89b322702f94bf35.png)](https://gyazo.com/db8a20ba771dc40d89b322702f94bf35)

# 開発環境

･ フロントエンド  
･ バックエンド  
･ インフラ  
･ テスト  
･ テキストエディタ  
･ タスク管理

# ローカルでの動作方法

以下のコマンドを順に実行。  

git clone https://github.com/Untilqis/shared-pic.git  
cd shared-pic  
bundle install  
yarn install

# 工夫したポイント

プレビュー機能の画像サイズの調整をしたこと。
ハッシュタグ機能の実装。
写真撮影をした際の情報を詳細機能にて表示。

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| nickname           | string | null: false |

### Association

- has_many :albums
- has_many :comments

## albums テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| description | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to: user
- has_many: comments
- has_many: album_tag_relations
- has_many: tags, through: :album_tag_relations

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| album     | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association
- belongs_to: user
- belongs_to: album

## tags テーブル

| Column   | Type   | Options          |
| -------- | ------ | ---------------- |
| tag_name | string | uniqueness: true |

### Association

- has_many :album_tag_relations
- has_many :album, through: :album_tag_relations

## album_tag_relations テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| album     | references | null: false, foreign_key: true |
| tag       | references | null: false, foreign_key: true |

### Association
- belongs_to :album
- belongs_to :tag