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