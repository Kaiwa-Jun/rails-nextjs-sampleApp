require 'rails_helper'

RSpec.describe '投稿詳細API (GET /posts/:id)', type: :request do
  describe 'GET /posts/:id' do
    before do
      # テスト環境のDBを一旦クリア
      Post.delete_all
      User.delete_all

      # テスト用ユーザーを1件作成
      user = User.create!(
        email: 'test@example.com',
        password: 'password'
      )

      # 投稿を1件作成
      @post = Post.create!(
        title: "Sample Title",
        image_url: "https://example.com/sample.png",
        description: "Sample Description",
        user_id: user.id
      )
    end

    it '指定した投稿の詳細が取得できること' do
      get "/posts/#{@post.id}"  # 「投稿詳細API」に相当するリクエスト

      expect(response).to have_http_status(:ok)

      json_body = JSON.parse(response.body)

      # 作成した投稿(@post)の情報が正しく取得できているか確認
      expect(json_body["id"]).to          eq(@post.id)
      expect(json_body["title"]).to       eq("Sample Title")
      expect(json_body["image_url"]).to   eq("https://example.com/sample.png")
      expect(json_body["description"]).to eq("Sample Description")
      expect(json_body["user_id"]).to     eq(@post.user_id)
    end
  end
end