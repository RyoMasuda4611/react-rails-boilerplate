Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      post '/sign_in' => 'user_token#create'
      post '/sign_up' => 'users#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
