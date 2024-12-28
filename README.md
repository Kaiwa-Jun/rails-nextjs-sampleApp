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
```
git clone https://github.com/your-name/rails-nextjs-sampleApp.git
cd rails-nextjs-sampleApp
```

### 2. 動作確認
```
docker compose build
docker compose up -d

停止
docker compose down
```

Rails API

`http://localhost:3000/`

フロントエンド

`http://localhost:3001/`

## Seedデータの投入と確認方法
1. Seedデータの投入
```
docker compose run --rm backend rails db:seed
```

2. データの確認
(A) Rails コンソールで確認

コンテナが起動中の場合は以下のようにしてコンソールを開く
```
docker compose exec backend rails console
```
まだ起動していない場合は:
```
docker compose run --rm backend rails console
```

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

## API一覧

### 投稿一覧API

- **エンドポインｔ**: `GET /posts`
- **説明**: 登録されている全ての投稿データを JSON 形式で返します。
- **サンプルレスポンス**:
```json
[
  {
  "id": 1,
  "title": "Omnis quia nostrum.",
  "image_url": "https://placehold.jp/150x150.png",
  "description": "Vero quas itaque. Aut facilis sed.",
  "user_id": 12,
  "created_at": "2024-12-22T13:28:31.635Z",
  "updated_at": "2024-12-22T13:28:31.635Z"
  },
  {
  "id": 2,
  "title": "Cum et quia.",
  "image_url": "https://placehold.jp/150x150.png",
  "description": "Quo reiciendis saepe. In aut qui.",
  "user_id": 11,
  "created_at": "2024-12-22T13:28:31.639Z",
  "updated_at": "2024-12-22T13:28:31.639Z"
  },
]
```

### 投稿詳細API

- **エンドポインｔ**: `GET /posts/1`
- **説明**: 登録されている任意の投稿データを JSON 形式で返します。
- **サンプルレスポンス**:
```json
{
"id": 1,
"title": "Omnis quia nostrum.",
"image_url": "https://placehold.jp/150x150.png",
"description": "Vero quas itaque. Aut facilis sed.",
"user_id": 12,
"created_at": "2024-12-22T13:28:31.635Z",
"updated_at": "2024-12-22T13:28:31.635Z"
}
```

### 投稿一覧API
- **エンドポインｔ**: `POST /posts`
- **説明**: 新しい投稿を作成し、JSON 形式で返します。
- **リクエスト例**:
```json
{
  "post": {
    "title": "サンプルタイトル",
    "image_url": "https://example.com/test-image.png",
    "description": "サンプル説明文です",
    "user_id": 1
  }
}
```

- **サンプルレスポンス**:
```json
{
  "id": 22,
  "title": "サンプルタイトル",
  "image_url": "https://example.com/test-image.png",
  "description": "サンプル説明文です",
  "user_id": 1,
  "created_at": "2024-12-28T08:29:41.199Z",
  "updated_at": "2024-12-28T08:29:41.199Z"
}
```

### ログインAPI
- **エンドポインｔ**: `POST /api/login`
- **説明**: 既存ユーザーのメールアドレスとパスワードを使ってログイン判定を行います
- **リクエスト例**:
```json
{
  "email": "test@example.com",
  "password": "password"
}
```

- **サンプルレスポンス**:
**成功 (ステータス 200 OK)**
```json
{
  "message": "Signed in successfully",
  "user_id": 7
}
```

**失敗 (ステータス 401 Unauthorized)**
```json
{
  "error": "Invalid email or password"
}
```

### ログアウトAPI
- **エンドポイント**: `DELETE /api/logout`
- **説明**: サーバー側のセッションを破棄し、ユーザーをログアウト状態にする
- **レスポンス例**:
  ```json
{
  "message": "Logged out successfully"
}
```

### 会員登録（サインアップ）API
- **エンドポイント**: `POST /api/signup`
- **説明**: 新規ユーザーを登録する。Deviseを利用したUserモデルに対し、メールアドレスとパスワードを送信する。  
- **リクエスト例**:
```json
{
  "user": {
    "email": "new_user@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
}
```

- **サンプルレスポンス (成功)**
```json
{
  "message": "User created successfully",
  "user_id": 8,
  "email": "new_user@example.com"
}
```

- **サンプルレスポンス (失敗)** 
```json
{
  "errors": [
    "Email has already been taken",
    "Password is too short (minimum is 6 characters)"
  ]
}
```