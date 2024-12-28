class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # パラメータをUserに割り当て
    user = User.new(sign_up_params)

    if user.save
      # 成功時: 登録したユーザー情報を返す or 必要に応じてメッセージを返す
      render json: {
        message: 'User created successfully',
        user_id: user.id,
        email: user.email
      }, status: :created
    else
      # 失敗時: バリデーションエラーを返す
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Strong Parameters
  def sign_up_params
    # Devise で使われるパラメータに合わせる（password_confirmation は任意）
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end