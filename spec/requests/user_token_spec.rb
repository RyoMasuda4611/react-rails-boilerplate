require 'rails_helper'

RSpec.describe 'Account Token api', type: :request do
  describe 'Post /api/v1/sign_in' do
    context 'An valid user' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) {
        {
          email: user.email,
          password: user.password
        }
      }

      it 'can login' do
        post api_v1_sign_in_path, headers: header, params: { auth: params }.to_json
        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)
        expect(data['jwt']).not_to be ''
      end

      it 'can not login with invalid credentials' do
        post api_v1_sign_in_path, headers: header, params: { auth: { email: params[:email], password: 'InvalidPassword' } }.to_json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
