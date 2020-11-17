VALID_PASSWORD = 'Password1!'.freeze

module RequestHelper
  def authenticated_header(user)
    token = Knock::AuthToken.new({ payload: user.to_token_payload }).token
    { 'Authorization': "Bearer #{token}", 'Content-Type': 'application/json' }
  end

  def header
    { 'Content-Type': 'application/json' }
  end
end

RSpec.configure do |c|
  c.include RequestHelper, type: :request
end
