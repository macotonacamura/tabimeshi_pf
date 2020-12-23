# Tabimeshi

## サイト概要
「Find delicacies and Create memories!」
海外の美味しい情報の口コミアプリケーションです。
旅先でも美味しいお食事をお楽しみいただくためのサービス。

### URL
https://tabimeshi.work/
ナビゲーションバーにある、Guestからゲストユーザーとしてログインできます。
管理者側のページは、Footerにある CopyRight tabimeshi.inc がリンクになっておりますので、そちらからご覧いただけます。


### 制作の背景
「限られた時間しかない旅行中、美味しいものしか食べたくない」

海外旅行中、美味しいレストランを見つけることにとても時間がかかってしまったり、
行ってみると期待外れだったりと、
信頼できる情報を見つけることに苦労する経験がありました。

せっかくの海外旅行、美味しいものしか食べたくない！

そこで、確実に美味しいお店を知ることができるアプリケーションがあったら便利だと思い、開発しようと決めました。
「美味しいものを見つけ、素敵な思い出を作る」そんなサポートをできるようなサービスを目指しました。

### ターゲットユーザー
海外旅行を計画している方 / 旅行好きな方

### 主な利用シーン
旅行中 / 旅行計画中
・目的地別に検索し、調べることができる
・いいねした口コミ記事をマイページにて確認が可能


### 機能一覧
- 投稿機能
- 国・都市情報(API)を活用したオートコンプリート機能
- googleマップにてレストランの位置を表示
- 多言語化(11ヶ国語投稿が可能、日/英言語切り替え機能)
- 検索機能(インクリメンタルサーチ)
- フォロー機能
- いいね/いいねリスト(Bookmark)機能
- お問い合わせ機能
- 非同期通信
- 外部API (Google MapAPI,Cities GEO corder country/city,omniauth)
詳細は下記よりご確認ください。
https://docs.google.com/spreadsheets/d/1rbWRdNTyhW8w4USYAYGzUVNJPw3RrZeIOFlmdEP4smY/edit#gid=0

## 環境・使用技術
### フロントエンド
- Bootstrap 4.5.0
- SCSS (BEM)
- JavaScript、jQuery、Ajax

### バックエンド
- Ruby 2.5.7
- Rails 5.2.4.4

### 開発環境
- Vagrant 2.2.14
- VirtualBox


### 本番環境
- AWS(EC2、RDS、Route53、CloudWatch、S3、Lambda)
- Nginx , Puma

### インフラ構成図
![PF_tabimeshi](https://user-images.githubusercontent.com/65491593/102706467-7bf43000-42d5-11eb-8058-06f52a202d9c.jpg)

### テスト
- Rspec 約 80 (モデル、システム、コントローラー)

### ER図
![Untitled Diagram](https://user-images.githubusercontent.com/65491593/102967575-9298c200-4535-11eb-88dc-fd6be6a37b3e.jpg)



## 使用素材
  フリー画像
- https://unsplash.com/
  フォント
- https://fontfree.me/category/mincho
