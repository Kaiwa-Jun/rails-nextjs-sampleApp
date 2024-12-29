require 'rails_helper'

RSpec.describe 'ログアウトAPI (DELETE /api/logout)', type: :request do
  describe 'DELETE /api/logout' do
    before do
      User.delete_all
      @user = User.create!(email: "logout_test@example.com", password: "password")
    end

    it 'サーバー側のセッションを破棄し、JSON 形式でメッセージを返すこと' do
      delete '/api/logout'

      # ステータスコードの検証
      expect(response).to have_http_status(:ok)

      json_body = JSON.parse(response.body)
      expect(json_body["message"]).to eq("Logged out successfully")
    end
  end
end