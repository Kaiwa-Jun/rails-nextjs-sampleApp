require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  describe 'GET /posts' do
    before do
      Post.delete_all
      User.delete_all

      # ❶ テスト用にユーザーを作る
      user = User.create!(
        email:    'test@example.com',
        password: 'password'
      )

      # ❷ 作成したユーザーのidを用いて投稿を作る
      @post1 = Post.create!(
        title:       "Post One",
        image_url:   "https://example.com/post1.png",
        description: "Description One",
        user_id:     user.id
      )
      @post2 = Post.create!(
        title:       "Post Two",
        image_url:   "https://example.com/post2.png",
        description: "Description Two",
        user_id:     user.id
      )
    end

    it '投稿一覧が取得できること' do
      get '/posts'
      expect(response).to have_http_status(:ok)

      json_body = JSON.parse(response.body)
      expect(json_body.size).to eq(2)

      first_post = json_body.find { |p| p["id"] == @post1.id }
      expect(first_post["title"]).to eq "Post One"
      expect(first_post["image_url"]).to eq "https://example.com/post1.png"
      expect(first_post["description"]).to eq "Description One"
      expect(first_post["user_id"]).to eq @post1.user_id
    end
  end
end