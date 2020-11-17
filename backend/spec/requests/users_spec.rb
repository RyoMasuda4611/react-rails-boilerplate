require 'rails_helper'

RSpec.describe 'Api::V1::User', type: :request do
  describe 'POST /api/v1/users' do
    let(:params) {
      {
        user: {
          name: 'added user',
          email: 'addeduser@sample.com',
          password: VALID_PASSWORD,
          password_confirmation: VALID_PASSWORD
        }
      }
    }

    let(:invalid_password_params) {
      {
        user: {
          name: 'added user',
          email: 'addeduser@sample.com',
          password: 'InvalidPassword',
          password_confirmation: 'InvalidPassword'
        }
      }
    }

    let(:invalid_confirmation_params) {
      {
        user: {
          name: 'added user',
          email: 'addeduser@sample.com',
          password: VALID_PASSWORD,
          password_confirmation: 'InvalidPassword'
        }
      }
    }

    context 'without authentication' do
      it 'creates new user' do
        expect {
          post api_v1_sign_up_path, headers: header, params: params.to_json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)

        expect(json['name']).to eq params[:user][:name]
        expect(json['email']).to eq params[:user][:email]
      end

      it 'handles errors with wrong password confirmation' do
        expect {
          post api_v1_sign_up_path, headers: header, params: invalid_confirmation_params.to_json
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)

        errors = JSON.parse(response.body)['errors']
        expect(errors.size).to be > 0
      end

      it 'handles errors with invalid password not including symbols' do
        expect {
          post api_v1_sign_up_path, headers: header, params: invalid_password_params.to_json
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)

        errors = JSON.parse(response.body)['errors']
        expect(errors.size).to be > 0
      end

      # it 'also sends an "confirming mail" mail' do
      #   expect(ActionMailer::Base.deliveries.size).to eq 0
      #   post api_v1_sign_up_path, headers: header, params: params.to_json
      #   expect(response).to have_http_status(:success)
      #   expect(ActionMailer::Base.deliveries.size).to eq 1
      # end
    end
  end
end
