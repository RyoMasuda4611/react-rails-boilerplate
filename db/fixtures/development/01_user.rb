password = 'Password1!'

User.seed_once(:id,
                  {
                    id: 1,
                    name: 'Test User',
                    email: 'admin@sample.com',
                    password: password,
                    password_confirmation: password
                  },
)
