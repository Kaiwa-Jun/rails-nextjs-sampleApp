require 'rails_helper'

RSpec.describe '投稿削除API (DELETE /posts/:id)', type: :request do
  describe 'DELETE /posts/:id' do
    before do
      Post.delete_all
      User.delete_all

      # 削除対象のユーザー＆投稿を作成
      @user = User.create!(
        email: 'test_destroy@example.com',
        password: 'password'
      )
      @post = Post.create!(
        title:       "Delete Target",
        image_url:   "https://example.com/delete.png",
        description: "Delete this post",
        user_id:     @user.id
      )
    end

    it '指定した投稿を削除し、成功メッセージを返すこと' do
      # 削除リクエストを送る
      delete "/posts/#{@post.id}"

      # ステータスコードが 200 OK
      expect(response).to have_http_status(:ok)

      # レスポンスのメッセージを検証 (任意のメッセージが返る実装に合わせて調整)
      json_body = JSON.parse(response.body)
      expect(json_body["message"]).to eq("Post deleted successfully")

      # DB上の投稿が削除されていることを確認
      expect(Post.count).to eq(0)
    end
  end
end