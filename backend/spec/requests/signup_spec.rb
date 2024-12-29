require 'rails_helper'

RSpec.describe '会員登録API (POST /api/signup)', type: :request do
  describe 'POST /api/signup' do
    before do
      User.delete_all
    end

    context '正しいパラメータが送られた場合' do
      it '新規ユーザーが作成され、JSON 形式で成功メッセージを返すこと' do
        signup_params = {
          user: {
            email:                 'new_user@example.com',
            password:              'password',
            password_confirmation: 'password'
          }
        }

        post '/api/signup', params: signup_params

        # 成功時のステータスが201 Createdかどうかをチェック
        expect(response).to have_http_status(:created)

        json_body = JSON.parse(response.body)
        expect(json_body["message"]).to eq("User created successfully")
        expect(json_body["user_id"]).not_to be_nil
        expect(json_body["email"]).to eq('new_user@example.com')

        # DBにユーザーが1件作成されているか確認
        expect(User.count).to eq(1)
        created_user = User.first
        expect(created_user.email).to eq('new_user@example.com')
      end
    end

    context '不正なパラメータ (重複メールアドレスなど) の場合' do
      before do
        # 既にメールアドレス "new_user@example.com" のユーザーが存在すると想定
        User.create!(
          email:    'new_user@example.com',
          password: 'password'
        )
      end

      it 'ステータス422と、エラーメッセージを返すこと' do
        invalid_params = {
          user: {
            email:                 'new_user@example.com',  # 重複
            password:              'password',
            password_confirmation: 'password'
          }
        }

        post '/api/signup', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)

        json_body = JSON.parse(response.body)
        # Deviseなどで "Email has already been taken" のようなエラーが返る想定
        expect(json_body["errors"]).to include("Email has already been taken")
      end
    end
  end
end