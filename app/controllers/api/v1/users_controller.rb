class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    user = User.new(user_params)

    ActiveRecord::Base.transaction do
      user.save!
    end

    render json: user, status: :created
  rescue ActiveRecord::RecordInvalid
    if user.invalid?
      render_validate_error(user)
      return # rubocop:disable Style/RedundantReturn
    end
  end

  private

  def user_params
    params.require(:user).permit(
      User.column_names, :password, :password_confirmation, :current_password
    )
  end
end
