require 'rails_helper'

RSpec.describe '投稿作成API (POST /posts)', type: :request do
  describe 'POST /posts' do
    before do
      Post.delete_all
      User.delete_all

      # 投稿と紐づくユーザーを作成
      @user = User.create!(
        email: 'test@example.com',
        password: 'password'
      )
    end

    it '新しい投稿を作成し、JSON 形式で返すこと' do
      post_params = {
        post: {
          title: "サンプルタイトル",
          image_url: "https://example.com/test-image.png",
          description: "サンプル説明文です",
          user_id: @user.id
        }
      }

      # Railsに対してPOSTリクエストを送信
      post '/posts', params: post_params

      # ステータスコードのチェック (201 Created が期待値)
      expect(response).to have_http_status(:created)

      # レスポンスボディをJSONにパース
      json_body = JSON.parse(response.body)

      # 作成された投稿の内容を検証
      expect(json_body["title"]).to       eq("サンプルタイトル")
      expect(json_body["image_url"]).to   eq("https://example.com/test-image.png")
      expect(json_body["description"]).to eq("サンプル説明文です")
      expect(json_body["user_id"]).to     eq(@user.id)

      # DBにレコードが1件作成されているか確認
      expect(Post.count).to eq(1)

      # DB上の最初の投稿を取り出して検証
      created_post = Post.first
      expect(created_post.title).to       eq("サンプルタイトル")
      expect(created_post.image_url).to   eq("https://example.com/test-image.png")
      expect(created_post.description).to eq("サンプル説明文です")
      expect(created_post.user_id).to     eq(@user.id)
    end
  end
end