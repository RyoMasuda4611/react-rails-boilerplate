module Api
  module V1
    class ApplicationController < ActionController::API
      include ActionPolicy::Controller
      include Knock::Authenticable

      before_action :authenticate_user

      rescue_from ActionPolicy::Unauthorized, with: :render_action_policy_error

      # update access token in every each "authication required" requests
      # before_action :authenticate_and_set_token

      def render_validate_error(model)
        errors = model.errors.map do |column, message|
          {
            status: :unprocessable_entity,
            source: {
              pointer: "/data/attributes/#{column}"
            },
            title: 'Invalid attribute',
            detail: message,
            meta: { type: 'validate', schema: model.class.name, field: column }
          }
        end

        render json: { errors: errors }, status: :unprocessable_entity
      end

      private

      def authenticate_and_set_token
        authenticate_user
        headers['Authorization'] = Knock::AuthToken.new(payload: current_user.to_token_payload).token
      end
    end
  end
end
