require 'rails_helper'

RSpec.describe 'ログインAPI (POST /api/login)', type: :request do
  describe 'POST /api/login' do
    before do
      User.delete_all
      Post.delete_all

      # テスト用ユーザーを1件作成
      @user = User.create!(
        email: 'test_login@example.com',
        password: 'password'
      )
    end

    context '正しいメールアドレスとパスワードが送られた場合' do
      it 'ステータス200と、成功メッセージを返すこと' do
        login_params = {
          email:    'test_login@example.com',
          password: 'password'
        }

        post '/api/login', params: login_params
        expect(response).to have_http_status(:ok)

        json_body = JSON.parse(response.body)
        expect(json_body["message"]).to eq("Signed in successfully")
        expect(json_body["user_id"]).to eq(@user.id)
      end
    end

    context '間違ったパスワードやメールアドレスが送られた場合' do
      it 'ステータス401と、エラーメッセージを返すこと' do
        invalid_params = {
          email:    'test_login@example.com',
          password: 'wrong_password'
        }

        post '/api/login', params: invalid_params
        expect(response).to have_http_status(:unauthorized)

        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq("Invalid email or password")
      end
    end
  end
end