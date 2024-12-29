require 'rails_helper'

RSpec.describe '投稿編集API (PATCH /posts/:id)', type: :request do
  describe 'PATCH /posts/:id' do
    before do
      Post.delete_all
      User.delete_all

      # 更新対象とするユーザーを1件作成
      @user = User.create!(
        email: 'test_update@example.com',
        password: 'password'
      )

      # 更新前の投稿データ
      @post = Post.create!(
        title:       "Before Title",
        image_url:   "https://example.com/before.png",
        description: "Before Description",
        user_id:     @user.id
      )
    end

    it '指定した投稿を更新し、更新後の投稿をJSONで返すこと' do
      update_params = {
        post: {
          title:       "After Title",
          image_url:   "https://example.com/after.png",
          description: "After Description",
          user_id:     @user.id
        }
      }

      # PATCHリクエストを送信
      patch "/posts/#{@post.id}", params: update_params

      # ステータスコードの確認 (200 OK)
      expect(response).to have_http_status(:ok)

      # JSONレスポンスの確認
      json_body = JSON.parse(response.body)
      expect(json_body["id"]).to          eq(@post.id)
      expect(json_body["title"]).to       eq("After Title")
      expect(json_body["image_url"]).to   eq("https://example.com/after.png")
      expect(json_body["description"]).to eq("After Description")
      expect(json_body["user_id"]).to     eq(@user.id)

      # DB上の投稿内容が更新されているか確認 (オプション)
      @post.reload
      expect(@post.title).to       eq("After Title")
      expect(@post.image_url).to   eq("https://example.com/after.png")
      expect(@post.description).to eq("After Description")
    end
  end
end