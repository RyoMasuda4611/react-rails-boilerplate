module Api
  module V1
    class ApplicationController < ActionController::API
      include Knock::Authenticable
      before_action :authenticate_user

      # update access token in every each "authication required" requests
      # before_action :authenticate_and_set_token

      private

      def authenticate_and_set_token
        authenticate_user
        headers['Authorization'] = Knock::AuthToken.new(payload: current_user.to_token_payload).token
      end
    end
  end
end
