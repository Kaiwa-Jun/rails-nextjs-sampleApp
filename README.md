# Rails + Next.js サンプルアプリ

このリポジトリは **Ruby on Rails (APIモード)** と **Next.js (TypeScript)** を **Docker Compose** で連携させるサンプルアプリケーションです。
簡易的なAPIをRailsで作成し、Next.js から Fetch して表示しています。

## アプリ概要

- **バックエンド (Rails)**
  - APIモードで構築されており、DBは PostgreSQL を想定しています。
  - `GET /hello` など簡単なサンプルAPIを用意。

- **フロントエンド (Next.js)**
  - TypeScript + Tailwind (任意) + ESLint などを組み込んだ形で作成。
  - `http://localhost:3001/api-sample` などのページから Rails のAPIを取得して表示。

- **Docker構成**
  - **`backend` コンテナ**: Rails, ポート `3000`
  - **`frontend` コンテナ**: Next.js, ポート `3001`
  - **`db` コンテナ**: PostgreSQL, ポート `5432`

## セットアップ & 起動方法

### 1. リポジトリのクローン

```bash
git clone https://github.com/your-name/rails-nextjs-sampleApp.git
cd rails-nextjs-sampleApp

### 2. 動作確認
docker-compose build
docker-compose up -d

停止
docker-compose down

Rails API

http://localhost:3000/

フロントエンド
http://localhost:3001/

## Seedデータの投入と確認方法
1. Seedデータの投入
docker-compose run --rm backend rails db:seed

	•	db/seeds.rb の内容に従い、DBにサンプルデータが作成されます。

2. データの確認

(A) Rails コンソールで確認

コンテナが起動中の場合は以下のようにしてコンソールを開きます。
docker-compose exec backend rails console

まだ起動していない場合は:
docker-compose run --rm backend rails console

```
# ユーザーの件数確認
User.count

# ユーザーの一覧
User.all

# 投稿(Post)の件数確認
Post.count

# 投稿の一覧
Post.all
```