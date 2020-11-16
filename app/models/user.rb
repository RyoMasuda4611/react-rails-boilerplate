# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  auth_token      :string           not null
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#  index_users_on_email       (email) UNIQUE
#
class User < ApplicationRecord
  attr_accessor :current_password

  has_secure_password
  has_secure_token :auth_token

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  PASSWORD_FORMAT = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x.freeze

  validates :password_confirmation, presence: true, if: -> { password.present? }
  validates :password,
            presence: true,
            format: {
              with: PASSWORD_FORMAT,
              message: I18n.t('errors.models.user.invalid_password')
            },
            confirmation: true,
            on: [:create, :inviting_accepted]
  validate :current_password_is_correct, on: :check_current_password

  before_save { self.email = email.downcase }

  # rubocop:disable Metrics/AbcSize
  def current_password_is_correct
    return true if current_password.blank? && !password_digest_changed?

    if current_password.blank?
      errors.add(:current_password, :blank)
    elsif Account.find(id).authenticate(current_password) == false
      errors.add(:current_password, :invalid)
    elsif password && !password.match(PASSWORD_FORMAT)
      errors.add(:password, I18n.t('errors.models.account.invalid_password'))
    end
  end
  # rubocop:enable Metrics/AbcSize
end
